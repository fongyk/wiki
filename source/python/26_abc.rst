abc
========

**abc** 模块提供了在 Python 中定义抽象基类（abstract base classes）的组件。

抽象基类
-----------

抽象基类可以通过从 ``ABC`` 派生来简单地创建，

.. code-block:: python
    :linenos:

    from abc import ABC

    class MyABC(ABC):
        pass

也可以直接使用 ``ABCMeta`` 作为元类（metaclass）来定义抽象基类，

.. code-block:: python
    :linenos:

    from abc import ABCMeta

    class MyABC(metaclass=ABCMeta):
        pass


抽象方法
------------

``@abc.abstractmethod`` 是用于声明抽象方法的装饰器。

抽象方法与继承：

  - 继承一个没有抽象方法的抽象类，不需要重写（override）抽象方法也能实例化。

  - 继承有抽象方法的抽象类但没有重写抽象方法会报错，子类重写抽象方法不需要 ``abstractmethod`` 修饰。

  - 继承有抽象方法的非抽象类不会报错。

当 ``abstractmethod`` 与其他方法描述符配合使用时，它应当作为最内层的装饰器。

.. code-block:: python
    :linenos:

    class C(ABC):
        @abstractmethod
        def my_abstract_method(self):
            pass
        @classmethod
        @abstractmethod
        def my_abstract_classmethod(cls):
            pass
        @staticmethod
        @abstractmethod
        def my_abstract_staticmethod():
            pass

        @property
        @abstractmethod
        def my_abstract_property(self):
            pass
        @my_abstract_property.setter
        @abstractmethod
        def my_abstract_property(self, val):
            pass

        @abstractmethod
        def _get_x(self):
            ...
        @abstractmethod
        def _set_x(self, val):
            ...
        x = property(_get_x, _set_x)

虚子类
----------

``register(subclass)`` 将子类注册为该抽象基类的虚子类（virtual subclass）。 ``issubclass`` 和 ``isinstance`` 等函数都能识别，但是该抽象基类不会出现在其 MRO（Method Resolution Order，方法解析顺序）中，虚子类并不会从抽象基类中继承任何方法，也无需重写抽象方法。虚子类是为类型检测准备的，由于不需要重写抽象方法，因此第三方接口的可扩展性和灵活性更高。

.. code-block:: python
    :linenos:

    from abc import ABC

    class MyABC(ABC):
        pass

    MyABC.register(tuple)

    assert issubclass(tuple, MyABC)
    assert isinstance((), MyABC)

内建属性 ``__mro__`` 按顺序列出当前类及其祖先类， ``__subclasses__()`` 列出子孙类。

.. code-block:: python
    :linenos:

    from abc import *
    class A(metaclass=ABCMeta):
        @abstractmethod
        def func1(self):
            pass

    @A.register
    class B:
        def func2(self):
            pass
    ## 等价于 A.register(B)


    class C(A):
        def func1(self):
            pass

.. code-block:: python
    :linenos:

    >>> c = C()
    >>> print(C.__mro__)
    (<class '__main__.C'>, <class '__main__.A'>, <class 'object'>)
    >>> print(A.__subclasses__())
    [<class '__main__.C'>]


参考资料
--------------

1. abc — Abstract Base Classes

  https://docs.python.org/zh-cn/3/library/abc.html

2. python之抽象类&abc模块+虚拟子类&register
  
  https://www.cnblogs.com/wqbin/p/10239515.html

3. 协议与接口与抽象基类

  https://blog.hszofficial.site/TutorialForPython/%E8%AF%AD%E6%B3%95%E7%AF%87/%E9%9D%A2%E5%90%91%E5%AF%B9%E8%B1%A1%E6%83%AF%E7%94%A8%E6%B3%95/%E5%8D%8F%E8%AE%AE%E4%B8%8E%E6%8E%A5%E5%8F%A3%E4%B8%8E%E6%8A%BD%E8%B1%A1%E5%9F%BA%E7%B1%BB.html
