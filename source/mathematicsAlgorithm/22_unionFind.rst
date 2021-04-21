并查集
=========

并查集是一种树形的数据结构，顾名思义，它用于处理一些不相交集合（Disjoint Set）的合并及查询问题。它支持两种操作：

- 合并（Union）：把两个不相交的集合合并为一个集合。

- 查询（Find）：查询两个元素是否在同一个集合中。

并查集不支持集合的分离，但是并查集在经过修改后可以支持集合中单个元素的删除操作。

并查集的重要思想在于，用集合中的一个元素（根节点）代表集合。


简单版本
-----------

初始化
^^^^^^^^^^

假设有 :math:`n` 个元素，用一个数组 parent[] 来存储每个元素的父节点；初始时，将它们的父节点设为自己。

.. code-block:: cpp
    :linenos:

    int parent[MAXN];
    inline void init(const int n)
    {
      for(int i = 0; i <= n; ++i) parent[i] = i;
    }

查询
^^^^^^^^^^

用递归的写法实现对 **代表元素** 的查询：层层向上访问父节点，直至根节点（根节点的标志就是：父节点是本身）。要判断两个元素是否属于同一个集合，只需要看它们的根节点是否相同即可。

.. code-block:: cpp
    :linenos:

    inline int find(const int x)
    {
      if(parent[x] == x) return x;
      else return find(parent[x]);
    }



合并
^^^^^^^^^^

先找到两个集合的代表元素，然后将前者的父节点设为后者即可（当然也可以将后者的父节点设为前者）。

.. code-block:: cpp
    :linenos:

    inline void union(const int x, const int y)
    {
      parent[find(x)] = find(y);
    }


路径压缩
-------------

简单版本的并查集效率是比较低的，因为集合合并可能会导致树结构深度越来越深，想要从底部找到根节点代价会变得越来越大。

既然我们只关心一个元素对应的根节点，那我们希望每个元素到根节点的路径尽可能短（最好只需要一步）。只要我们在查询的过程中，把沿途的每个节点的父节点都设为根节点即可。这样一来，下次查询的效率就很高。

.. code-block:: cpp
    :linenos:

    inline int find(const int x)
    {
      if(parent[x] == x) return x;
      else
      {
        parent[x] = find(parent[x]);
        return parent[x];
      }
    }


启发式合并
-------------

合并可能会使树的深度（树中最长链的长度）加深，原来的树中每个元素到根节点的距离都变长了，之后寻找根节点的路径也就会相应变长。虽然有路径压缩，但路径压缩也是会消耗时间的。

启发式合并方法：把简单的树往复杂的树上合并。因为这样合并后，到根节点距离变长的节点个数比较少。

用一个数组 rank[] 记录每个根节点对应的树的深度（非根节点的 rank 相当于以它为根节点的子树的深度）。初始时，把所有元素的 rank（秩）设为 1；合并时把 rank 较小的树往较大的树上合并。

.. code-block:: cpp
    :linenos:

    inline void init(const int n)
    {
      for(int i = 0; i <= n; ++i)
      {
        parent[i] = i;
        rank[i] = i;
      }
    }

    inline void union(const int x, const int y)
    {
      const int rx = find(x);
      const int ry = find(y);
      if(rank[rx] <= rank[ry]) parent[rx] = ry;
      else parent[ry] = rx;
      if(rank[rx] == rank[ry] && rx != ry) rank[ry]++; // 如果深度相同且根节点不同，则新的根节点的深度 +1
    }

由于每一次查询都是对树的一次重构，会把叶节点以及其所有的祖先全部变成根节点的子节点，因此 rank 会失真，无法反应真实的树高。还有一种启发式合并方法是：把节点少的树往节点多的树上合并。

复杂度
-------------

简单来说，对于有 :math:`n` 个元素的并查集，空间复杂度是 :math:`\mathcal{O}(n)` ；:math:`m` 次合并、查询操作的摊还时间是 :math:`\mathcal{O}(m \log^* n)`，其中 :math:`\log^*` 是迭代对数（iterated logarithm）。


Python 参考代码
---------------------

.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Code}`

  .. code-block:: python
    :linenos:

    """
    A union-find disjoint set data structure.
    """

    # 2to3 sanity
    from __future__ import (
        absolute_import, division, print_function, unicode_literals,
    )

    # Third-party libraries
    import numpy as np


    class UnionFind(object):
        """Union-find disjoint sets datastructure.
        Union-find is a data structure that maintains disjoint set
        (called connected components or components in short) membership,
        and makes it easier to merge (union) two components, and to find
        if two elements are connected (i.e., belong to the same
        component).
        This implements the "weighted-quick-union-with-path-compression"
        union-find algorithm.  Only works if elements are immutable
        objects.
        Worst case for union and find: :math:`(N + M \log^* N)`, with
        :math:`N` elements and :math:`M` unions. The function
        :math:`\log^*` is the number of times needed to take :math:`\log`
        of a number until reaching 1. In practice, the amortized cost of
        each operation is nearly linear [1]_.
        Terms
        -----
        Component
            Elements belonging to the same disjoint set
        Connected
            Two elements are connected if they belong to the same component.
        Union
            The operation where two components are merged into one.
        Root
            An internal representative of a disjoint set.
        Find
            The operation to find the root of a disjoint set.
        Parameters
        ----------
        elements : NoneType or container, optional, default: None
            The initial list of elements.
        Attributes
        ----------
        n_elts : int
            Number of elements.
        n_comps : int
            Number of distjoint sets or components.
        Implements
        ----------
        __len__
            Calling ``len(uf)`` (where ``uf`` is an instance of ``UnionFind``)
            returns the number of elements.
        __contains__
            For ``uf`` an instance of ``UnionFind`` and ``x`` an immutable object,
            ``x in uf`` returns ``True`` if ``x`` is an element in ``uf``.
        __getitem__
            For ``uf`` an instance of ``UnionFind`` and ``i`` an integer,
            ``res = uf[i]`` returns the element stored in the ``i``-th index.
            If ``i`` is not a valid index an ``IndexError`` is raised.
        __setitem__
            For ``uf`` and instance of ``UnionFind``, ``i`` an integer and ``x``
            an immutable object, ``uf[i] = x`` changes the element stored at the
            ``i``-th index. If ``i`` is not a valid index an ``IndexError`` is
            raised.
        .. [1] http://algs4.cs.princeton.edu/lectures/
        """

        def __init__(self, elements=None):
            self.n_elts = 0  # current num of elements
            self.n_comps = 0  # the number of disjoint sets or components
            self._next = 0  # next available id
            self._elts = []  # the elements
            self._indx = {}  #  dict mapping elt -> index in _elts
            self._par = []  # parent: for the internal tree structure
            self._siz = []  # size of the component - correct only for roots

            if elements is None:
                elements = []
            for elt in elements:
                self.add(elt)


        def __repr__(self):
            return  (
                '<UnionFind:\n\telts={},\n\tsiz={},\n\tpar={},\nn_elts={},n_comps={}>'
                .format(
                    self._elts,
                    self._siz,
                    self._par,
                    self.n_elts,
                    self.n_comps,
                ))

        def __len__(self):
            return self.n_elts

        def __contains__(self, x):
            return x in self._indx

        def __getitem__(self, index):
            if index < 0 or index >= self._next:
                raise IndexError('index {} is out of bound'.format(index))
            return self._elts[index]

        def __setitem__(self, index, x):
            if index < 0 or index >= self._next:
                raise IndexError('index {} is out of bound'.format(index))
            self._elts[index] = x

        def add(self, x):
            """Add a single disjoint element.
            Parameters
            ----------
            x : immutable object
            Returns
            -------
            None
            """
            if x in self:
                return
            self._elts.append(x)
            self._indx[x] = self._next
            self._par.append(self._next)
            self._siz.append(1)
            self._next += 1
            self.n_elts += 1
            self.n_comps += 1

        def find(self, x):
            """Find the root of the disjoint set containing the given element.
            Parameters
            ----------
            x : immutable object
            Returns
            -------
            int
                The (index of the) root.
            Raises
            ------
            ValueError
                If the given element is not found.
            """
            if x not in self._indx:
                raise ValueError('{} is not an element'.format(x))

            p = self._indx[x]
            while p != self._par[p]:
                # path compression
                q = self._par[p]
                self._par[p] = self._par[q]
                p = q
            return p

        def connected(self, x, y):
            """Return whether the two given elements belong to the same component.
            Parameters
            ----------
            x : immutable object
            y : immutable object
            Returns
            -------
            bool
                True if x and y are connected, false otherwise.
            """
            return self.find(x) == self.find(y)

        def union(self, x, y):
            """Merge the components of the two given elements into one.
            Parameters
            ----------
            x : immutable object
            y : immutable object
            Returns
            -------
            None
            """
            # Initialize if they are not already in the collection
            for elt in [x, y]:
                if elt not in self:
                    self.add(elt)

            xroot = self.find(x)
            yroot = self.find(y)
            if xroot == yroot:
                return
            if self._siz[xroot] < self._siz[yroot]:
                self._par[xroot] = yroot
                self._siz[yroot] += self._siz[xroot]
            else:
                self._par[yroot] = xroot
                self._siz[xroot] += self._siz[yroot]
            self.n_comps -= 1

        def component(self, x):
            """Find the connected component containing the given element.
            Parameters
            ----------
            x : immutable object
            Returns
            -------
            set
            Raises
            ------
            ValueError
                If the given element is not found.
            """
            if x not in self:
                raise ValueError('{} is not an element'.format(x))
            elts = np.array(self._elts)
            vfind = np.vectorize(self.find)
            roots = vfind(elts)
            return set(elts[roots == self.find(x)])

        def components(self):
            """Return the list of connected components.
            Returns
            -------
            list
                A list of sets.
            """
            elts = np.array(self._elts)
            vfind = np.vectorize(self.find)
            roots = vfind(elts)
            distinct_roots = set(roots)
            return [set(elts[roots == root]) for root in distinct_roots]
            # comps = []
            # for root in distinct_roots:
            #     mask = (roots == root)
            #     comp = set(elts[mask])
            #     comps.append(comp)
            # return comps

        def component_mapping(self):
            """Return a dict mapping elements to their components.
            The returned dict has the following semantics:
                `elt -> component containing elt`
            If x, y belong to the same component, the comp(x) and comp(y)
            are the same objects (i.e., share the same reference). Changing
            comp(x) will reflect in comp(y).  This is done to reduce
            memory.
            But this behaviour should not be relied on.  There may be
            inconsitency arising from such assumptions or lack thereof.
            If you want to do any operation on these sets, use caution.
            For example, instead of
            ::
                s = uf.component_mapping()[item]
                s.add(stuff)
                # This will have side effect in other sets
            do
            ::
                s = set(uf.component_mapping()[item]) # or
                s = uf.component_mapping()[item].copy()
                s.add(stuff)
            or
            ::
                s = uf.component_mapping()[item]
                s = s | {stuff}  # Now s is different
            Returns
            -------
            dict
                A dict with the semantics: `elt -> component contianing elt`.
            """
            elts = np.array(self._elts)
            vfind = np.vectorize(self.find)
            roots = vfind(elts)
            distinct_roots = set(roots)
            comps = {}
            for root in distinct_roots:
                mask = (roots == root)
                comp = set(elts[mask])
                comps.update({x: comp for x in comp})
                # Change ^this^, if you want a different behaviour:
                # If you don't want to share the same set to different keys:
                # comps.update({x: set(comp) for x in comp})
            return comps

参考资料
-------------

1. 算法学习笔记(1) : 并查集

  https://zhuanlan.zhihu.com/p/93647900

2. 并查集

  https://oi-wiki.org/ds/dsu/

3. 并查集入门

  https://segmentfault.com/a/1190000004023326

4. github

  https://github.com/deehzee/unionfind/blob/master/unionfind.py

  https://github.com/wjakob/dset

  https://github.com/angusb/Union-Find

5. Disjoint-set data structure

  https://en.wikipedia.org/wiki/Disjoint-set_data_structure
