__all__ 的使用
==================

从__init__.py谈起
----------------------

``__init__.py`` 的 **作用一** ：package 的标识

    在每一个 package 文件夹中都会有一个 ``__init__.py`` 文件。我们导入一个包时，实际上是导入了它的 ``__init__.py`` 文件。因此我们可以在 ``__init__.py`` 文件中批量导入所需的模块，
    而不需要再一个一个地倒入。

    .. code-block:: python

        ### package
        ## __init__.py
        import sys
        import os
        import math

        ## test.py
        import package
        print package.math.sqrt(2)

``__init__.py`` 的 **作用二** ：定义该 package 的 ``__all__`` ，用以模糊导入

    python中包（package）和模块（module）有两种导入形式：精确导入和模糊导入。

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
    ├── myPack
    │   ├── func.py
    │   └── __init__.py
    └── test.py

创建了包 **myPack** ，其中 **func.py** 中定义了该包的功能，包括变量、类、函数的定义。使用 **test.py** 来测试这个包的调用。
``__init__.py`` 中的内容如下：

.. code-block:: python
    :linenos:

    import sys
    import os
    import math

    from func import x, foo
    # 假设x是一个变量，foo是一个函数

    __all__ = ['x', 'foo', 'math', 'os', 'sys']

**test.py** 中的内容如下：

.. code-block:: python
    :linenos:

    from myPack import *

    print x

    foo()

    print math.sqrt(2)


路径
--------------

``import`` 在导入模块时，会根据 ``sys.path`` 中的路径来搜索对应的模块。 ``sys.path`` 是一个列表，``import`` 时会从 ``sys.path`` 的第一个路径开始搜索。
``sys.path`` 默认的路径为：

  - 当前目录的路径，即 ``sys.path[0]`` 。

  - 环境变量 ``PYTHONPATH`` 中指定的路径列表。

  - Python 安装路径的 ``lib`` 目录所在路径。

我们可以将需要的路径添加到 ``sys.path`` ，有如下几种方式:

  - 动态修改 ``sys.path`` 。这种方式只会对当前项目临时生效。

    .. code-block:: python
        :linenos:

        import os
        import sys
        ## parenddir 是当前代码文件所在目录的父目录
        parenddir = os.path.abspath(os.path.join(os.path.dirname(__file__), os.path.pardir))
        sys.path.append(parenddir)


  - 修改 ``PYTHONPATH`` 环境变量，所有的 Python 项目都会受到影响。

  - 在 ``sys.path`` 已有的某一个目录下添加 .pth 后缀的配置文件，该文件的内容是要添加的搜索路径。Python 在遍历已有目录的过程中，如果遇到 .pth 文件，就会将其中的路径添加到 ``sys.path`` 中。


命名空间包
------------

Python3.3 之后引入了命名空间包（namespace packages）的概念，目录下不再需要 ``__init__.py`` 。
命名空间包可以避免名字空间的污染，且具有不连续性（类似于C++），即同一个包内的模块可以不在同一个文件系统。

相比之下，有 ``__init__.py`` 的包叫做常规包（regular packages），同一个包内的模块在同一个文件目录下。

新建如下目录（命名空间库）::

  datetime/
  └── datetime.py

**datetime.py** 内容如下：

.. code-block:: python
    :linenos:

    def now():
        print("hello world")

    def then():
        print("good bye")

注意到，这里的 **datetime** 与 python 自带的库重名了。

.. code-block:: python
    :linenos:

    >>> from datetime import datetime
    >>> datetime
    <class 'datetime.datetime'>
    >>> datetime.now() ## 调用了系统的库而不是新建的库
    datetime.datetime(2020, 3, 8, 11, 42, 53, 472470)

.. code-block:: python
    :linenos:

    >>> import sys
    >>> sys.path.insert(0, '/data6/fong/a/datetime')
    >>> import datetime
    >>> datetime
    <module 'datetime' from '/data6/fong/a/datetime/datetime.py'>
    >>> datetime.now()
    hello world
    >>> datetime.then()
    good bye

新建如下目录（常规库）::

  datetime/
  ├── datetime.py
  └── __init__.py


.. code-block:: python
    :linenos:

    >>> from datetime import datetime
    >>> datetime
    <module 'datetime.datetime' from '/data6/fong/a/datetime/datetime.py'>
    >>> datetime.now()
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    AttributeError: module 'datetime.datetime' has no attribute 'now'

相对路径导入
-------------

``from .Module import func`` 表示从当前目录的模块中导入。

``from ..PKG.Module import func`` 表示从上一级目录的包中导入。

- 错误一::

      ImportError: attempted relative import with no known parent package.

  这是因为相对导入发生在包的内部，此时在包的内部直接运行该模块会报错，应该在项目的顶层目录运行主程序，通过主程序（直接/间接）调用该模块。

- 错误二::

      ValueError: attempted relative import beyond top-level package

  与主程序同一目录下的包称为顶层包（top-level package），各个顶层包之间不能进行相对调用。

getattr
-------------

``getattr()`` 函数用于返回一个对象属性值::

  getattr(object, name[, default])

参数：

  - object： 对象。

  - name：字符串，对象属性。

  - default：默认返回值，如果不提供该参数，在没有对应属性时，将触发 ``AttributeError`` 。

.. code-block:: python
    :linenos:

    >>>class A(object):
    ...     bar = 1
    ... 
    >>> a = A()
    >>> getattr(a, 'bar')
    1
    >>> getattr(a, 'bar2')
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    AttributeError: 'A' object has no attribute 'bar2'
    >>> getattr(a, 'bar2', 3)
    3

在 ``__all__`` 中添加包名之后，可以通过 ``getattr()`` 直接调用相应的模块。

建立新的包如下::

    pkg/
    ├── func.py
    └── __init__.py

**func.py** 内容为::

    def say():
        print("hello")

**__init__.py** 内容为::

    from .func import *

    __all__ = ["say",]


.. code-block:: python
    :linenos:

    >>> import pkg
    >>> getattr(pkg, "say")
    <function say at 0x7f6134fdf560>
    >>> getattr(pkg, "say")()
    hello


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


5. What is __init__.py for?

  https://stackoverflow.com/questions/448271/what-is-init-py-for

6. Regular packages

  https://docs.python.org/3/reference/import.html#regular-packages

7. 详解 Python import 机制 (一):import 中的基本概念

  https://zhuanlan.zhihu.com/p/87238735

8. Python getattr() 函数

  https://www.runoob.com/python/python-func-getattr.html

9. Python 相对导入attempted relative import beyond top-level package

  https://www.cnblogs.com/linkenpark/p/10909523.html