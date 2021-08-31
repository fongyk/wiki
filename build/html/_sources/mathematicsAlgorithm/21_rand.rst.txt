随机数
==============

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
