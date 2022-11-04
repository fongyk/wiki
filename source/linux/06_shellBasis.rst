Shell 基础
===================

Shell 是命令行解释器，有众多版本，比如 sh（Bourne Shell）、bash（Bourne Again Shell）、dash（Debian Almquist Shell）。

以前 bash 是 GNU/Linux 操作系统中的 ``/bin/sh`` 的符号连接，后来有人把 bash 从 NetBSD 移植到 Linux 并更名为 dash，且 ``/bin/sh`` 符号连接到 dash。
Ubuntu 6.10 开始默认使用 dash，dash 符合 POSIX 标准。

.. code-block:: bash
    :linenos:

    $ which sh
    /usr/bin/sh
    $ ll /usr/bin/sh 
    lrwxrwxrwx 1 root root 4 Jul 19  2019 /usr/bin/sh -> dash*

标记为 ``#!/bin/sh`` 的脚本不应使用任何 POSIX 没有规定的特性（如 ``let`` 等命令）， 但 ``#!/bin/bash`` 可以，bash 支持的写法比 dash 多。

想要支持 ``sh xx.sh`` 运行的，必须遵照 POSIX 规范去写；
想要脚本写法多样化、不需要考虑效率的，可以在文件头注明 ``#!/bin/bash`` ，使用 ``bash xx.sh`` 或 ``chmod +x xx.sh; ./xx.sh`` 来执行。

后文介绍的是 bash 的一些基本语法。

.. highlight:: bash

变量
-----------

变量定义的时候不需要 `$` 符号，引用取值的时候需要。定义的时候等号两边不允许带空格::

    var="hello world"
    echo $var
    echo ${var}

引用的时候可以使用 ``{}`` 以明确变量名的边界。

使变量变为只读、不可变::

    readonly var

删除变量（不能删除只读变量）::

    unset var

字符串
----------

字符串可以用单引号、双引号，也可以不用引号，如果字符串中有空格则需要带上引号。

- 获取字符串长度：``${#string}``

- 提取子字符串：``${string:1:4}`` 从字符串第 2 个字符开始截取 4 个字符（下标从 0 开始）

数组
-----------

定义::

    array=(value0 value1 value2 value3)

或::

    array=(
    value0
    value1
    value2
    value3
    )

- 下标操作：``${arr[0]}``

- 获取全部元素：``${arr[*]}`` 或 ``${arr[@]}``

- 获取长度：``${#arr[*]}`` 或 ``${#arr[@]}``

- 遍历::

    for i in {0..3}
    do
        echo ${array[$i]}
    done

    for v in ${array[*]}
    do
        echo $v
    done

注释
----------

- 单行注释：``#``

- 多行注释::

    :<<EOF
    注释内容...
    注释内容...
    注释内容...
    EOF

    :<<'
    注释内容...
    注释内容...
    注释内容...
    '

    :<<!
    注释内容...
    注释内容...
    注释内容...
    !


传递参数
------------

在执行 Shell 脚本时，可以向脚本传递参数，脚本内获取参数的格式为：``$n`` 。 ``$1`` 为执行脚本的第一个参数，``$2`` 为执行脚本的第二个参数，以此类推；超过 9 应该使用花括号如 ``${10}`` ；``$0`` 为执行的文件名（包含文件路径）。

- 获取参数个数：``$#``

- 以单一字符串形式获取全部参数：``$*`` ，得到类似于 ``"$1 $2 … $n"`` 的值

- 以列表形式获取全部参数：``$@`` ，得到类似于 ``"$1" "$2" … "$n"`` 的值

运算
---------

数值运算
^^^^^^^^^^^^

数值计算需要借助 ``expr`` 和反引号 `````::

    a=10
    b=20
    echo `expr $a + $b`

表达式和运算符之间要有空格。

- 加：``expr $a + $b``

- 减：``expr $a - $b``

- 乘：``expr $a \* $b``

- 除：``expr $a / $b``

- 求余：``expr $a % $b``

- 赋值：``a=$b``

- 相等：``[ $a == $b ]``

- 不等：``[ $a != $b ]``

``[`` 和 ``]`` 前后有空格。

.. note::

    还有几种方式可以执行运算：

        - 使用 ``[]`` ，变量不需要 ``$`` 符号

            - ``$[a+b]``

            - ``$[a-b]``

            - ``$[a*b]``

            - ``$[a/b]``

        - 使用双圆括号：``$((a+b))`` 。

        - ``let`` 
        
            - ``let a++``
            
            - ``let a+=10``
            
            - ``let a=b*100``

.. note::

    ```command``` 等效于 ``$(command)`` ，都是获取 shell 指令执行的结果，例如 ```ls .``` 等效于 ``$(ls .)`` 。

关系运算
^^^^^^^^^^^^

关系运算符只支持数字，不支持字符串，除非字符串的值是数字。

- 相等：``[ $a -eq $b ]``

- 不等：``[ $a -ne $b ]``

- 大于：``[ $a -gt $b ]``

- 小于：``[ $a -lt $b ]``

- 大于等于：``[ $a -ge $b ]``

- 小于等于：``[ $a -le $b ]``


逻辑运算
^^^^^^^^^^^^

- 与：``[[ $a -lt 100 && $b -gt 100 ]]``

- 或：``[[ $a -lt 100 || $b -gt 100 ]]``


布尔运算
^^^^^^^^^^^^

- 非：``[ ! false ]`` 返回 true。

- 与：``[ $a -lt 20 -a $b -gt 100 ]``

- 或：``[ $a -lt 20 -o $b -gt 100 ]``


字符串运算
^^^^^^^^^^^^

- 相等：``[ $a = $b ]``

- 不等：``[ $a != $b ]``

- 长度为 0：``[ -z $a ]``

- 长度不为 0：``[ -n $a ]``

- 是否为空：``[ $a ]`` ，不为空返回 true。

在进行字符串比较时，最好使用双中括号 ``[[ ]]`` ，因为单中括号可能会导致一些错误。

文件测试
^^^^^^^^^^^^

- 目录：``[ -d $file ]``

- 普通文件（非目录、非设备文件）：``[ -f $file ]``

- 可读：``[ -r $file ]``

- 可写：``[ -w $file ]``

- 可执行：``[ -x $file ]``

- 为空（文件大小是否大于0）：``[ -s $file ]``

- 存在：``[ -e $file ]``

.. note::

    ``test`` 命令用于检查某个条件是否成立，它可以进行数值、字符和文件三个方面的测试，返回 false 或 true。

    - 数值：``test $[num1] -eq $[num2]``

    - 字符串：``test $str1 -eq $str2``

    - 文件：``test -e $file``


printf
^^^^^^^^^^^^

``printf`` 命令模仿 C 程序库里的 ``printf()`` 。

``printf`` 由 POSIX 标准所定义，因此使用 ``printf`` 的脚本比使用 ``echo`` 移植性好。

默认 ``printf`` 不会像 ``echo`` 自动添加换行符，需要手动添加 ``\n`` 。

例子::

    printf "Hello, Shell\n"
    printf "%-10s %-8s %-4s\n" 姓名 性别 体重kg  
    printf "%-10s %-8s %-4.2f\n" 郭靖 男 66.1234 
    printf "%-10s %-8s %-4.2f\n" 杨过 男 48.6543 
    printf "%-10s %-8s %-4.2f\n" 郭芙 女 47.9876 

输出::

    Hello, Shell
    姓名     性别   体重kg
    郭靖     男      66.12
    杨过     男      48.65
    郭芙     女      47.99

``%s`` ``%c`` ``%d`` ``%f`` 都是格式替代符。

``%-10s`` 指宽度为 10 个字符（ ``-`` 表示左对齐，没有则表示右对齐）。


流程控制
--------------

if else
^^^^^^^^^^^^

::

    if condition1
    then
        command1
    elif condition2 
    then 
        command2
    else
        commandN
    fi

for
^^^^^^^^^^^^

::

    for var in item1 item2 ... itemN
    do
        command1
        command2
        ...
        commandN
    done

写成单行::

    for var in item1 item2 ... itemN; do command1; command2; ...; done

for 循环的几种形式：

    - ``for i in {1..10}``

    - ``for i in $(seq 1 10)``

    - ``for ((i=1; i<=10; ++i))``

.. note::

    ``seq`` 的使用方法（ ``man seq`` ）::

        seq [option] [first [increment]] last

    ``first`` ``increment`` 缺省则默认为 1。

    参数：

        -f    输出格式。需要符合 ``printf`` 的浮点型格式，即 ``%f`` 。如果 ``first`` ``increment`` ``last`` 中有浮点数，则默认按照三者中的最高精度输出；如果都是整型，则默认为 ``%g`` 格式；指定 ``%g`` 会强制把浮点型转换成整型；``%03g`` 指定宽度为 3，用 0 补足；``prefix_%g_suffix`` 添加了前后缀。

        -s    分隔符，默认为 ``\n`` 。

        -w    等宽序列，将序列中最大值的宽度作为序列的宽度。

.. attention::

    dash 不支持 ``{1..10}`` 这种列表的写法。

while
^^^^^^^^^^^^

::

    while condition
    do
        command
    done

until
^^^^^^^^^^^^

::

    until condition
    do
        command
    done

case
^^^^^^^^^^^^

::

    case $var in
    value1)
        command1
        command2
        ...
        commandN
        ;;
    value2)
        command1
        command2
        ...
        commandN
        ;;
    esac

每一个匹配值必须以右括号 ``)`` 结束；一旦匹配到一个值，则执行完相应命令后不再继续其他匹配。

break 和 continue
^^^^^^^^^^^^^^^^^^^^^^^^

- ``break`` 跳出本层循环

- ``continue`` 跳出本次循环


函数
----------------

定义形式如下::

    [function] funname [()]
    {

        action

        [return int]

    }

上面的中括号表示该部分可以缺省。

如果不加 ``return`` ，将以最后一条命令运行结果作为返回值；返回值只能是0到255之间的整数，如果需要获取函数的计算结果，可以定义全局变量。

调用函数时可以向其传递参数，在函数体内部，通过 ``$n`` 的形式来获取参数的值，例如，``$1`` 表示第一个参数，``$2`` 表示第二个参数。

- 参数个数：``$#``

- 以单一字符串形式获取全部参数：``$*``

- 以列表形式获取全部参数：``$@``

- 脚本运行的当前进程ID：``$$``

- 返回值：``$?`` 表示返回值或显示最后命令的退出状态：0 表示没有错误，其他值表明有错误。

示例：

.. code-block:: bash
    :linenos:

    _global_var=10
    function foo()
    {
        echo "hello world"
        printf "param-1: %s\n" ${1}
        a=200
        b=125
        _global_var=$((a+b))
        return $((a+b))
    }

    foo "goodbye"
    echo $_global_var
    echo $?


输出::

    hello world
    param-1: goodbye
    325
    0


参考资料
-------------

1. Shell 教程

  https://www.runoob.com/linux/linux-shell.html
