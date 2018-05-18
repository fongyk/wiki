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

下面是几个定义：

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

行内公式使用 ``math`` 这个role :math:`a^2 + b^2 = c^2`.

.. math::

   (a + b)^2  &=  (a + b)(a + b) \\
              &=  a^2 + 2ab + b^2

``latex`` math测试:

.. math::

  X_k =  \sum_{n=0}^{N-1} x_n e^{-{i 2\pi k \frac{n}{N}}} \qquad k = 0,\dots,N-1.


.. .. highlight:: c
..     :linenothreshold: 1

这里是 ``C++`` :

.. code-block:: cpp
  :linenos:
  :emphasize-lines: 3,4

  int main()
  {
    int i;
    int j;
  }
  // 主函数注释

`text` 这里是 ``python`` :

.. code-block:: python
    :linenos:

    def foo():
        print "Love Python, Love FreeDome"
        print "E文标点,.0123456789,中文标点,. "

如果数据库有问题, 执行下面的 ``SQL``::

   # Dumping data for table `item_table`

   INSERT INTO item_table VALUES (
     0000000001, 0, 'Manual', '', '0.18.0',
     'This is the manual for Mantis version 0.18.0.\r\n\r\nThe Mantis manual is modeled after the [url=http://www.php.net/manual/en/]PHP Manual[/url]. It is authored via the \\"manual\\" module in Mantis CVS.  You can always view/download the latest version of this manual from [url=http://mantisbt.sourceforge.net/manual/]here[/url].',
     '', 1, 1, 20030811192655);

來源：简书

.. highlight:: python
    :linenothreshold: 1

.. code-block:: python
    :linenos:

    # 测试注释
    def foo():
        print "Love Python, Love FreeDome"
        print "E文标点,.0123456789,中文标点,. "

著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
