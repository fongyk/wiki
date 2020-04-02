\*args和\*\*kwargs
=====================

\*args
---------

``*args`` 用来将 **不定数量** 的参数打包成 ``tuple`` 给函数体使用。

例一：

.. code-block:: python
  :linenos:

  def foo(x, *args):
    print "x:", x
    for k in range(len(args)):
      print "args[{}]:".format(k), args[k]

.. code-block:: python
  :linenos:

  >>> foo(1, 100, '200k', 300)
  x: 1
  args[0]: 100
  args[1]: 200k
  args[2]: 300

  >>> args = [1,2,'abc']
  >>> foo('A', *args)
  x: A
  args[0]: 1
  args[1]: 2
  args[2]: abc

  >>> foo('A', args) ## 注：此时把args当做一个参数，参数类型为列表
  x: A
  args[0]: [1, 2, 'abc']

例二：

.. code-block:: python
  :linenos:

  def foo(x, var1, var2, var3):
    print "x:", x
    print "var1:", var1
    print "var2:", var2
    print "var3:", var3


.. code-block:: python
  :linenos:

  >>> args = [1,2,'A'] # list
  >>> foo(1, args)
  TypeError: foo() takes exactly 4 arguments (2 given)
  >>> foo(1, *args)
  x: 1
  var1: 1
  var2: 2
  var3: A

  >>> args = (1,2,'A') # tuple
  >>> foo(1, args)
  TypeError: foo() takes exactly 4 arguments (2 given)
  >>> foo(1, *args)
  x: 1
  var1: 1
  var2: 2
  var3: A


\*\*kwargs
----------------

``**kwargs`` 打包 **不定数量** 的键值对参数成 ``dict`` 给函数体使用。

例一：

.. code-block:: python
  :linenos:

  def foo(**kwargs):
    for key, val in kwargs.items():
      print "{} : {}".format(key, val)

.. code-block:: python
  :linenos:

  >>> foo(var1=1, var2='a', var3=[1,2,3])
  var1 : 1
  var3 : [1, 2, 3]
  var2 : a

例二：

.. code-block:: python
  :linenos:

  def foo(x, var1=2, var2='a'):
    print "x:", x
    print "var1:", var1
    print "var2:", var2

.. code-block:: python
  :linenos:

  >>> dict_input = {"var1": 10, "var2": "A"}
  >>> foo(1, dict_input)
  x: 1
  var1: {'var1': 10, 'var2': 'A'}
  var2: a

  >>> foo(1, **dict_input)
  x: 1
  var1: 10
  var2: A

arg，\*args，\*\*kwargs
--------------------------

位置参数、\*args、\*\*kwargs三者的顺序必须是（arg，\*args，\*\*kwargs）。

.. code-block:: python
  :linenos:

  def foo(arg, *args, **kwargs):
    print "arg:", arg
    print "args:", args
    print "kwargs:", kwargs

.. code-block:: python
  :linenos:

  >>> foo(1, 2, 3, 4, x=1, y='b')
  arg: 1
  args: (2, 3, 4)
  kwargs: {'y': 'b', 'x': 1}

  >>> foo(1, x=1, y='b', 2, 3, 4)
  SyntaxError: non-keyword arg after keyword arg

位置参数、默认参数、\*\*kwargs三者的顺序必须是（位置参数，默认参数，\*\*kwargs）。

.. code-block:: python
  :linenos:

  def foo(x, y=1, **kwargs): ## 不能出现 (x=1,y,**kwargs)
    print "x:", x
    print "y:", y
    print "kwargs:", kwargs

.. code-block:: python
  :linenos:

  >>> foo(4, var1=1, var2='b')
  x: 4
  y: 1
  kwargs: {'var1': 1, 'var2': 'b'}

命名关键字参数
---------------

Python3 的命名关键字参数（keyword-only argument），以独立的 ``*`` 为标记，强制用户在调用函数的时候必须写出 ``*`` 之后的参数名。

.. code-block:: python
  :linenos:

  >>> def foo(a, *, b=0, c):
  ...     print(a, b, c)
  ...
  >>> foo(1,2,3)
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
  TypeError: foo() takes 1 positional argument but 3 were given
  >>> foo(1,c=2,b=3)
  1 3 2
  >>> foo(1, c=2)
  1 0 2
  >>> foo(1, b=2)
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
  TypeError: foo() missing 1 required keyword-only argument: 'c'

参考资料
---------------

1. 大话Python中\*args和\*\*kargs的使用

  https://www.cnblogs.com/shitaotao/p/7609990.html

2. python函数——形参中的：\*args和\*\*kwargs

  https://www.cnblogs.com/xuyuanyuan123/p/6674645.html

3. 函数的参数

  https://www.liaoxuefeng.com/wiki/1016959663602400/1017261630425888