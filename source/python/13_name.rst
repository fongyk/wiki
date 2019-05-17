命名规范
============

后缀单下划线
--------------

避免与关键字冲突。

::

  class_ = 1


前缀单下划线
-----------------

不能被 ``from module_name import *`` 导入。

对于类的成员变量和成员函数

  - ``_var`` ：保护成员（protected），类对象可以在外部访问

  - ``_func`` ：保护成员（protected），类对象可以在外部访问


前缀双下划线
-----------------

不能被 ``from module_name import *`` 导入。

对于类的成员变量和成员函数

  - ``__var`` ：私有成员（private），类对象不可以在外部访问

  - ``__func`` ：私有成员（private），类对象不可以在外部访问


.. code-block:: python
  :linenos:

  ## ac.py
  _global = 10
  def _func():
      print "_func"

  class A:
    var = 100        ## 类变量（类对象共有）
    def __init__(self):
        self._a = 0  ## protected
        self.__b = 1 ## private
        self.c = 2

    def _foo(self):
        print "_foo"

    def __foo(self):
        print "__foo"

    def foo(self):
        print "foo"
        print "__b:", self.__b

.. code-block:: python
  :linenos:

  >>> from ac import *
  >>> obj = A()
  >>> print obj.var
  100
  >>> print obj.c
  2
  >>> obj.foo()
  foo
  __b: 1

  >>> print obj._a
  0
  >>> print _foo()
  _foo

  >>> print obj.__b
  AttributeError: A instance has no attribute '__b'

  >>> print _global
  NameError: name '_global' is not defined


前后双下划线
-------------

内建方法，如::

  __doc__
  __name__


参考资料
-------------

1. python 命名规范

  https://www.jianshu.com/p/a793c0d960fe
