代码块测试
============

以下来自于makefile

makefile的规则
--------------

在讲述这个makefile之前，还是让我们先来粗略地看一看makefile的规则。

.. code-block:: makefile

    target ... : prerequisites ...
        command
        ...
        ...

target
    可以是一个object file（目标文件），也可以是一个执行文件，还可以是一个标签（label）。对
    于标签这种特性，在后续的“伪目标”章节中会有叙述。
prerequisites
    生成该target所依赖的文件和/或target
command
    该target要执行的命令（任意的shell命令）

这是一个文件的依赖关系，也就是说，target这一个或多个的目标文件依赖于prerequisites中的文件，
其生成规则定义在command中。说白一点就是说::

    prerequisites中如果有一个以上的文件比target文件要新的话，command所定义的命令就会被执行。

这就是makefile的规则，也就是makefile中最核心的内容。

``echo "Hello World!";``

双冒号方式 ::

  echo "Hello World!";

说到底，makefile的东西就是这样一点，好像我的这篇文档也该结束了。呵呵。还不尽然，这是makefile
的主线和核心，但要写好一个makefile还不够，我会在后面一点一点地结合我的工作经验给你慢慢道来。内
容还多着呢。

这里是--C++--

.. code-block:: c
  :linenos:
  :emphasize-lines: 3,6

  echo "Hello World!";
  echo "Hello World!";
  echo "Hello World!";
  echo "Hello World!";
  echo "Hello World!";
  echo "Hello World!";
  echo "Hello World!";
  echo "Hello World!";
  echo "Hello World!";
  echo "Hello World!";

这里是--python--

.. code-block:: python
    :linenos:

    def foo():
        print "Love Python, Love FreeDome"
        print "E文标点,.0123456789,中文标点,. "
