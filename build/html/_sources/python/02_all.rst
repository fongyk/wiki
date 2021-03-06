__all__ 的使用
==================

从__init__.py谈起
----------------------

``__init__.py`` 的 **作用一** ：package的标识

    在每一个package文件夹中都会有一个__init__.py文件。

``__init__.py`` 的 **作用二** ：定义该package的 ``__all__`` ，用以模糊导入

    python中包(package)和模块(module)有两种导入形式：精确导入和模糊导入。

    精确导入
        .. code-block:: python

            from PACK import CLASS1, CLASS2
            import PACK.CLASS1

    模糊导入
        .. code-block:: python

            from PACK import *

``__all__`` 是一个字符串列表，用于定义模糊导入中的 ``*`` 中的模块，即暴露接口，也是对于模块公开接口的一种约定。

举个例子，建立如下目录结构的文件夹及文件::

    .
    |__ test.py
    |__ myPack
        |__ __init__.py
        |__ func.py

创建了包 **myPack** ，其中 **func.py** 中定义了该包的功能，包括变量、类、函数的定义。使用 **test.py** 来测试这个包的调用。
``__init__.py`` 中的内容如下：

.. code-block:: python
    :linenos:

    from func import x, foo
    # 假设x是一个变量，foo是一个函数

    __all__ = ['x', 'foo']

**test.py** 中的内容如下：

.. code-block:: python
    :linenos:

    from myPack import *

    print x

    foo()

参考资料
------------

1. Python中的 __all__

  https://www.jianshu.com/p/ca469f693c31

2. Python包中 __init__.py 作用

  https://www.cnblogs.com/AlwinXu/p/5598543.html

3. Python __init__.py 作用详解

  https://www.cnblogs.com/Lands-ljk/p/5880483.html

4. Python中 __all__ 的用法

  https://www.codetd.com/article/2136881