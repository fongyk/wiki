bisect
============

bisect 模块用于维护有序列表，核心思想是采用二分法来进行搜索和插入。


函数
-----------

::

    >>> import bisect
    >>> dir(bisect)
    ['__builtins__', '__cached__', '__doc__', '__file__', '__loader__', '__name__', '__package__', '__spec__', 'bisect', 'bisect_left', 'bisect_right', 'insort', 'insort_left', 'insort_right']

.. py:function:: bisect_left(a, x, lo=0, hi=len(a))
    
    返回 x 的插入位置，如果 a 中已经存在 x ，则返回最左侧 x 的位置。设该位置为 i ，则 ``all(val < x for val in a[lo:i]), all(val >= x for val in a[i:hi])`` 。

.. py:function:: bisect_right(a, x, lo=0, hi=len(a))
    
    返回 x 的插入位置，如果 a 中已经存在 x ，则返回最右侧 x 的下一个位置。设该位置为 i ，则 ``all(val <= x for val in a[lo:i]), all(val > x for val in a[i:hi])`` 。

.. py:function:: bisect(a, x, lo=0, hi=len(a))
    
    同 ``bisect_right`` 。

.. py:function:: insort_left(a, x, lo=0, hi=len(a))
    
    等效于 ``a.insert(bisect.bisect_left(a, x, lo, hi), x)`` 。

.. py:function:: insort_right(a, x, lo=0, hi=len(a))
    
    等效于 ``a.insert(bisect.bisect_right(a, x, lo, hi), x)`` 。

.. py:function:: insort(a, x, lo=0, hi=len(a))
    
    同 ``insort_right`` 。


搜索有序表
-------------

.. code-block:: python
    :linenos:

    def index(a, x):
        'Locate the leftmost value exactly equal to x'
        i = bisect_left(a, x)
        if i != len(a) and a[i] == x:
            return i
        raise ValueError

    def find_lt(a, x):
        'Find rightmost value less than x'
        i = bisect_left(a, x)
        if i:
            return a[i-1]
        raise ValueError

    def find_le(a, x):
        'Find rightmost value less than or equal to x'
        i = bisect_right(a, x)
        if i:
            return a[i-1]
        raise ValueError

    def find_gt(a, x):
        'Find leftmost value greater than x'
        i = bisect_right(a, x)
        if i != len(a):
            return a[i]
        raise ValueError

    def find_ge(a, x):
        'Find leftmost item greater than or equal to x'
        i = bisect_left(a, x)
        if i != len(a):
            return a[i]
        raise ValueError


示例
------------

.. code-block:: python
    :linenos:

    >>> def grade(score, breakpoints=[60, 70, 80, 90], grades='FDCBA'):
    ...     i = bisect(breakpoints, score)
    ...     return grades[i]
    ...
    >>> [grade(score) for score in [33, 99, 77, 70, 89, 90, 100]]
    ['F', 'A', 'C', 'C', 'B', 'A', 'A']


附：源码
-------------

.. code-block:: python
    :linenos:

    """Bisection algorithms."""

    def insort_right(a, x, lo=0, hi=None):
        """Insert item x in list a, and keep it sorted assuming a is sorted.
        If x is already in a, insert it to the right of the rightmost x.
        Optional args lo (default 0) and hi (default len(a)) bound the
        slice of a to be searched.
        """

        lo = bisect_right(a, x, lo, hi)
        a.insert(lo, x)

    def bisect_right(a, x, lo=0, hi=None):
        """Return the index where to insert item x in list a, assuming a is sorted.
        The return value i is such that all e in a[:i] have e <= x, and all e in
        a[i:] have e > x.  So if x already appears in the list, a.insert(x) will
        insert just after the rightmost x already there.
        Optional args lo (default 0) and hi (default len(a)) bound the
        slice of a to be searched.
        """

        if lo < 0:
            raise ValueError('lo must be non-negative')
        if hi is None:
            hi = len(a)
        while lo < hi:
            mid = (lo+hi)//2
            if x < a[mid]: hi = mid
            else: lo = mid+1
        return lo

    def insort_left(a, x, lo=0, hi=None):
        """Insert item x in list a, and keep it sorted assuming a is sorted.
        If x is already in a, insert it to the left of the leftmost x.
        Optional args lo (default 0) and hi (default len(a)) bound the
        slice of a to be searched.
        """

        lo = bisect_left(a, x, lo, hi)
        a.insert(lo, x)


    def bisect_left(a, x, lo=0, hi=None):
        """Return the index where to insert item x in list a, assuming a is sorted.
        The return value i is such that all e in a[:i] have e < x, and all e in
        a[i:] have e >= x.  So if x already appears in the list, a.insert(x) will
        insert just before the leftmost x already there.
        Optional args lo (default 0) and hi (default len(a)) bound the
        slice of a to be searched.
        """

        if lo < 0:
            raise ValueError('lo must be non-negative')
        if hi is None:
            hi = len(a)
        while lo < hi:
            mid = (lo+hi)//2
            if a[mid] < x: lo = mid+1
            else: hi = mid
        return lo

    # Overwrite above definitions with a fast C implementation
    try:
        from _bisect import *
    except ImportError:
        pass

    # Create aliases
    bisect = bisect_right
    insort = insort_right


参考资料
-----------

1. bisect — Array bisection algorithm

  https://docs.python.org/3/library/bisect.html

  https://github.com/python/cpython/blob/3.8/Lib/bisect.py

2. Python 的 bisect 模块

  https://www.jianshu.com/p/b626dbaa1200