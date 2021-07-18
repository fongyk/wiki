迭代器和生成器
=======================

.. image:: ./05_iterator.png
    :width: 500px
    :align: center


迭代器（iterator）
-------------------------
特点：
  - 迭代器是访问集合元素的一种方式，不能随机访问集合中的某个值，只能从头到尾依次访问（ ``next()`` 方法），访问到一半时不能往回退。

  - 不需要事先准备好整个迭代过程中的所有元素。迭代器仅仅在迭代到某个元素时才计算该元素，而在这之前或之后，元素可以不存在或者被销毁。

  - 便于循环比较大的数据集合，节省内存。

  - 不能复制一个迭代器，如果要再次（或者同时）迭代同一个对象，只能去创建另一个迭代器对象。

  .. code-block:: python
    :linenos:

    ## enumerate 返回迭代器
    a = enumerate(['a','b'])

    for i in range(2): ## 迭代两次enumerate对象
        for x, y in a:
            print x, y
        print "========"

  结果是： ::

    (0, 'a')
    (1, 'b')
    ========
    ========

  可以发现：第二次返回值为空。

可迭代对象（iterable）
^^^^^^^^^^^^^^^^^^^^^^^

**可以直接作用于for循环的对象统称为可迭代对象（Iterable）** 。只要定义了可以返回一个迭代器的 ``__iter__()`` 方法，或者定义了可以支持下标索引的 ``__getitem__()`` 方法，那么它就是一个可迭代对象。

.. code-block:: python
  :linenos:

  class Iterator_test(object):
    def __init__(self, data):
        self.data = data
        self.index = len(data)

    def __iter__(self):
        return self

    def next(self):
        if self.index <= 0:
            raise StopIteration
        self.index -= 1
        return self.data[self.index]

  iterator_winter = Iterator_test('abcde')
  for item in iterator_winter:
      print item
  ## 打印 e d c b a

  class Iterator_test2(object):
      def __init__(self, data):
          self.data = data
      def __getitem__(self, it):
          return self.data[it]
  no_iter = Iterator_test2('abcde')
  for item in no_iter:
      print item
  ## 打印 a b c d e


常见的可迭代对象：

  - 集合数据类型，如list、tuple、dict、set、str等。

  - generator，包括生成器和带yield的generator function。

**可以被next()函数调用并不断返回下一个值的对象称为迭代器（Iterator）** 。生成器都是Iterator对象，但list、dict、str虽然是Iterable，却不是Iterator。

**所有的Iterable均可以通过内置函数iter()来转变为Iterator** 。

判断一个对象是否是可迭代对象：

.. code-block:: python
  :linenos:

  from collections import Iterable
  a = [1,2,3]
  isinstance(a, Iterable) # True

  a = iter(a)
  next(a) # 或 a.next()，返回 1
  next(a) # 返回 2
  next(a) # 返回 3
  next(a) # 抛出 StopIteration 异常

一个可迭代对象是不能独立进行迭代的，Python中， 迭代是通过 ``for ... in`` 来完成的 。
for循环会不断调用迭代器对象的 ``__next__()`` 方法（python3  ``__next__()`` ；python2  ``next()`` ），每次循环，都返回迭代器对象的下一个值，直到遇到 ``StopIteration`` 异常。

任何实现了 ``__iter__()`` 和 ``__next__()`` （python2中实现 ``next()`` ）方法的对象都是迭代器， ``__iter__()`` 返回迭代器自身， ``__next__()`` 返回容器中的下一个值 。


生成器（generator）
-------------------------

生成器其实是一种特殊的迭代器。它不需要再像上面的类一样写 ``__iter__()`` 和 ``__next__()`` 方法了，只需要一个 ``yiled`` 关键字。 ``yield`` 就是return返回的一个值，并且记住这个返回的位置。下一次迭代就从这个位置开始。
生成器一定是迭代器（反之不成立），因此任何生成器也是以一种懒加载的模式生成值。

.. code-block:: python
  :linenos:

  def generator_winter():
    i = 1
    while i <= 3:
        yield i
        i += 1

  generator_iter = generator_winter() ## 函数体中的代码并不会执行，只有显示或隐示地调用next的时候才会真正执行里面的代码。
  print generator_iter.next() ## 1
  print generator_iter.next() ## 2
  print generator_iter.next() ## 3
  print generator_iter.next() ## 抛出 StopIteration 异常

**生成器表达式** （类似于列表推导式，只是把[]换成()）。

.. code-block:: python
  :linenos:

  gen = (x for x in range(10)) ## <generator object <genexpr> at 0x0000000012BC4990>
  for item in gen:
    print item

  ## fibonacci 数列
  def fibonacci(n):
    a, b = 0, 1
    while b <= n:
        yield b
        a, b = b, a+b
  f = fibonacci(10)
  for item in f:
      print item

参考资料
---------------
1. Python迭代器，生成器--精华中的精华

  https://www.cnblogs.com/deeper/p/7565571.html

2. python 生成器和迭代器有这篇就够了

  https://www.cnblogs.com/wj-1314/p/8490822.html
