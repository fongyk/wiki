random
=============

random
-------------

Python 自带的 random 库。 ::

  import random

.. py:function:: random.random()
  
  生成0~1的随机浮点数。

.. py:function:: random.uniform(a,b)

  生成指定范围[a, b]内的随机浮点数。

.. py:function:: random.randint(a,b)

  生成指定范围[a, b]内的随机整数。

.. py:function:: random.randrange(start,stop,step)

  指定范围内，按step递增的集合中的随机数。

.. py:function:: random.choice(lst)

  给定的集合中选择一个元素。

.. py:function:: random.shuffle(lst)

  对一个序列或者元组随机打乱。


numpy.random
--------------

::

  import numpy as np

.. py:function:: numpy.random.random([d0, d1, ... ,dn])

  生成 0 ~ 1 的随机浮点数，维度为 :math:`d_0 \times d_1 \times ... \times d_n` （缺省为1）。

.. py:function:: numpy.random.rand(d0, d1, ... ,dn)

  生成 0 ~ 1 的随机浮点数，维度为 :math:`d_0 \times d_1 \times ... \times d_n` （缺省为1）。

.. py:function:: numpy.random.randn(d0, d1, ... ,dn)

  标准正态分布。

.. py:function:: numpy.random.randint(low, high=None, size=None, dtype='l')

  返回随机的整数，位于半开区间 ``[low, high)`` 。如果 ``high=None`` ，区间为 ``[0, low)`` 。

.. py:function:: numpy.random.choice(arr, size=None, replace=True, p=None)

  从一个给定的一维数组，按概率 p 抽样一定数量的元素， ``replace=True`` 表示允许重复元素。

.. py:function:: numpy.random.shuffle(arr)

  随机打乱 arr。

.. py:function:: numpy.random.permutation(arr)

  返回一个随机排列。

.. py:function:: numpy.random.seed(n)

  改变随机数生成器的种子。设置相同的 seed，每次生成的随机数相同；如果不设置 seed，则每次会生成不同的随机数。

.. code-block:: python
  :linenos:

  ## 注：生成的数组都是 numpy array 类型

  >>> 2.5 * np.random.randn(2, 4) + 3
  [[-0.52410303  1.68461615 -0.04895917  2.81907944]
   [ 6.89754303  2.95949232  1.85296809  1.56361545]]

  >>> np.random.randint(5, size=(2, 4))
  [[0 4 2 3]
   [0 0 4 4]]

  ## 从 np.arange(4) 选取 3 个元素
  >>> np.random.choice(4, 3)
  [3 1 2]
  >>> np.random.choice([1,3,9,0], 3)
  [9 3 0]
  >>> np.random.choice(4, 3, p=[0.1, 0.2, 0, 0.7])
  [1 3 3]

  >>> arr = np.arange(10)
  >>> np.random.shuffle(arr)
  >>> print arr
  [6 9 0 8 1 7 4 5 3 2]

  >>> np.random.permutation(10)
  [5 8 9 7 3 1 0 2 6 4]
  >>> np.random.permutation([1, 4, 9, 12, 15])
  [ 9  1  4 12 15]
  >>> arr = np.arange(9).reshape((3, 3))
  >>> np.random.permutation(arr)
  [[3 4 5]
   [6 7 8]
   [0 1 2]]

  >>> np.random.seed(1)
  >>> np.random.random()
  0.417022004702574
  >>> np.random.seed(1)
  >>> np.random.random()
  0.417022004702574
  >>> np.random.random()
  0.7203244934421581

参考资料
-----------

1. random — Generate pseudo-random numbers

  https://docs.python.org/3/library/random.html

2. Random sampling (numpy.random)

  https://numpy.org/doc/1.16/reference/routines.random.html#module-numpy.random

3. random与numpy.random

  https://www.jianshu.com/p/36a4bbb5536e

4. numpy的random模块详细解析

  https://www.cnblogs.com/zuoshoushizi/p/8727773.html
