类变量与类方法
=================

类变量
-----------

定义在类的开始。

- 类和实例都可以访问类变量

- 实例只可以访问，不可以修改

实例变量
--------------

类实例（对象）可使用的变量，以 ``self.`` 开头。

实例方法
--------------

类实例（对象）可调用的函数，形参包括 ``self`` 。

静态方法
--------------

使用 ``@staticmethod`` 装饰，是定义在类内的普通函数。

- 静态方法不能访问类变量、实例变量、实例方法

- 类和实例都可以访问静态方法

类方法
---------------

使用 ``@classmethod`` 装饰，形参包括 ``cls`` 。

- 类方法可以访问和修改类变量，不能访问实例变量、实例方法

- 类和实例都可以访问类方法

.. code-block:: python
  :linenos:

  class A:
    var = 100        ## 类变量
    def __init__(self):
        self._a = 0  ## 实例变量
        self.__b = 1 ## 实例变量
        self.c = 2   ## 实例变量

    def _foo(self):
        print "_foo"

    def __foo(self):
        print "__foo"

    def foo(self):
        self.__foo()
        print "__b:", self.__b
        print self.static_func(1, 5)

    @staticmethod
    def static_func(a, b):
        print "static_method"
        return a + b

    @classmethod
    def class_func(cls, num):
        print "class_method"
        cls.var = num
        print cls.static_func(-1, 1)

.. code-block:: python
  :linenos:

  >>> obj = A()
  >>> print obj.static_func(1,3)
  static_method
  4
  >>> A.class_func(200)
  class_method
  static_method
  0

  >>> print A.var
  200

  >>> obj.foo()
  __foo
  __b: 1
  static_method
  6



参考资料
------------

1. Python-类变量，成员变量，静态变量，类方法，静态方法，实例方法，普通函数

  https://www.cnblogs.com/20150705-yilushangyouni-Jacksu/p/6238187.html

2. 一张图了解python 类方法与类变量 类变量与实例变量

  https://blog.csdn.net/cgqdtc/article/details/80555319
