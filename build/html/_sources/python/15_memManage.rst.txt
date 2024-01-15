内存管理
=============

变量与对象
----------------

.. image:: ./15_varRef.png
    :width: 500px
    :align: center

（图片来源：https://www.cnblogs.com/geaozhang/p/7111961.html）

变量
  通过变量指针引用对象，变量指针指向具体对象的内存空间，取对象的值。

对象
  类型已知，每个对象都包含一个头部信息（类型标识符和引用计数器）

变量名没有类型，类型属于对象。

.. code-block:: python
    :linenos:

    >>> a = "hello"
    >>> b = "hello"
    >>> a == b
    True
    >>> a is b
    True
    >>> id(a)
    140568052594368
    >>> id(a)
    140568052594368

    >>> a = "hello world"
    >>> b = "hello world"
    >>> a == b
    True
    >>> a is b
    False
    >>> id(a)
    140568052594752
    >>> id(a)
    140568052594320

    >>> a = [1,2,3]
    >>> b = a
    >>> a == b
    True
    >>> a is b
    True

.. note::

  Python 缓存了整数和短字符串，因此每个对象在内存中只存有一份，赋值语句只是创造新的引用，而不是对象。

  Python 没有缓存长字符串、列表及其他对象，可以有多个相同的对象，赋值语句创建出新的对象。


变量的改变
^^^^^^^^^^^^^^

不可变对象
  赋值、加减乘除这些操作实际上导致变量指向的对象发生了改变（已经不是指向原来的那个对象了），并不是通过这个变量来改变它指向的对象的值。

.. code-block:: python
    :linenos:

    >>> a = 10
    >>> id(a)
    21856416
    >>> a = a - 1
    >>> id(a)
    21856440
    >>> a *= 2
    >>> id(a)
    21856224

可变对象
  对于list、dict对象，此时变量的指向没有改变。

.. code-block:: python
    :linenos:

    >>> a = []
    >>> id(a)
    140568052448936
    >>> a.append(1)
    >>> id(a)
    140568052448936



引用计数
---------------

::

  from sys import getrefcount

使用 ``sys`` 包中的 ``getrefcount()`` ，来查看某个对象的引用计数。
需要注意的是，当使用某个引用作为参数，传递给 ``getrefcount()`` 时，参数实际上创建了一个临时的引用。
因此， ``getrefcount()`` 所得到的结果，会比期望的多 1。


普通引用
^^^^^^^^^^^^

.. code-block:: python
  :linenos:

  >>> a = [1,2,3]
  >>> getrefcount(a)
  2
  >>> b = a
  >>> getrefcount(a)
  3
  >>> getrefcount(b)
  3
  >>> del b
  >>> getrefcount(a)
  2


  >>> getrefcount(1)
  2418
  >>> n = 1
  >>> getrefcount(1)
  2419
  >>> m = n
  >>> getrefcount(1)
  2420
  >>> del n
  >>> getrefcount(1)
  2419
  >>> n = [1,2,3]
  >>> getrefcount(1)
  2420
  >>> m = 2
  >>> getrefcount(1)
  2419


容器对象
^^^^^^^^^^^^

Python的容器对象（Container），比如列表、元组、字典等，可以包含多个对象。 **容器对象中包含的并不是元素对象本身，是指向各个元素对象的引用。**

.. code-block:: python
  :linenos:

  >>> a = [1,2,3]
  >>> getrefcount(a)
  2
  >>> b = [a, a]
  >>> getrefcount(a)
  4


循环引用
^^^^^^^^^^^^

只有容器对象才会产生循环引用的情况，比如列表、字典、用户自定义类的对象、元组等。而像数字、字符串这类简单类型不会出现循环引用。

.. code-block:: python
  :linenos:

  >>> a = []
  >>> t = [a]
  >>> getrefcount(a)
  3
  >>> a.append(t)
  >>> getrefcount(a)
  9


垃圾回收
---------------

.. code-block:: python

  >>> import gc
  >>> print gc.get_threshold()
  (700, 10, 10)
  ## 700 是垃圾回收启动的阈值，10 是与分代回收相关的阈值

当 Python 的某个对象的引用计数降为 0 时，说明没有任何引用指向该对象，该对象就成为要被回收的垃圾了。
频繁的垃圾回收（Garbage Collection），将大大降低 Python 的工作效率。
如果内存中的对象不多，就没有必要总启动垃圾回收。所以，Python 只会在特定条件下，自动启动垃圾回收。

当 Python 运行时，会记录其中分配对象（Object Allocation）和取消分配对象（Object Deallocation）的次数。
当两者的差值高于某个阈值时，垃圾回收才会启动，清除那些引用计数为 0 的对象。


垃圾检查
^^^^^^^^^^^^^

``gc.get_count()`` 获取一个三元组，如 ``(488, 3, 0)`` 。

  - ``488`` 是指距离上一次0代垃圾检查，Python 分配内存的数目减去释放内存的数目。

  - ``3`` 是指距离上一次1代垃圾检查，0 代垃圾检查的次数。

  - ``0`` 是指距离上一次2代垃圾检查，1 代垃圾检查的次数。


分代回收
^^^^^^^^^^^^

Python 将所有的对象分为 0，1，2 三代。所有的新建对象都是 0 代对象。当某一代对象经历过垃圾回收，依然存活，那么它就被归入下一代对象。
垃圾回收启动时，一定会扫描所有的 0 代对象。如果 0 代经过一定次数垃圾回收，那么就启动对 0 代和 1 代的扫描清理。
当 1 代也经历了一定次数的垃圾回收后，那么会启动对 0、1、2，即对所有对象进行扫描。

``(700, 10, 10)`` 表明：每 10 次 0 代垃圾回收，会配合 1 次 1 代的垃圾回收；每 10 次 1 代的垃圾回收，才会有 1 次的 2 代垃圾回收。


标记-清除
^^^^^^^^^^^^^^^^^^^^^^^^

Python采用了“标记-清除”(Mark and Sweep)算法，解决容器对象可能产生的循环引用问题。

- 标记阶段：遍历所有的对象，如果是可达的（Reachable），也就是还有对象引用它，那么就标记该对象为可达；

- 清除阶段：再次遍历对象，如果发现某个对象没有标记为可达，则就将其回收。


参考资料
-----------

1. Python内存管理机制

  https://www.cnblogs.com/geaozhang/p/7111961.html

2. Python的内存管理

  https://www.cnblogs.com/vamei/p/3232088.html

3. Python垃圾回收机制详解

  https://www.cnblogs.com/Xjng/p/5128269.html

4. 聊聊Python内存管理

  https://andrewpqc.github.io/2018/10/08/python-memory-management/

5. [Python]内存管理

  https://chenrudan.github.io/blog/2016/04/23/pythonmemorycontrol.html
