大数定律和中心极限定理
============================

大数定律
-------------

大数定律：Law of large numbers。

表现形式
^^^^^^^^^^^

:math:`X_1, X_2, ...,X_n` 是独立同分布，期望为 :math:`\mu` ，勒贝格可积的随机变量构成的无穷序列（勒贝格可积性意味着期望值存在且有限），有如下收敛性：

.. math::

  \overline{X} = \frac{1}{n}(X_1 + X_2 + \cdots + X_n) \rightarrow \mu \quad as \quad n \rightarrow \infty .

弱大数定律
^^^^^^^^^^^^^^

样本均值依概率收敛于期望值。

对任意正数 :math:`\mu` ，

.. math::

  \lim_{n \rightarrow \infty} P(|\overline{X} - \mu| > \epsilon) = 0

强大数定律
^^^^^^^^^^^^^^

样本均值以概率 1 收敛于期望值。

.. math::

   P(\lim_{n \rightarrow \infty} \overline{X} = \mu) = 1


Bernoulli 大数定律
^^^^^^^^^^^^^^^^^^^^^

事件发生的 **频率** 依概率收敛于事件的总体 **概率** 。

设在 :math:`n` 次独立重复 Bernoulli 试验中，事件 :math:`X` 发生的次数为 :math:`n_x` 。
事件 :math:`X` 在每次试验中发生的总体概率为 :math:`p` 。:math:`\frac{n_x}{n}` 代表样本发生事件 :math:`X` 的频率。

大数定律可用概率极限值定义：对任意正数 :math:`\epsilon > 0` ，下式成立：

.. math::

  \lim_{n \rightarrow \infty} P(|\frac{n_x}{n} - p| < \epsilon) = 1


中心极限定理
-------------------

中心极限定理：Central limit theorem。

在适当的条件下，**大量** 相互 **独立随机变量** 的均值经适当标准化后依分布收敛于正态分布。

棣莫佛－拉普拉斯（de Moivre - Laplace）定理
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

:math:`X \sim B(n, p)` 是 :math:`n` 次 Bernoulli 试验中事件 A 出现的次数（二项分布），每次试验成功的概率为 :math:`p` 。

当 :math:`n \rightarrow \infty` ，二项分布的极限为：以 :math:`np` 为均值，:math:`np(1-p)` 为方差的正态分布。

林德伯格－列维（Lindeberg - Levy）定理
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

设随机变量 :math:`X_1, X_2, ...,X_n` 独立同分布，且具有有限的数学期望和方差（ :math:`i= 1,2,...,n` ）：

.. math::

  E[X_i] &=&\ \mu \\
  Var[X_i] &=&\ \sigma^2 \neq 0

记

.. math::

  \overline{X} &=&\ \frac{1}{n} \sum_{i=1}^n X_i \\
  \zeta_n &=&\ \frac{\overline{X} - \mu}{\sigma / \sqrt{n}}

有

.. math::

  \lim_{n \rightarrow \infty} P(\zeta_n \leqslant z) = \Phi(z)

其中 :math:`\Phi (z)` 是标准正态分布的分布函数。

参考资料
----------

1. 大数定律

  https://zh.wikipedia.org/wiki/%E5%A4%A7%E6%95%B0%E5%AE%9A%E5%BE%8B

  https://en.wikipedia.org/wiki/Law_of_large_numbers

2. 中心极限定理

  https://zh.wikipedia.org/wiki/%E4%B8%AD%E5%BF%83%E6%9E%81%E9%99%90%E5%AE%9A%E7%90%86

  https://en.wikipedia.org/wiki/Central_limit_theorem
