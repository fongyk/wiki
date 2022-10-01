内建属性
===========

__name__
-----------------

``__name__`` 标识模块的名字，可以显示一个模块的某功能是 **被自己执行还是被别的文件调用执行** 。

如果被自己执行，那么 ``__name__== "__main__"`` ；

如果被调用执行，那么 ``__name__`` 值为被调用模块的名字。


__doc__
-----------------

``__doc__`` 是模块的文档字符串（docstring），是由三引号包围的字符串，定义在文件/类/函数的头部。

定义 **Module.py** 内容如下：

.. code-block:: python
    :linenos:

    """ An example module."""

    class A(object):
        """
        class A.
        """
        pass

    def func():
        """ function f. """
        pass

.. code-block:: python
    :linenos:

    >>> import Module
    >>> print(Module.__doc__)
    An example module.
    >>> print(Module.A.__doc__) 

        class A.
                
    >>> print(Module.func.__doc__) 

        function f.
        

__call__
-----------------

如果在类中实现了 ``__call__`` 方法，那么实例对象将成为一个可调用对象。自定义函数、内建函数和类都属于可调用对象，但凡是可以把一对括号 ``()`` 应用到某个对象身上都可称之为可调用对象，判断对象是否为可调用对象可以用函数 ``callable`` 。

.. code-block:: python
    :linenos:

    class A(object):
        def __init__(self, a):
            self._a = a
        
        def __call__(self, b):
            return self._a * b

.. code-block:: python
    :linenos:

    >>> obj = A(5) 
    >>> callable(A)
    True
    >>> callable(obj) 
    True
    >>> obj(10)
    50


__dict__
-----------------

``__dict__`` 存储了类和实例的一些属性。

在 ``__init__`` 中声明的变量（ ``self.xxx`` ），会存到实例的 ``__dict__`` 中；类的静态函数、类函数、普通函数、全局变量以及一些内置的属性都是放在类的 ``__dict__`` 中。


.. code-block:: python
    :linenos:

    class A(object):
    """ class A. """
        Aa = 10
        def __init__(self, a):
            self._a = a
        
        def __call__(self, b):
            return self._a * b

.. code-block:: python
    :linenos:

    >>> from Module import *
    >>> A.__dict__
    mappingproxy({'__module__': 'Module', '__doc__': ' class A. ', 'Aa': 10, '__init__': <function A.__init__ at 0x000001F1D9E2CEE0>, '__call__': <function A.__call__ at 0x000001F1D9E2CF70>, '__dict__': <attribute '__dict__' of 'A' objects>, '__weakref__': <attribute '__weakref__' of 'A' objects>})
    >>> obj = A(0)
    >>> obj.__dict__
    {'_a': 0}

.. code-block:: python
    :linenos:

    class A(object):
        Aa = 10
        def __init__(self, **kwargs):
            self.__dict__.update(kwargs)
        
        def func(self, b):
            pass

.. code-block:: python
    :linenos:

    >>> kwargs = {"a":1, "b":2, "c": 3}
    >>> obj = A(**kwargs) 
    >>> obj.__dict__
    {'a': 1, 'b': 2, 'c': 3}
    >>> obj.c
    3
    >>> A.__dict__
    mappingproxy({'__module__': 'Module', 'Aa': 10, '__init__': <function A.__init__ at 0x0000024E2C82CEE0>, 'func': <function A.func at 0x0000024E2C82CF70>, '__dict__': <attribute '__dict__' of 'A' objects>, '__weakref__': <attribute '__weakref__' of 'A' objects>, '__doc__': None})


__setattr__
-----------------

默认情况下，实例属性赋值，被赋值的属性和值会存入实例属性字典 ``__dict__`` 中。

如果类自定义了 ``__setattr__`` 方法，当通过实例获取属性（instance.attr）并尝试赋值时，就会调用 ``__setattr__`` 。

.. code-block:: python
    :linenos:

    class A(object):
        def __init__(self, a):
            self._a = a

.. code-block:: python
    :linenos:

    >>> obj = A(0)
    >>> obj._b = 1
    >>> obj.__dict__
    {'_a': 0, '_b': 1}

.. code-block:: python
    :linenos:

    class A(object):
        def __init__(self, a):
            self._a = a
        def __setattr__(self, name, value):
            print("set attr.", name)
            self.__dict__[name] = value


.. code-block:: python
    :linenos:

    >>> obj = A(0) ## 初始化会调用 __setattr__
    set attr. _a
    >>> obj._b = 1
    set attr. _b
    >>> obj.__dict__
    {'_a': 0, '_b': 1}

.. warning::

    如果在 ``__setattr__`` 中试图通过  ``self.xxx`` 来访问其他属性，容易出现错误。比如，初始化之前， ``__dict__`` 中还没有插入属性，是无法访问的。

__getattr__
-----------------

实例通过 **点号** 访问属性（instance.attr），只有当属性没有在实例的 ``__dict__`` 或类的 ``__dict__`` 中没有找到，才会调用 ``__getattr__`` 。当属性可以通过正常机制追溯到时，``__getattr__`` 是不会被调用的。

.. code-block:: python
    :linenos:

    class A(object):
        def __init__(self, a):
            self._a = a
            self.dic = {"_b": 1, "_c": 2}

        def __getattr__(self, attr):
            print("get attr.", attr)
            if attr in self.dic:
                return self.dic[attr]
            return -1

.. code-block:: python
    :linenos:

    >>> obj = A(0)
    >>> obj._a
    0
    >>> obj._b
    get attr. _b
    1


__getattribute__
-------------------------

实例通过 **点号** 访问属性（instance.attr）， ``__getattribute__`` 方法始终会被调用，无论属性是否能通过 ``__dict__`` 追溯到。如果类还定义了 ``__getattr__`` 方法，除非它被 ``__getattribute__`` 显式调用，或者 ``__getattribute__`` 方法出现 ``AttributeError`` 异常，否则 ``__getattr__`` 方法永远不会被调用。

.. code-block:: python
    :linenos:

    class A(object):
        def __init__(self, a):
            self._a = a
            self.dic = {"_b": 1, "_c": 2}

        def __getattribute__(self, attribute):
            if attribute == "_a":
                return -1
            else:
                raise AttributeError("no attribute {}".format(attribute))

        def __getattr__(self, attr):
            print("get attr.", attr)
            return 2

.. code-block:: python
    :linenos:

    >>> obj =A(0)
    >>> obj._a
    -1
    >>> obj._b
    get attr. _b
    2


.. warning::

    在抛出 ``AttributeError`` 异常之后，如果此时在 ``__getattr__`` 中试图通过  ``self.xxx`` 来访问其他属性（如 ``self.dic`` ）时，会出现死循环。


参考资料
-----------------

1. Python __dict__属性详解

  https://www.cnblogs.com/alvin2010/p/9102344.html

2. python 自定义属性访问 __setattr__, __getattr__,__getattribute__, __call__

  https://www.cnblogs.com/elie/p/6685429.html

3. Python中__setattr__, __getattr__和__getattribute__

  https://www.jianshu.com/p/0beee5a49b90

