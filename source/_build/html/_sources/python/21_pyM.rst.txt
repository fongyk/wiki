python -m
=================

Python 加载 py 文件的方式：

    - ``python xxx.py`` ：以直接运行的方式启动。

    - ``python -m xxx`` ：以模块的方式启动。

执行 ``python -h`` 可以找到：

    -m mod : run library module as a script (terminates option list)

两种方式的异同
---------------

新建 **run.py** 如下::

    a/
    └── run.py


.. code-block:: python
    :linenos:

    import sys

    print(sys.path)

    print(__name__)

    if __name__ == "__main__":
        print("Directly launched.")

执行 ``python a/run.py``::

    ['/data6/fong/a', '/home/fong/anaconda3/envs/python37/lib/python37.zip', '/home/fong/anaconda3/envs/python37/lib/python3.7', '/home/fong/anaconda3/envs/python37/lib/python3.7/lib-dynload', '/home/fong/.local/lib/python3.7/site-packages', '/home/fong/anaconda3/envs/python37/lib/python3.7/site-packages']
    __main__
    Directly launched.

执行 ``python -m a/run`` （Python3 执行  ``python -m a.run`` ）::

    ['/data6/fong', '/home/fong/anaconda3/envs/python37/lib/python37.zip', '/home/fong/anaconda3/envs/python37/lib/python3.7', '/home/fong/anaconda3/envs/python37/lib/python3.7/lib-dynload', '/home/fong/.local/lib/python3.7/site-packages', '/home/fong/anaconda3/envs/python37/lib/python3.7/site-packages']
    __main__
    Directly launched.

对比可以发现：

- 两者都会把定位到的模块脚本当成 **主程序** 入口来执行，执行时该脚本的 ``__name__`` 都是 ``__main__`` 。

- ``sys.path[0]`` 是不一样的，一个是脚本所在目录，另一个是执行命令所在的目录。

.. note::

    ``python -m run`` 会从 ``sys.path`` 查找模块 ``run`` ，如果把 ``run`` 的路径放入 ``sys.path`` 中，则执行的时候不需要再指定路径。

示例
---------

新建目录如下::

    .
    ├── pkg1
    │   ├── __init__.py
    │   └── my_module.py
    └── pkg2
        ├── __init__.py
        └── run.py

**run.py** 内容如下::

    import sys
    print(sys.path)

    from pkg1 import my_module

执行 ``python pkg2/run.py``::

    ['/data6/fong/a/test/pkg2', '/home/fong/anaconda3/envs/python37/lib/python37.zip', '/home/fong/anaconda3/envs/python37/lib/python3.7', '/home/fong/anaconda3/envs/python37/lib/python3.7/lib-dynload', '/home/fong/.local/lib/python3.7/site-packages', '/home/fong/anaconda3/envs/python37/lib/python3.7/site-packages']
    Traceback (most recent call last):
    File "pkg2/run.py", line 4, in <module>
        from pkg1 import my_module
    ModuleNotFoundError: No module named 'pkg1'

执行 ``python -m pkg2/run``::

    ['/data6/fong/a/test', '/home/fong/anaconda3/envs/python37/lib/python37.zip', '/home/fong/anaconda3/envs/python37/lib/python3.7', '/home/fong/anaconda3/envs/python37/lib/python3.7/lib-dynload', '/home/fong/.local/lib/python3.7/site-packages', '/home/fong/anaconda3/envs/python37/lib/python3.7/site-packages']

参考资料
-------------

1. Python 中 -m 的典型用法、原理解析与发展演变

    https://zhuanlan.zhihu.com/p/91120727