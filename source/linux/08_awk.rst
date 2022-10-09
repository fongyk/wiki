awk
=========

awk 是一门解释型的编程语言，用于文本处理，它的名字来源于三位作者的姓氏首字母。

.. note::

    查看 awk 帮助文档： ``man awk`` 或 ``awk --help`` 。


命令模式
---------------

::

    awk 'BEGIN {awk-commands} pattern {awk-commands} END {awk-commands}' fileName


- awk-commands 代码块必须包含在花括号 ``{}`` 中。

- 匹配模式 pattern **可选** ，用于筛选符合条件的记录（行），可以使用正则表达式。

- BEGIN 语句块 ``BEGIN {awk-commands}`` **可选** ，只执行一次，在这里可以初始化变量。

- BODY 语句块 ``pattern {awk-commands}`` ，这里的命令会对输入的每一行执行。

    - 如果没有 ``fileName`` 或其他输入流且存在 BODY 语句块，BODY 语句块会进入死循环。
    
    - 代码语句表达式以分号结束，也可以用换行符结束。

    - 如果没有 ``{awk-commands}`` ，默认的动作是打印记录（行）。

- END 语句块 ``END {awk-commands}`` **可选** ，在处理完所有行之后执行。


常用的内建变量
------------------

===============  ================================================
变量	           描述
===============  ================================================
$0	              完整的输入记录（当前行的内容）
$n	              当前记录（当前行）的第 n 个字段，字段间由 ``FS`` 分隔
ARGC	          命令行参数数目
ARGV	          命令行参数数组
ENVIRON	          环境变量
ERRNO	          最后一个系统错误的描述
FILENAME	      当前文件名
FS	              字段分隔符（默认是空格、制表符）；通过 ``-F`` 指定，或在 BEGIN 语句块中指定
IGNORECASE     	  进行忽略大小写的匹配
NF	              一条记录（一行）的字段的数目
NR	              已经读出的记录数，即行号，从 1 开始
FNR	              和 NR 类似；如果存在多个输入文件，FNR 是当前文件的行号
OFS	              输出字段分隔符（默认是一个空格）；通过 ``-v`` 指定，或在 BEGIN 语句块中指定
ORS	              输出行分隔符（默认是一个换行符）；通过 ``-v`` 指定，或在 BEGIN 语句块中指定
RLENGTH	          由 match 函数所匹配的字符串的长度
RS	              记录分隔符（默认是一个换行符）
RSTART	          由 match 函数所匹配的字符串的第一个位置
ARGIND	          循环处理数据时，当前被处理的 ARGV 的索引
PROCINFO	      包含进程信息的关联数组，例如UID、进程ID等
===============  ================================================

::

    % awk 'BEGIN {print ENVIRON["USER"]}'
    fong
    % awk 'END {print FILENAME}' test.txt
    test.txt
    % awk 'BEGIN { 
        for (i = 0; i < ARGC; ++i) {
            printf "ARGV[%d] = %s\n", i, ARGV[i]
        }
    }' first second
    ARGV[0] = awk
    ARGV[1] = first
    ARGV[2] = second

::

    % echo "a b c\n1\t2\t3" > test.txt
    % cat test.txt 
    a b c
    1	2	3
    % awk '{print $0 $1 $2}' test.txt
    a b cab
    1	2	312
    % awk '{print $0,$1,$2}' test.txt               
    a b c a b
    1	2	3 1 2  
    % awk 'BEGIN{OFS="#"; ORS="***"} {print "LINE-"NR,$0,$1,$2}' test.txt
    LINE-1#a b c#a#b***LINE-2#1	2	3#1#2***
    % awk 'BEGIN{OFS="#"} {$1=$1; print "LINE-"NR,$0,$1}' test.txt 
    LINE-1#a#b#c#a
    LINE-2#1#2#3#1

打印语句中需要使用 ``,`` 作为分隔符，如果是空格则 ``OFS`` 不会生效。如果想对原始输入（ ``$0`` ）也使用输出分隔符，需要先对输入字段进行操作（如 ``$1=$1`` ）。

.. note::

    awk 命令中的字符串使用双引号。

基础语法
----------------

流程控制
^^^^^^^^^^

::

    #-------- 伪代码 1  ---------
    if (condition)
        代码逻辑...
    else if(condition)
        代码逻辑...
    else
        代码逻辑...

    #-------- 伪代码 2  ---------
    for (初始化; condition; 后续逻辑){
        代码逻辑...
    }   

    #-------- 伪代码 3  ---------
    while (condition){
        代码逻辑...
    }

    #-------- 伪代码 4  ---------
    do{
        代码逻辑...
    }while (condition)   


常用运算符
^^^^^^^^^^^^^^^^

=================================== ========================= =========================
符号	                                说明	                     示例
=================================== ========================= =========================
``^``	                             指数操作符	                 ``a = a ^ 2``
``-`` ``+`` ``*`` ``/``	             一元操作符	                 ``a = -10; a += 3;``
``condition? action1: action2``	     三元操作符                    ``a > b ? max = a : max = b;``
``!`` ``&&`` ``||``	                 逻辑操作符                	  ``if (num >= 0 && num <= 7)``
``==`` ``!=`` ``>`` ``<``            关系运算符	                  ``if (a == b)``
=================================== ========================= =========================

::

    % awk 'BEGIN{a=3; b=2; a > b ? c=a: c=b; print c}'
    3


数组
^^^^^^^^^^^^^^^

awk 支持普通数组和关联数组，也就是说，不仅可以使用数字索引（从 1 开始）的数组，还可以使用字符串作为索引。

::

    % awk 'BEGIN {arr["a"] = 1; arr["b"] = 2; for (i in arr) printf "arr[%s] = %d\n", i, arr[i]}'
    arr[a] = 1
    arr[b] = 2


删除数组元素使用 delete 语句如 ``delete arr[0]`` ；获取数组长度 ``length(arr)`` 。


字符串操作
^^^^^^^^^^^^^^^

- ``length(str)`` ：获取 str 长度。

- ``match(str, regex)`` ： str 是否匹配 regex 模式，返回布尔值，匹配的位置保存在 ``RSTART`` 和 ``RLENGTH`` 。

- ``split(str, arr, fs)`` ：使用 fs（缺省为 ``FS`` ） 分隔字符串 str，结果保存在数组 arr 中，返回数组 arr 的长度。

- ``substr(str, start, l)`` ：返回子字符串 str[start:start+l]。

- ``tolower(str)`` ：转小写。

- ``toupper(str)`` ：转大写。

::

    % awk 'BEGIN { str1 = "hello"; str2 = "world"; str3 = str1" "str2; print str3, length(str3); if(match(str3, "h.*w")) print RSTART, RLENGTH}' 
    hello world 11
    1 7

正则表达式
^^^^^^^^^^^^^^^

awk 支持正则表达式，需要放在斜杠中： ``/regexp/`` 。另外，awk 还有两个匹配符： ``~`` 和 ``!~`` 分别代表匹配和不匹配，搭配正则表达式使用。

::

    % echo "tom man 20\njerry man 18\nalice woman 25" > test.txt
    % cat test.txt 
    tom man 20
    jerry man 18
    alice woman 25
    # 第 2 个字段包含 woman 的行
    % awk '$2 ~ /woman/' test.txt
    alice woman 25
    # 第 3 个字段不以 1 开头的行
    % awk '$3 !~ /^1[0-9]*/' test.txt
    tom man 20
    alice woman 25
    # 包含 man 的行
    % awk '/man/' test.txt 
    tom man 20
    jerry man 18
    alice woman 25


运行文件脚本
-----------------

脚本以 ``.awk`` 为后缀，执行： ``awk -f commands.awk test.txt`` 。

::

    % cat a.awk 
    BEGIN{
        cnt = 0;
    }

    {cnt++; print NR, $0}

    END{
        print FILENAME, cnt" lines"
    }
    % awk -f a.awk test.txt 
    1 tom man 20
    2 jerry man 18
    3 alice woman 25
    test.txt 3 lines

参考资料
----------------

1. 技能篇：awk教程-linux命令

  https://www.cnblogs.com/cscw/p/14878531.html

2. awk

  https://www.w3cschool.cn/awk/4u5m1k8n.html
