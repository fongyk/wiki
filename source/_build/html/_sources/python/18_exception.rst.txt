异常
=========

内建异常
------------

.. code-block:: python
  :linenos:

  >>> import exceptions
  >>> dir(exceptions)
  ['ArithmeticError', 'AssertionError', 'AttributeError', 'BaseException', 'BufferError', 'BytesWarning',
  'DeprecationWarning', 'EOFError', 'EnvironmentError', 'Exception', 'FloatingPointError', 'FutureWarning',
  'GeneratorExit', 'IOError', 'ImportError', 'ImportWarning', 'IndentationError', 'IndexError', 'KeyError',
  'KeyboardInterrupt', 'LookupError', 'MemoryError', 'NameError', 'NotImplementedError', 'OSError',
  'OverflowError', 'PendingDeprecationWarning', 'ReferenceError', 'RuntimeError', 'RuntimeWarning',
  'StandardError', 'StopIteration', 'SyntaxError', 'SyntaxWarning', 'SystemError', 'SystemExit', 'TabError',
  'TypeError', 'UnboundLocalError', 'UnicodeDecodeError', 'UnicodeEncodeError', 'UnicodeError', 'UnicodeTranslateError',
  'UnicodeWarning', 'UserWarning', 'ValueError', 'Warning', 'WindowsError', 'ZeroDivisionError',
  '__doc__', '__name__', '__package__']

所有异常的基类：``Exception`` 。

引发异常
----------

.. code-block:: python
  :linenos:

  >>> from exceptions import *

  >>> raise KeyError
  Traceback (most recent call last):
    File "<input>", line 1, in <module>
  KeyError

  >>> raise Exception
  Traceback (most recent call last):
    File "<input>", line 1, in <module>
  Exception

  >>> raise Exception("stack overflow")
  Traceback (most recent call last):
    File "<input>", line 1, in <module>
  Exception: stack overflow


try 语句块
---------------

.. code-block:: python
  :linenos:

  try:
    # 运行代码
    # 可能引发异常
  except exception:
  ## 多个异常：except (exception1, exception2,...)
    # 处理异常
  else:
    # 如果没有异常发生
  finally:
  ## 无论是否发生异常都将执行最后的代码
    # 最终的清理工作，如：关闭文件

例子：

.. code-block:: python
  :linenos:

  try:
    fh = open("testfile", "w")
    fh.write("这是一个测试文件，用于测试异常!!")
  except IOError:
    print "Error: 没有找到文件或读取文件失败"
  else:
    print "内容写入文件成功"
  finally:
    fh.close()

捕捉对象
-----------

::

  try:
    # 运行代码
    # 可能引发异常
  except exception, e: ## e 是一个异常对象
  ## python3: except exception as e
    # 处理异常
    print e


例子：

.. code-block:: python
  :linenos:

  >>> def foo():
  ...   try:
  ...     x = input('Enter the first number: ')
  ...     y = input('Enter the second number: ')
  ...     print x / y
  ...   except (ZeroDivisionError, TypeError), e:
  ...     print e

  >>> foo()
  Enter the first number: >? 1
  Enter the second number: >? 0
  integer division or modulo by zero

  >>> foo()
  Enter the first number: >? 1
  Enter the second number: >? 'b'
  unsupported operand type(s) for /: 'int' and 'str'


全捕捉
----------

.. code-block:: python
  :linenos:

  try:
    # 运行代码
    # 可能引发异常
  except:
    # 处理异常

捕获所有发生的异常。但这不是一个很好的方式，我们不能通过该程序识别出具体的异常信息。

可以使用：

.. code-block:: python
  :linenos:

  try:
    # 运行代码
    # 可能引发异常
  except Exception, e:
    # 处理异常
    print e

参考资料
----------

1. Python 异常处理

  https://www.runoob.com/python/python-exceptions.html
