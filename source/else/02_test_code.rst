rst语法
=========

语法测试
--------------

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

这就是 ``makefile`` 的规则，也就是 ``makefile`` 中最核心的内容。

``echo "Hello World!";``

行内公式使用 ``math`` 这个 ``role``: :math:`a^2 + b^2 = c^2`.

.. math::

   (a + b)^2  &=  (a + b)(a + b) \\
              &=  a^2 + 2ab + b^2

``latex`` math测试:

.. math::

  X_k =  \sum_{n=0}^{N-1} x_n e^{-{i 2\pi k \frac{n}{N}}} \qquad k = 0,\dots,N-1.


将高亮语言设置为 ``C`` ：

::

  .. highlight:: c
      :linenothreshold: 1

.. highlight:: c
    :linenothreshold: 1

测试 ``C`` ：

::

    int a = 0;
    char c = 'c';
    printf("%c\n", c);

这里是 ``C++`` :

.. code-block:: cpp
  :linenos:

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

将高亮语言设置为 ``python`` ：

::

  .. highlight:: python
      :linenothreshold: 2


.. highlight:: python
    :linenothreshold: 2

测试 ``python`` ：

::

    import torch
    import numpy as np
    print "hello world"

这里也是 ``python`` (code):

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

下面的代码有高亮行：

.. code-block:: python
    :linenos:
    :emphasize-lines: 2,3

    # 测试注释
    def foo():
        print "Love Python, Love FreeDome"
        print "E文标点,.0123456789,中文标点,. "

下面是 ``javescipt`` 的 rst 源码：

.. code-block:: text
  :linenos:

  .. code-block:: javascript
      :linenos:

      function whatever()
      {
          return "such color"
      }



下面是 ``bash`` :

.. code-block:: bash
    :linenos:

    cd home
    echo $PATH
    source ~/.bashrc
    ls -l
    mkdir filefolder
    cd ..

下面是 ``python`` (code-block):

.. code-block:: python
  :linenos:

  class Solution(object):
      def jump_from_i(self, nums, i):
          if i == len(nums) - 1:
              return True
          max_step = min(len(nums), i + nums[i] + 1)
          for t in range(i+1, max_step):
              if self.jump_from_i(nums, t):
                  return True
          return False
      def canJump(self, nums):
          """
          https://leetcode.com/problems/jump-game/
          Each element in the array represents your maximum jump length at that position.

          Input: [2,3,1,1,4]
          Output: true
          Explanation: Jump 1 step from index 0 to 1, then 3 steps to the last index.

          :type nums: List[int]
          :rtype: bool
          """
          if nums == []:
              return False
          if len(nums) == 1:
              return True
          return self.jump_from_i(nums, 0)

代码显示与隐藏：

.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Show/Hide\ Code}`

  .. code-block:: xml
   :linenos:

   from plone import api
   ...


插入空行使用 ``|`` 。

|
|

上面是两个空行。

使用 ``sphinx.ext.graphviz`` 扩展，下面是一个无向图：

.. graph:: foo
    :align: center
    :caption: 无向图
    :name: foo

    "bar" -- "baz";

下面是一个有向图：

.. digraph:: foo
    :align: center
    :caption: 有向图
    :name: bar

    size = "4, 4";
    main [shape=box]; /* 这是注释 */
    main -> parse [weight=8];
    parse -> execute;
    main -> init [style=dotted];
    main -> cleanup;
    execute -> { make_string; printf}
    init -> make_string;
    edge [color=red]; // 设置生效
    main -> printf [style=bold,label="100 times"];
    make_string [label="make a\n字符串"];
    node [shape=box,style=filled,color=".7 .3 1.0"];
    execute -> compare;


.. todo::

  补充更多的语法测试内容。

.. hint::

    使用 ``sphinx.ext.graphviz`` 扩展需要安装 graphviz ：
    
    .. code:: bash

      brew install graphviz

    然后设置环境变量（dot 的目录 ``which dot`` ）：

    .. code:: bash

      export PATH=$PATH:/opt/homebrew/bin

    在配置文件 conf.py 中设置导出格式 ::

      graphviz_output_format = 'svg'

.. note::

    在 mac 上安装 sphinx 5.2.3 的时候： ``brew install sphinx-doc`` ，发现自动安装了依赖 python@3.10 ，而不是用
    系统已经安装好的 /usr/bin/python ，这就导致 ``sphinx-build`` 一直找不到 /usr/bin/pip 安装的 sphinx-rtd-theme ，
    因此需要使用 ``/opt/homebrew/Cellar/python@3.10/3.10.6_2/bin/python3.10 -m pip install sphinx-rtd-theme`` 来重新安装。
    
    另外，添加环境变量 ``echo 'export PATH="/opt/homebrew/opt/sphinx-doc/bin:$PATH"' >> ~/.zshrc`` 。

    编译之后，本地查看 html 结果显示正常，但是 push 到 Github 发布之后，发现代码行号几乎紧贴代码本身，视觉效果很差。
    没找到好的解决方法，只能手动降级 sphinx ： ``/opt/homebrew/Cellar/python@3.10/3.10.6_2/bin/python3.10 -m pip install sphinx==4.5`` 。

.. warning::

    编译的时候提示：

      WARNING: html_static_path 入口 '_static' 不存在

    需要修改配置文件 conf.py::

      html_static_path = []

.. important::

    当前版本是::

      Sphinx                        4.5.0
      sphinx-rtd-theme              1.0.0
      sphinxcontrib-applehelp       1.0.2
      sphinxcontrib-devhelp         1.0.2
      sphinxcontrib-htmlhelp        2.0.0
      sphinxcontrib-jsmath          1.0.1
      sphinxcontrib-qthelp          1.0.3
      sphinxcontrib-serializinghtml 1.1.5

参考资料
-----------------

1. sphinx_rtd_theme 配置

  https://www.sphinx-doc.org/en/master/usage/configuration.html

2. sphinx themes

  https://sphinx-themes.org/

  https://www.sphinx-doc.org/en/master/usage/theming.html

3. reStructuredText

  https://www.sphinx-doc.org/zh_CN/master/usage/restructuredtext/index.html

  https://www.sphinx-doc.org/en/master/usage/restructuredtext/index.html

4. reStructuredText 域

  https://www.sphinx-doc.org/zh_CN/master/usage/restructuredtext/domains.html

5. reStructuredText Directives

  https://docutils.sourceforge.io/docs/ref/rst/directives.html

6. reStructuredText(rst)快速入门语法说明

  https://www.jianshu.com/p/1885d5570b37

7. 代码隐藏（自定义，_templates放在conf.py同目录下）

  http://cn.voidcc.com/question/p-pnfmhomd-v.html

  https://stackoverflow.com/questions/2454577/sphinx-restructuredtext-show-hide-code-snippets

8. 代码隐藏（安装扩展，全屏显示，体验不好）

  https://sphinxcontrib-contentui.readthedocs.io/en/latest/installation.html

  https://sphinxcontrib-contentui.readthedocs.io/en/latest/toggle.html

9. Sphinx + Github Page + Read the Docs

  https://kyzhang.me/2018/05/08/Sphinx-Readthedocs-GitHub2build-wiki/

  https://www.jianshu.com/p/78e9e1b8553a

  https://blog.csdn.net/baidu_25464429/article/details/80805237

  https://github.com/mathLab/PyGeM/issues/94

  https://jamwheeler.com/college-productivity/how-to-write-beautiful-code-documentation/

  https://daler.github.io/sphinxdoc-test/includeme.html

  https://github.com/rtfd/sphinx_rtd_theme

10. latex 颜色

  http://latexcolor.com/

11. graphviz

  http://graphviz.org/

  https://www.sphinx-doc.org/en/master/usage/extensions/graphviz.html

  https://blog.51cto.com/mouday/5058561
