__new__ 和 __init__
=====================

老式类与新式类
----------------

Python 2.x 中类的定义分为新式定义和老式定义两种。
老式类定义时默认是继承自 ``type`` ，而新式类在定义时显示地继承 ``object`` 类。

.. code-block:: python
  :linenos:

  class A: ## 老式类
    pass

  class B(object): ## 新式类
    pass

.. code-block:: python
  :linenos:

  >>> print A.__bases__
  ()
  >>> print dir(A)
  ['__doc__', '__module__']

  >>> print B.__bases__
  (<type 'object'>,)
  >>> print dir(B)
  ['__class__', '__delattr__', '__dict__', '__doc__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__']
  >>> print B.__class__
  <type 'type'>

Python 3.x中没有新式类和老式类之分，它们都继承自 ``object`` 类，因此可以不用显示地指定其基类。


老式类
-----------

老式类中其实并没有 ``__new__`` 方法，因为 ``__init__`` 就是它的构造方法（函数）。即使重写 ``__new__`` 方法，也永远不会执行。

``__init__`` 只能返回 ``None``。


新式类
---------

功能
^^^^^^^^^^^

新式类中，``__new__`` （构造函数）单独地 **创建** 一个对象，而 ``__init__`` （初始化函数）负责 **初始化** 这个对象。

- ``__new__`` 至少要有一个参数 ``cls``，代表要实例化的类，此参数在实例化时由Python解释器自动提供。

- ``__init__`` 有一个参数 ``self``，就是 ``__new__`` 返回的实例，``__init__`` 在 ``__new__`` 的基础上可以完成一些其它初始化的动作，``__init__`` 不需要返回值（或者说返回 ``None`` ）。


返回值
^^^^^^^^^^^^^^^^

``__init__`` 只能返回  ``None``。

``__new__`` 返回创建的实例对象并传递给 ``__init__`` 的 ``self`` 参数。如果 ``__new__`` 没有返回值，或者没有正确返回 **当前类** ``cls`` 的实例，则 ``__init__`` 不会被调用。

.. code-block:: python
  :linenos:

  class A(object):

    def __new__(cls):
        print "A.__new__ called"
        print cls
        return super(A, cls).__new__(cls)

    def __init__(self):
        print "A.__init__ called"

.. code-block:: python
  :linenos:

  >>> a = A()
  A.__new__ called
  <class '__main__.A'> ## cls
  A.__init__ called

  >>> a.__class__     ## type(a)
  <class '__main__.A'>
  >>> A.__class__
  <type 'type'>


``__new__`` 返回父类的对象：

.. code-block:: python
  :linenos:

  class A(object):
    pass

  class B(A):
    def __new__(cls):
      print "B.__new__ called"
      return A() ## 或者写为： return super(B,cls).__new__(A)

    def __init__(self):  ## 不会被调用
      print "B.__init__ called"

.. code-block:: python
  :linenos:

  >>> b = B()
  B.__new__ called
  >>> print type(b)
  <class '__main__.A'>



__new__ 实现单例
^^^^^^^^^^^^^^^^^^^^^^^^^

单例（singleton）：类只有一个对象。``None`` 就是一个单例，所有的变量只要是 ``None`` ，它一定和 ``None`` 指向同一个内存地址。

.. code-block:: python
  :linenos:

  class Singleton(object):
    _instance = None
    def __new__(cls, *args, **kwargs):
        if cls._instance is None:
            cls._instance = super(Singleton, cls).__new__(cls)

        return cls._instance

    def __init__(self, *args, **kwargs):
		pass


.. code-block:: python
  :linenos:

  >>> s1 = Singleton()
  >>> print id(s1)
  317973448
  >>> s2 = Singleton()
  >>> print id(s2)
  317973448

.. code-block:: python
  :linenos:
  
  import threading
 
  class Singleton(object):
      _instance_lock = threading.Lock()
 
      def __new__(cls, *args, **kwargs):
          if not hasattr(cls, '_instance'):
              with cls._instance_lock:  # 加锁，线程安全
                  cls._instance = super(Singleton, cls).__new__(cls)
          return cls._instance

      def __init__(self, x):
          self.x = x

  def task(arg):
      obj = Singleton(arg)
      print(obj)
 
  for _x in range(10):
      t = threading.Thread(target=task, args=(_x,))
      t.start()


附：__repr__ 和 __str__
------------------------

.. code-block:: python
  :linenos:

  class Base(object):
      def __init__(self, name="fong"):
          self.name = name

  class A(Base):
      def __repr__(self):
          return "Class A(%s)" % self.name

  class B(Base):
      def __str__(self):
          return "Class B(%s)" % self.name

.. code-block:: python
  :linenos:

  >>> a = A()
  >>> a
  Class A(fong)
  >>> print a
  Class A(fong)

  >>> b = B()
  >>> b
  <B object at 0x0000000012B7FB70>
  >>> print b
  Class B(fong)



参考资料
---------------

1. 深入理解Python中的 __new__ 和 __init__

  https://blog.csdn.net/luoweifu/article/details/82732313

2. 详解Python中的 __init__ 和 __new__（静态方法）

  https://www.cnblogs.com/nyist-xsk/p/8286941.html

3. Python面试之理解 __new__ 和 __init__ 的区别

  https://juejin.im/post/5add4446f265da0b8d4186af

4. Python中__repr__和__str__区别

  https://blog.csdn.net/luckytanggu/article/details/53649156

5. python 单例模式

  https://www.cnblogs.com/xiao-apple36/p/9398760.html
