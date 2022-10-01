glob
=============

glob 是 python 自带的用来处理文件路径相关操作的模块，它可以找出所有和特定模式匹配的文件路径名（pathname）。


通配符
----------

glob 只有3个通配符：

- ``*``   匹配所有字符

- ``?``   匹配单个字符

- ``[]``  匹配指定范围的字符，如 [0-9], [a-z], [0-3, a-c]


glob.glob
-------------

::

    glob.glob(pathname, *, recursive=False)

返回匹配文件名的一个列表， ``pathname`` 可以是绝对路径也可以是相对路径。

当 ``recursive=True`` ，通配符 ``**`` 可以匹配任意文件、目录、子目录、符号链接目录等。

.. code-block:: python
    :linenos:

    >>> import glob
    >>> glob.glob('./[0-9].*')
    ['./1.gif', './2.txt']
    >>> glob.glob('*.gif')
    ['1.gif', 'card.gif']
    >>> glob.glob('?.gif')
    ['1.gif']
    >>> glob.glob('**/*.txt', recursive=True)
    ['2.txt', 'sub/3.txt']
    >>> glob.glob('./**/', recursive=True)
    ['./', './sub/']


glob.iglob
-------------

::

    glob.iglob(pathname, *, recursive=False)

返回匹配文件名的一个生成器（generator）fg，当匹配结果较多时，可以节约内存。
访问方法::

    next(fg)

    fg.__next__() ## Python3

    fg.next() ## Python2


参考资料
----------

1. python的glob模块

  https://www.cnblogs.com/luobuda/p/glob.html

2. glob — Unix style pathname pattern expansion

  https://docs.python.org/3/library/glob.html