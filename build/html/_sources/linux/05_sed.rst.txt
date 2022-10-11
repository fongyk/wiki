sed
===========

sed（stream editor，流编辑器），利用脚本处理文本文件。

-i    直接修改文件内容（默认输出到控制台，不改变原文件）。

-e <script>    以选项中指定的 script 来处理输入的文本文件。

-f <script文件>    以选项中指定的 script 文件来处理输入的文本文件。

-h    显示帮助。

-n    仅显示 script 处理后的结果。

-V    显示版本信息。

动作：

    - ``a`` 追加

    - ``c`` 替换行

    - ``d`` 删除

    - ``i`` 插入

    - ``p`` 打印

    - ``s`` 替换

正则表达式基础
-------------------

- ``^`` 表示一行的开头，如：``^#`` 表示以 ``#`` 开头的匹配。
- ``$`` 表示一行的结尾，如：``}$`` 表示以 ``}`` 结尾的匹配。
- ``\<`` 表示词首，如：``\<abc`` 表示以 ``abc`` 为首的词。
- ``\>`` 表示词尾，如：``abc\>`` 表示以 ``abc`` 结尾的词。
- ``.`` 表示任何单个字符。
- ``*`` 表示某个字符出现了0次或多次。
- ``[ ]`` 表示字符集合，如：``[abc]`` 表示匹配 ``a`` 或 ``b`` 或 ``c`` ， ``[a-zA-Z]`` 表示匹配所有的26个字母；``^`` 表示取反，如 ``[^a]`` 表示 ``非a`` 的字符。


匹配与替换
------------------

单个匹配
^^^^^^^^^^^^^^^^^

- ``sed "s/^/#/g" foo.txt`` ：在行首加 #。

- ``sed "3s/my/your/g" foo.txt`` ：只在第3行替换。

- ``sed "3,6s/my/your/g" foo.txt`` ：在第3行至第6行替换（闭区间），逗号后面没有空格。

- ``sed "s/my/your/1g" foo.txt`` ：替换每行的第一个匹配。

- ``sed "s/my/your/2g" foo.txt`` ：替换每行的第二个匹配。

- ``sed "s/my/your/g" foo.txt`` ：替换每行的所有匹配。

- ``sed "s/my/*&*/g" foo.txt`` ：使用 ``&`` 来指代需要替换的模式，可以方便地在其周围增加其他字符（ ``*my*`` ）。

一个例子，html.txt::

    <b>This</b> is what <span style="text-decoration: underline;">I</span> meant. Understand?

目标：去掉 html.txt 中所有的 ``<*>`` 。

    - ``sed "s/<.*>//g" html.txt`` 结果：``meant. Understand?`` （开头有空格）。

    - ``sed "s/<[^>]*>//g" html.txt`` 结果：``This is what I meant. Understand?`` 。``[^>]`` 表示除 ``>`` 之外的字符集合。

如果指令使用双引号，碰到需要替换单引号的情况可以不对单引号使用转义符号。

多个匹配
^^^^^^^^^^^^^^^^^

下面两个命令等价：第1-3行把 ``my`` 替换为 ``your`` ，从第3行开始把 ``This`` 替换为 ``That`` 。

- ``sed '1,3s/my/your/g; 3,$s/This/That/g' foo.txt``

- ``sed -e '1,3s/my/your/g' -e '3,$s/This/That/g' foo.txt``

.. note::

    上面的指令使用的是单引号，双引号和 ``3,$`` 类似的模式搭配会报错。

圆括号匹配
^^^^^^^^^^^^^^^^^

圆括号括起来的正则表达式所匹配的字符串可以当成变量来使用，通过 ``\1``，``\2``……来解引用变量。

foo.txt::

    This is my cat, my cat's name is betty
    This is my dog, my dog's name is frank
    This is my fish, my fish's name is george
    This is my goat, my goat's name is adam

``sed "s/This is my \(.*\),.*is \(.*\)/\1:\2/g" foo.txt`` 得到::

    cat:betty
    dog:frank
    fish:george
    goat:adam


动作
-----------------

a和i
^^^^^^^^^^^^^^

- ``sed "1 i This is my monkey, my monkey's name is wukong" foo.txt`` 在第一行之前插入

- ``sed "$ a This is my monkey, my monkey's name is wukong" foo.txt`` 在最后一行之后追加

- ``sed "/my/a ----" foo.txt`` 在匹配到 ``my`` 的每一行之后追加 ``----``


c
^^^^^^^^^^^^^

- ``sed "2 c This is my monkey, my monkey's name is wukong" foo.txt`` 对第二行替换

- ``sed "/fish/c This is my monkey, my monkey's name is wukong" foo.txt`` 对匹配到 ``fish`` 的行进行整行替换


d
^^^^^^^^

- ``sed "2d" foo.txt`` 删除第二行

- ``sed '2,$d' foo.txt`` 删除第二行及之后的行

- ``sed "/fish/d" foo.txt`` 删除匹配到 ``fish`` 的行


p
^^^^^^^^^^

打印，搭配参数 ``-n`` 使用，只打印匹配的行，否则会打印所有的行以及匹配的行。

- ``sed -n '/fish/p' foo.txt`` 打印匹配到 ``fish`` 的行

- ``sed -n '/dog/,/fish/p' foo.txt`` 打印匹配到 ``dog`` 和 ``fish`` 之间的行

- ``sed -n '1,/fish/p' foo.txt`` 从第一行打印到匹配 ``fish`` 的行


参考资料
-------------

1. Linux sed 命令

  https://www.runoob.com/linux/linux-comm-sed.html

2. SED 简明教程

  https://coolshell.cn/articles/9104.html

3. sed, a stream editor

  http://www.gnu.org/software/sed/manual/sed.html
