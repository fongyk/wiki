命名空间和作用域
=================

命名空间是名称到对象的映射，作用域是命名空间可直接访问的 Python 程序的文本区域（Textual Region）。 “可直接访问” 的意思是：对名称的非限定引用会在命名空间中查找名称。

LEGB
-----------

Python 有四类作用域：

- 局部（Local）作用域：函数内
- 封闭（Enclosing）作用域：嵌套函数中的外函数
- 全局（Global）作用域：函数定义所在模块
- 内置（Built-in）作用域：Python 内置模块

在作用域中按名称去寻找对象时（Python 中一切皆对象），会按照 LEGB 规则去查找，作用域查找顺序为::

    Local -> Enclosing -> Global -> Built-in

如果发生重名，那么谁先被找到就用谁。

.. code-block:: python
    :linenos:

    len = len([])       # Global
    def a():
        len = 1         # Enclosing
        def b():
            len = 2     # Local
            print(len)
        b()
    a()

.. code-block:: python
    :linenos:

    >>> dir(__builtins__)
    ['ArithmeticError', 'AssertionError', 'AttributeError', 'BaseException', 'BlockingIOError', 'BrokenPipeError', 'BufferError', 'BytesWarning', 'ChildProcessError', 'ConnectionAbortedError', 'ConnectionError', 'ConnectionRefusedError', 'ConnectionResetError', 'DeprecationWarning', 'EOFError', 'Ellipsis', 'EnvironmentError', 'Exception', 'False', 'FileExistsError', 'FileNotFoundError', 'FloatingPointError', 'FutureWarning', 'GeneratorExit', 'IOError', 'ImportError', 'ImportWarning', 'IndentationError', 'IndexError', 'InterruptedError', 'IsADirectoryError', 'KeyError', 'KeyboardInterrupt', 'LookupError', 'MemoryError', 'ModuleNotFoundError', 'NameError', 'None', 'NotADirectoryError', 'NotImplemented', 'NotImplementedError', 'OSError', 'OverflowError', 'PendingDeprecationWarning', 'PermissionError', 'ProcessLookupError', 'RecursionError', 'ReferenceError', 'ResourceWarning', 'RuntimeError', 'RuntimeWarning', 'StopAsyncIteration', 'StopIteration', 'SyntaxError', 'SyntaxWarning', 'SystemError', 'SystemExit', 'TabError', 'TimeoutError', 'True', 'TypeError', 'UnboundLocalError', 'UnicodeDecodeError', 'UnicodeEncodeError', 'UnicodeError', 'UnicodeTranslateError', 'UnicodeWarning', 'UserWarning', 'ValueError', 'Warning', 'ZeroDivisionError', '__build_class__', '__debug__', '__doc__', '__import__', '__loader__', '__name__', '__package__', '__spec__', 'abs', 'all', 'any', 'ascii', 'bin', 'bool', 'breakpoint', 'bytearray', 'bytes', 'callable', 'chr', 'classmethod', 'compile', 'complex', 'copyright', 'credits', 'delattr', 'dict', 'dir', 'divmod', 'enumerate', 'eval', 'exec', 'exit', 'filter', 'float', 'format', 'frozenset', 'getattr', 'globals', 'hasattr', 'hash', 'help', 'hex', 'id', 'input', 'int', 'isinstance', 'issubclass', 'iter', 'len', 'license', 'list', 'locals', 'map', 'max', 'memoryview', 'min', 'next', 'object', 'oct', 'open', 'ord', 'pow', 'print', 'property', 'quit', 'range', 'repr', 'reversed', 'round', 'set', 'setattr', 'slice', 'sorted', 'staticmethod', 'str', 'sum', 'super', 'tuple', 'type', 'vars', 'zip']


global 和 nonlocal 关键字
-------------------------------

如果要 **写** Global/Enclosing 变量，需要使用 ``global`` / ``nonlocal`` 关键字，否则只能 **读** 。

.. code-block:: python
    :linenos:

    def scope_test():
        def do_local():
            spam = "local spam"

        def do_nonlocal():
            nonlocal spam
            spam = "nonlocal spam"

        def do_global():
            global spam
            spam = "global spam"

        spam = "test spam"
        do_local()
        print("After local assignment:", spam)
        do_nonlocal()
        print("After nonlocal assignment:", spam)
        do_global()
        print("After global assignment:", spam)

    scope_test()
    print("In global scope:", spam)

::

    After local assignment: test spam
    After nonlocal assignment: nonlocal spam
    After global assignment: nonlocal spam
    In global scope: global spam

参考资料
----------------

1. Python 中的作用域、global 与 nonlocal

  https://www.gairuo.com/m/python-legb

2. Scopes and Namespaces Example

  https://docs.python.org/3.11/tutorial/classes.html#python-scopes-and-namespaces