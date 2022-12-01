蓄水池抽样
=============

**问题描述** ：随机从一个数据流中选取1个或k个数，保证每个数被选中的概率是相同的。数据流的长度 :math:`n` 未知或者是非常大。


随机选择1个数
-----------------------

在数据流中，依次以概率 :math:`1` 选择第一个数，以概率 :math:`\frac{1}{2}` 选择第二个数（替换已选中的数），...，依此类推，以概率 :math:`\frac{1}{m}` 选择第 m 个数（替换已选中的数）。
结束时（遍历完了整个数据流），每个数被选中的概率都是 :math:`\frac{1}{n}` 。证明::

  第 m 个对象最终被选中的概率 = 选择第 m 个数的概率 x 后续所有数都不被选择的概率

即

.. math::

    P = \frac{1}{m} \times \left( \frac{m}{m+1} \times \frac{m+1}{m+2} \times \cdots \times \frac{n-1}{n} \right) = \frac{1}{n}.

.. code-block:: cpp
  :linenos:

  #include <iostream>
  #include <vector>
  #include <utility> // swap
  #include <ctime>
  #include <cstdlib> // rand, srand
  using namespace std;

  typedef vector<int> VecInt;
  typedef VecInt::iterator Itr;
  typedef VecInt::const_iterator CItr;

  // 等概率产生区间 [a, b] 之间的随机数
  int RandInt(int a, int b)
  {
    if (a > b) swap(a, b);
    return a + rand() % (b - a + 1);
  }

  bool Sample(const VecInt data, int &result)
  {
    if (data.size() <= 0) return false;

    //srand(time(nullptr)); // 设置随机seed

    CItr it = data.begin();
    result = *it;
    int m;
    for (m = 1, it = data.begin() + 1; it != data.end(); ++m, ++it)
    {
      int ri = RandInt(0, m); // ri < 1 的概率为 1/(m+1)
      if (ri < 1) result = *it;
    }
    return true;
  }


随机选择k个数
------------------

在数据流中，先把读到的前 k 个数放入“池”中，然后依次以概率 :math:`\frac{k}{k+1}` 选择第 k+1 个数，以概率 :math:`\frac{k}{k+2}` 选择第 k+2 个数，...，
以概率 :math:`\frac{k}{m}` 选择第 m 个数（m > k）。如果某个数被选中，则 **随机替换** “池”中的一个数。最终每个数被选中的概率都为 :math:`\frac{k}{n}` 。
证明::

  第 m 个对象最终被选中的概率 = 选择第 m 个数的概率 x（其后元素不被选择的概率 + 其后元素被选择的概率 x 不替换第 m 个数的概率）

即

.. math::

    P &=\ \frac{k}{m} \times \left[ \left( (1-\frac{k}{m+1}) + \frac{k}{m+1} \times \frac{k-1}{k}  \right) \times \left( (1-\frac{k}{m+2}) + \frac{k}{m+2} \times \frac{k-1}{k}  \right) \times \right. \\
      &  \ \quad \left. \cdots \times \left( (1-\frac{k}{n}) + \frac{k}{n} \times \frac{k-1}{k}  \right) \right] \\
      &=\ \frac{k}{m} \times \frac{m}{m+1} \times \frac{m+1}{m+2} \times \cdots \times \frac{n-1}{n} \\
      &=\ \frac{k}{n}.


.. code-block:: cpp
  :linenos:

  #include <iostream>
  #include <vector>
  #include <utility> // swap
  #include <ctime>
  #include <cstdlib> // rand, srand
  using namespace std;

  typedef vector<int> VecInt;
  typedef VecInt::iterator Itr;
  typedef VecInt::const_iterator CItr;

  const int k = 10;
  int result[k];

  // 等概率产生区间 [a, b] 之间的随机数
  int RandInt(int a, int b)
  {
    if (a > b) swap(a, b);
    return a + rand() % (b - a + 1);
  }

  bool Sample(const VecInt data)
  {
    if (data.size() < k) return false;

    //srand(time(nullptr)); // 设置随机seed

    CItr it = data.begin();
    for(int m = 0; m < k; ++m) result[m] = *it++;

    for (int m = k; it != data.end(); ++m, ++it)
    {
      int ri = RandInt(0, m);
      if (ri < k) result[ri] = *it; // ri < k 的概率为 k/(m+1)
    }
    return true;
  }


参考资料
--------------

1. 蓄水池抽样——《编程珠玑》读书笔记

  https://blog.csdn.net/huagong_adu/article/details/7619665
