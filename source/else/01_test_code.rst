rst语法测试
============

``makefile`` 规则：

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

这就是``makefile`` 的规则，也就是``makefile`` 中最核心的内容。

``echo "Hello World!";``

行内公式使用 ``math`` 这个``role``: :math:`a^2 + b^2 = c^2`.

.. math::

   (a + b)^2  &=  (a + b)(a + b) \\
              &=  a^2 + 2ab + b^2

``latex`` math测试:

.. math::

  X_k =  \sum_{n=0}^{N-1} x_n e^{-{i 2\pi k \frac{n}{N}}} \qquad k = 0,\dots,N-1.


将高亮语言设置为``C``

.. highlight:: c
    :linenothreshold: 1

测试 ``C`` ::

    int a = 0;
    char c = 'c';
    printf("%c\n", c);

这里是 ``C++`` :

.. code-block:: cpp
  :linenos:
  :emphasize-lines: 3-5

  int main()
  {
    int i;
    int j;
    cin >> i >> j;
    cout << i << j << endl;
    return 1;
  }
  // 主函数注释

斜体 `text`

将高亮语言设置为 ``python``

.. highlight:: python
    :linenothreshold: 1

测试python::

    import torch
    import numpy as np
    print "hello world"

这里是 ``python`` (code):

.. code::

    def foo():
        print "Love Python, Love FreeDome"
        print "E文标点,.0123456789,中文标点,. "

如果数据库有问题, 执行下面的 ``SQL``:

.. code-block:: sql

   -- Dumping data for table `item_table`
   INSERT INTO item_table VALUES (
   0000000001, 0, 'Manual', '', '0.18.0',
   'This is the manual for Mantis version 0.18.0.\r\n\r\nThe Mantis manual is modeled after the [url=http://www.php.net/manual/en/]PHP Manual[/url]. It is authored via the \\"manual\\" module in Mantis CVS.  You can always view/download the latest version of this manual from [url=http://mantisbt.sourceforge.net/manual/]here[/url].',
     '', 1, 1, 20030811192655);

下面是``python``：

.. code-block:: python
    :linenos:
    :emphasize-lines: 2,3

    # 测试注释
    def foo():
        print "Love Python, Love FreeDome"
        print "E文标点,.0123456789,中文标点,. "

下面是 ``javescipt`` 的rst源码::

  .. code-block:: javascript
      :linenos:

      function whatever()
      {
          return "such color"
      }

下面是``python`` (code-block)::

  def foo():
      print "Love Python, Love FreeDome"
      print "E文标点,.0123456789,中文标点,. "

下面是``bash``:

.. code-block:: bash
    :linenos:

    cd home
    echo $PATH
    source ~/.bashrc
    ls -l
    mkdir filefolder
    cd ..

结束
