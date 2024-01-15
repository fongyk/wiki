in-place 运算
================

+= 运算
-----------

``+=`` 是一个 in-place 运算符，看如下例子：

..  code-block:: python
    :linenos:

    a = []
    b = a
    a += [1,2]

结果如下：

.. code-block:: python

    >>> print a
    [1,2]
    >>> print b
    [1,2]

如果改变成如下形式：

..  code-block:: python
    :linenos:

    a = []
    b = a
    a = a + [1,2]

则结果如下：

.. code-block:: python

    >>> print a
    [1,2]
    >>> print b
    []

.. note::

    ``a = a + [1,2]`` 不是 in-place 运算，尽管使用了同一个变量名。


add 和 iadd
----------------

``operator`` 包中有两个操作：``add`` 和 ``iadd`` 。``add`` 是正常加运算， ``iadd`` 是原位加运算。

    ``_add_``
        does simple addition, takes two arguments, returns the sum and stores it in other variable without modifying any of the argument.
        Normal operator’s ``add()`` method, implements **“a+b”** and stores the result in the mentioned variable.

    ``_iadd_``
        also takes two arguments, but it makes in-place change in 1st argument passed by storing the sum in it. As object mutation is needed in this process, immutable targets such as numbers, strings and tuples, shouldn’t have ``_iadd_`` method.
        Inplace operator’s ``iadd()`` method, implements **“a+=b”** if it exists (i.e in case of immutable targets, it doesn’t exist) and changes the value of passed argument. But if not, **“a+b”** is implemented.


不可变目标
^^^^^^^^^^^^^^^^^^^^^^

对于不可变目标（Immutable Targets），如数字、字符串、元组， ``_add_`` 和 ``_iadd_`` 结果是一样的，输入实参不会发生改变。

.. code-block:: python
    :linenos:

    import operator

    x = 5
    y = 6
    a = 5
    b = 6

    z = operator.add(a, b)
    p = operator.iadd(x, y)

结果如下：

.. code-block:: python

    >>> print z
    11
    >>> print a
    5
    >>> print p
    11
    >>> print x
    5

可变目标
^^^^^^^^^^^^^^^^^

对于可变目标（Mutable Targets），如列表、字典、集合，输入实参会被重现赋值和更新。

.. code-block:: python
    :linenos:

    import operator

    a = [1,2,4,5]
    b = [1,2,4,5]

    z = operator.add(a, [1,2,3])
    p = operator.iadd(b, [1,2,3])

结果如下：

.. code-block:: python

    >>> print z
    [1, 2, 4, 5, 1, 2, 3]
    >>> print p
    [1, 2, 4, 5, 1, 2, 3]
    >>> print a
    [1, 2, 4, 5]
    >>> print b
    [1, 2, 4, 5, 1, 2, 3]

.. note::

    **不可变目标** （数字、字符串、元组）作为函数参数，相当于 **值传递** ，函数对实参进行拷贝。

    **可变目标** （列表、字典、集合）作为函数参数，相当于 **引用传递** ，函数对实参的修改有效。这里的修改是通过调用变量的成员方法，如果在函数中通过 ``=`` 运算符直接对该变量重新赋值，那么这种改变也不会影响实参。


参考资料
--------------

1. pytorch issue：

  https://github.com/pytorch/pytorch/issues/5687

2. GeeksforGeeks：

  https://www.geeksforgeeks.org/inplace-vs-standard-operators-python/
