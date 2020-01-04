更多指令
===============

.. highlight:: bash


Debian系PMS
---------------

**PMS** : Package Management System，包管理系统。主要介绍：

  - **dpkg**
  - **apt-get**
  - **apt-cache**
  - **aptitude**

dpkg
^^^^^^^^^^


- dpkg -L package_name：列出软件包所安装的所有文件

- dpkg -S absolute_file_name：查找特定的某个文件属于哪个软件包（使用绝对路径）


apt-get
^^^^^^^^^^^^^

- apt-get install package_name：安装一个新软件包

- apt-get remove package_name：卸载一个已安装的软件包（保留配置文件）

- apt-get –purge remove package_name：卸载一个已安装的软件包（删除配置文件）

- apt-get clean：删除安装的软件的备份，不过不影响软件的使用。

- apt-get update：更新 **软件包列表**

- apt-get upgrade：升级所有已安装的 **软件包** （upgrade之前先update，确保升级的是最新版本）


apt-cache
^^^^^^^^^^^^^

- apt-cache showpkg package_name：显示软件包信息

- apt-cache policy package_name：显示软件包是否已经安装、版本号等


aptitude
^^^^^^^^^^^^^

- aptitude install package_name：安装软件包

- aptitude remove package_name：删除软件包

- aptitude purge package_name：删除软件包及其配置文件

- aptitude search package_name：搜索软件包

- aptitude show package_name：显示软件包的详细信息

- aptitude clean：删除下载的软件包文件

- aptitude autoclean：仅删除过期的软件包文件

- aptitude update：更新可用的软件包列表

- aptitude upgrade：升级可用的软件包


tee
-----------

读取标准输入的数据，并将其内容输出成文件。

::

  tee [-ai] [--help] [--version] [file ...]

参数
  - -a或\- \-append：追加到既有文件

  - -i或\- \-ignore-interrupts：忽略中断信号

  - \- \-help：帮助

  - \- \-version：版本信息


.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Example}`

  .. code-block:: bash
    :linenos:

    ## 将用户输入的数据同时保存到 out1 out2
    $ tee out1 out2
    a b c d e f g # 输入
    a b c d e f g # 反馈
    ^C            # 结束输入
    $ cat out1
    a b c d e f g
    $ cat out2
    a b c d e f g

    ## 管道：将屏幕的输出保存到文件
    $ echo "hello world" | tee out
    hello world
    $ cat out
    hello world

    ## 把python程序打印到屏幕的内容保存到文件
    $ python test.py | tee out


|

查找
------------

**which** ::

  which [可执行文件...]

在PATH变量指定的路径中，搜索某个系统命令的位置，并且返回第一个搜索结果。

**whereis** ::

  whereis [-bmsu] [-BMS -f 目录...] [文件...]

只能用于程序名的搜索，而且只搜索二进制文件（-b）、帮助说明文件（-m）和源代码文件（-s）。如果省略参数，则返回所有信息。
参数：

  - -b：定位可执行文件。

  - -m：定位帮助文件。

  - -s：定位源代码文件。

  - -u：搜索默认路径下除可执行文件、源代码文件、帮助文件以外的其它文件。

  - -B：指定搜索可执行文件的路径。

  - -M：指定搜索帮助文件的路径。

  - -S：指定搜索源代码文件的路径。

**locate** ::

  locate [-d] [--help] [--version] [范本样式...]

配合数据库查找文件位置。参数：

  - -d：配置locate指令使用的数据库。locate指令预设的数据库位于/var/lib/slocate目录里，文档名为slocate.db。

**find** ::

  find pathname -options [-print -exec -ok ...]

find是在硬盘文件树查找。参数：

  - pathname：查找的目录。例如用 . 来表示当前目录，用 / 来表示系统根目录。

  - -name：按照文件名查找文件。

  - -print：将匹配的文件输出到标准输出。也可以使用 ``>`` 或  ``>>`` （追加）写到文件。

  - -exec：对匹配的文件执行该参数所给出的shell命令。相应命令的形式为 ``'command' {} \;`` ，注意 ``{}`` 和 ``\;`` 之间的空格。

  - -ok：和-exec的作用相同，只不过以一种更为安全的模式来执行该参数所给出的shell命令，在执行每一个命令之前，都会给出提示，让用户来确定是否执行。


.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Example}`

  .. code-block:: bash
    :linenos:

    $ which python
    /usr/bin/python

    $ whereis -s -S /usr/lib -f python
    python: /usr/lib/python3.5 /usr/lib/python2.7

    $ locate /usr/bin/pytho ## 以 pytho 开头的文件
    /usr/bin/python
    /usr/bin/python-config
    /usr/bin/python2
    ...

    ## 查找 /var/log 中扩展名为 .tmp 的文件，并在删除之前询问用户 （y/n）
    $ find /var/log -name "*.tmp" -ok rm {} \;
    < rm ... ./t.tmp > ? y

|

alias
---------

alias 命令用来设置指令的别名；我们可以使用该命令可以将一些较长的命令进行简化。
使用 alias 时，用户必须使用引号将原来的命令引起来，防止特殊字符导致错误。

alias 命令的作用只局限于该次登入的操作，可以写入 `~/.bashrc` 中。

::

  alias 新的命令='原命令 -选项/参数'

如： ::

  alias ll='ls -lsh'

删除： ::

  unalias ll

参考资料
--------------
1. runoob.com

  https://www.runoob.com/linux/linux-comm-tee.html

  https://www.runoob.com/linux/linux-comm-find.html

2. 每天一个linux命令目录

  http://www.cnblogs.com/peida/archive/2012/12/05/2803591.html

3. aptitude和apt-get的区别和联系【转，有添加和修改】

  https://blog.csdn.net/u010670794/article/details/42520209

4. apt-get update与upgrade的区别

  https://www.jianshu.com/p/42a1850bdcf6
