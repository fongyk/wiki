random
=============

random
-------------
python自带的random库。 ::

  import random

- **random.random()**

  - 生成0~1的随机浮点数。

- **random.uniform(a,b)**

  - 生成指定范围[a, b]内的随机浮点数。

- **random.randint(a,b)**

  - 生成指定范围[a, b]内的随机整数。

- **random.randrange(start,stop,step)**

  - 指定范围内，按step递增的集合中的随机数。

- **random.choice(lst)**

  - 给定的集合中选择一个元素。

- **random.shuffle(lst)**

  - 对一个序列或者元组随机打乱。


numpy.random
--------------

::

  import numpy as np

- **numpy.random.random([** :math:`d_0, d_1, ... ,d_n` **])**

  - 生成0~1的随机浮点数，维度为 :math:`d_0 \times d_1 \times ... \times d_n` （缺省为1）。

- **numpy.random.rand(** :math:`d_0, d_1, ... ,d_n` **)**

  - 生成0~1的随机浮点数，维度为 :math:`d_0 \times d_1 \times ... \times d_n` （缺省为1）。

- **numpy.random.randn(** :math:`d_0, d_1, ... ,d_n` **)**

  - 标准正态分布。

- **numpy.random.randint(low, high=None, size=None, dtype='l')**

  - 返回随机的整数，位于半开区间 [low, high)。如果high=None，区间为[0, low)。

- **numpy.random.choice(arr, size=None, replace=True, p=None)**

  - 从一个给定的一维数组，按概率p抽样一定数量的元素，replace=True表示允许重复元素。

- **numpy.random.shuffle(arr)**

  - 随机打乱arr。

- **numpy.random.permutation(arr)**

  - 返回一个随机排列。

- **numpy.random.seed(n)**

  - 改变随机数生成器的种子。设置相同的seed，每次生成的随机数相同；如果不设置seed，则每次会生成不同的随机数。

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

1. random与numpy.random

  https://www.jianshu.com/p/36a4bbb5536e

2. numpy的random模块详细解析

  https://www.cnblogs.com/zuoshoushizi/p/8727773.html
