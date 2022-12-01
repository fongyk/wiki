lambda用法
===============

使用： ::

  lambda [arg1[, arg2, ... argN]]: expression

特性：
  - 匿名函数。函数没有名字。

  - 输入是 arg list，输出是根据 expression 计算得到的值。

  - 功能简单。

使用场景
----------

1. 将 lambda 函数赋值给一个变量，通过这个变量间接调用该函数。

.. code-block:: python
  :linenos:

  >>> plus = lambda x, y: x+y
  >>> plus(1,2)
  3

2. 将 lambda 函数赋值给其他函数，从而屏蔽其他函数本来的功能。

3. 将 lambda 函数作为其他函数的返回值（内部函数）。

4. 将 lambda 函数作为参数传递给其他函数。

  - **map** ：将序列中的元素通过处理函数处理后返回一个新的列表。

  - **filter** ：将序列中的元素通过函数过滤后返回一个新的列表。

  - **reduce** ：将序列中的元素通过一个二元函数处理返回一个结果。

  - **sorted** ：结合 lambda 对列表进行排序。 ``sorted(iterable, cmp=None, key=None, reverse=False)``

.. code-block:: python
  :linenos:

  >>> a = [1, 2, 6, 5, 2, -8, -5, -1, -10]

  ## 每个元素加1
  >>> b = map(lambda x: x+1, a) # [2, 3, 7, 6, 3, -7, -4, 0, -9]

  ## 提取序列中大于0的数
  >>> c = filter(lambda x:x>0, a) # [1, 2, 6, 5, 2]

  ## 返回所有元素相乘的结果
  >>> d = reduce(lambda x, y: x*y, a) # 48000

  ## 负数排在正数前面，同时绝对值大的排在后面
  ## 两个key，先按第一个key排序，若第一个key相同则按下一个key排序
  >>> e = sorted(a, key=lambda x:(x>0, abs(x))) # [-1, -5, -8, -10, 1, 2, 2, 5, 6]

.. note::

    在 Python3 中，**map** 和 **filter** 返回的不再是列表，而是对应的 map object 和 filter object，需要手动转化为列表。 **reduce** 函数已经被从全局名字空间里移除了，它现在被放置在 **functools** 模块里::

      from functools import reduce




参考资料
--------------

1. 关于Python中的lambda，这可能是你见过的最完整的讲解

  https://blog.csdn.net/zjuxsl/article/details/79437563

2. 在Python中使用lambda高效操作列表的教程

  https://www.cnblogs.com/mxp-neu/articles/5316557.html
