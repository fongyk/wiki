随机数
==============

rand5() 可以等概率产生 :math:`[1, 5]` 之间的整数。

利用 rand5() 生成 rand3()
-------------------------------

**策略** ：如果产生 :math:`1,2,3` ，则停止；如果产生 :math:`4,5` ，则继续随机。

产生 :math:`1,2,3` 中任意一个数的概率为：

.. math::

    p &=&\ \frac{1}{5} + \frac{2}{5} \times \frac{1}{5} + \frac{2}{5} \times \frac{2}{5} \times \frac{1}{5} + \cdots \\
      &=&\ \frac{1}{5} \times (1 + \frac{2}{5} + \frac{2}{5} \times \frac{2}{5} + \cdots) \\
      &=&\ \frac{1}{5} \times \frac{5}{3} \\
      &=&\ \frac{1}{3}

因此是等概率的。


利用 rand5() 生成 rand7()
-------------------------------

**策略** ：首先将 rand5() 映射到一个更大的区间（大于 :math:`7` ），然后套用上一个例子的方法。

- Step 1：等概率产生 :math:`[1, 25]` 之间的整数。

  .. math::

      rand25() = 5 \times (rand5() - 1) + rand5()

- Step 2：如果 rand25() 产生的数 :math:`r` 大于 :math:`21` ，则继续随机；否则返回 :math:`r \% 7 + 1` 。（如果产生的数大于 :math:`7` 就继续随机，会造成循环次数过多，因此可以找一个 :math:`7` 的倍数）


参考资料
-------------

1. 今日头条面试题：生成随机数(根据rand5()生成rand7())

  https://blog.csdn.net/leadai/article/details/79824224