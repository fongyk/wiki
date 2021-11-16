随机数
==============

伪随机数
----------------

现在进行随机模拟的主流方法是使用计算机实时地产生随机数，严格来说是 **伪随机数** 。伪随机数是用计算机算法产生的序列，其表现与真实的独立同分布序列很难区分开来。
因为计算机算法的结果是固定的，所以伪随机数不是真正的随机数。 但是，好的伪随机数序列与真实随机数序列表现相同，很难区分。

线性同余发生器（Linear Congruence Generator）是一种常用的产生伪随机数的方法，其递推公式为：

.. math::
    
    x_n = (ax_{n-1} + c) \mod M,\quad n = 1,2,\cdots 
    
其中 :math:`a` 和 :math:`M` 是正整数，:math:`c` 是非负整数。初值 :math:`x_0` 称为种子数（Seed）。

令 :math:`r_n = x_n / M` ，则 :math:`r_n \in [0,1)` ，可把 :math:`r_n` 作为均匀分布随机数序列。适当选取 :math:`M,a,c` 才能使得产生的随机数序列和真正的 :math:`U[0,1]` 随机数表现接近。

线性同余法的递推算法仅依赖于前一项，序列元素最多只有 :math:`M` 个可能取值，所以产生的序列一定会重复。假设重复周期为 :math:`T` ， :math:`T \leq M` ；当 :math:`T = M` ，称为满周期。
满周期时，不管初值 :math:`x_0` 取 :math:`[0, M-1]` 间的任意数，序列都从 :math:`x_M` 开始重复。 如果发生器从某个初值开始迭代不是满周期的，那么它从任何初值出发都不是满周期的。不同初值有可能得到不同序列。

下面是一个满周期 :math:`2^{31}` 的线性同余发生器，其周期较长，统计性质比较好。

.. math::
    
    x_n = (314159269 x_{n-1} + 453806245) \mod 2^{31}

取样
--------------

**问题描述** ：输入整数 :math:`m` 和 :math:`n` ，其中 :math:`m < n` ；输出 :math:`[0, n-1]` 范围内的 :math:`m` 个随机整数的有序列表，不允许重复（无放回抽样），且要求所有可能的长度为 :math:`m` 的列表出现的概率相等。

Knuth 算法
^^^^^^^^^^^^^^

.. code-block:: cpp
    :linenos:

    #include <cstdlib>
    void genKnuth(int m, int n)
    {
        for(int i = 0; i < n; ++i)
        {
            if(rand() % (n-i) < m) // p = m / (n-i)
            {
                cout << i << endl; // select i
                --m;
            }
        }
    }

这种算法需要调用 :math:`n` 次随机函数。

Knuth Shuffle
^^^^^^^^^^^^^^^^^^^

随机打乱包含整数 :math:`[0, n-1]` 的数组，然后排序输出前 :math:`m` 个元素。这种方法的缺点是需要额外 :math:`\mathcal{O}(n)` 的空间。

事实上，有人发现：只需要打乱数组的前 :math:`m` 个元素即可。

.. code-block:: cpp
    :linenos:

    void genShuffle(int m, int n)
    {
        int *x = new int[n];
        for(int i = 0; i < n; ++i) x[i] = i;
        for(int i = 0; i < m; ++i)
        {
            int j = randint(i, n-1); // 产生[i, n-1]之间的随机数
            swap(x[i], x[j]);
        }
        sort(x, x+m);
        for(int i = 0; i < m; ++i) cout << x[i] << endl;
        delete[] x;
    }


.. note::

    当 m 非常接近 n，我们可以产生长度为 n - m 的列表，然后输出不在这个列表中的整数。

Floyd 算法
^^^^^^^^^^^^^^^^^^^^^

这是一种基于集合的算法，只需要产生 :math:`m` 个随机数。

.. code-block:: cpp
    :linenos:

    void genFloyd(int m, int n)
    {
        set<int> S;
        for(int j = n-m; j < n; ++j)
        {
            int t = rand() % (j+1);
            if(S.find(t) == S.end()) S.insert(t); // t not in S
            else S.insert(j);
        }
        for(auto it = S.begin(); it != S.end(); ++it) cout << *it << endl;
    }

随机函数
--------------

rand5() 可以等概率产生 :math:`[1, 5]` 之间的整数。

利用 rand5() 生成 rand3()
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**策略** ：如果产生 :math:`1,2,3` ，则停止；如果产生 :math:`4,5` ，则继续随机。

产生 :math:`1,2,3` 中任意一个数的概率为：

.. math::

    p &=&\ \frac{1}{5} + \frac{2}{5} \times \frac{1}{5} + \frac{2}{5} \times \frac{2}{5} \times \frac{1}{5} + \cdots \\
      &=&\ \frac{1}{5} \times (1 + \frac{2}{5} + \frac{2}{5} \times \frac{2}{5} + \cdots) \\
      &=&\ \frac{1}{5} \times \frac{5}{3} \\
      &=&\ \frac{1}{3}

因此是等概率的。


利用 rand5() 生成 rand7()
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**策略** ：首先将 rand5() 映射到一个更大的区间（大于 :math:`7` ），然后套用上一个例子的方法。

- Step 1：等概率产生 :math:`[1, 25]` 之间的整数。

  .. math::

      rand25() = 5 \times (rand5() - 1) + rand5()

- Step 2：如果 rand25() 产生的数 :math:`r` 大于 :math:`21` ，则继续随机；否则返回 :math:`r \% 7 + 1` 。（如果产生的数大于 :math:`7` 就继续随机，会造成循环次数过多，因此可以找一个 :math:`7` 的倍数）


参考资料
-------------

1. 今日头条面试题：生成随机数(根据rand5()生成rand7())

  https://blog.csdn.net/leadai/article/details/79824224

2. 《编程珠玑 第2版》第12章：取样问题。

3. 均匀分布随机数生成
  
  https://www.math.pku.edu.cn/teachers/lidf/docs/statcomp/html/_statcompbook/rng-uniform.html
