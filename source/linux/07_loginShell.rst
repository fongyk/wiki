Shell 交互与登录
=======================

.. highlight:: bash


配置文件
-----------------

配置文件分为系统级和用户级。

系统级有：

- ``/etc/profile``

- ``/etc/profile.d/*.sh``

- ``/etc/bashrc`` 或 ``/etc/bash.bashrc``

- ``/etc/bash.bash_logout``

用户级有：

- ``~/.profile``

- ``~/.bash_profile``

- ``~/.bash_login``

- ``~/.bash_logout``

- ``~/.bashrc``

配置文件用于设置环境变量、执行命令或脚本、定义命令别名等。

``/etc/profile`` 配置系统级环境、执行启动程序，会调用 ``/etc/profile.d/*.sh`` ； ``/etc/bashrc`` 用于定义系统级函数和别名（alias）。启动非登录式 Shell 时， ``/etc/bashrc`` 还会调用 ``/etc/profile.d/*.sh`` 。

类似的， ``~/.bash_profile`` 配置用户级环境、执行启动程序，会调用 ``~/.bashrc`` ； ``~/.bashrc`` 用于定义用户级函数和别名（alias）， ``~/.bashrc`` 会调用 ``/etc/bashrc`` 。

这些文件不一定全部存在，依系统而定。

.. note::

    如果将一些设定的系统全局环境变量存放在 ``/etc/profile`` 或 ``/etc/bashrc`` 文件中，那么当所用 Linux 发行版升级时，该文件也会跟着升级，则所定制的所有变量设置就都被覆盖了。

    **存储系统永久性环境变量** ：建议将定制的系统全局变量存放在 ``/etc/profile.d`` 目录下新建的一个以 ``.sh`` 结尾的文件中（而不是直接修改 ``/etc/profile`` 或 ``/etc/bashrc`` ）。

    **存储个人用户永久性环境变量** ：将个人用户所有定制的环境变量写入 ``~/.bashrc`` 文件中。

交互式 Shell
--------------------

交互式 Shell 是指在终端命令行上执行，以提示符的方式在终端等待用户输入，并实时运行用户输入的命令的模式，即与用户交互的模式。

登录式（Login Shell）
^^^^^^^^^^^^^^^^^^^^^^^^^^^

交互登录式 Shell 是需要用户名和密码登录后进入的 Shell（比如终端下登录远程服务器）或者通过 -login 选项（ ``bash -login`` ）在终端启动的 Shell 。此外，执行 ``su - username`` 或 ``su -l username`` 也将进入登录式 Shell。

登入时，首先会读取启动文件 ``/etc/profile`` ， ``/etc/profile`` 是 Bash Shell 默认的主启动文件，不同 Linux 发行版其内容不尽相同。然后会执行 ``/etc/profile.d/*.sh`` 和 ``/etc/bashrc`` 。

接着检查是否存在 ``~/.bash_profile`` ，如果存在，则 bash 在当前 Shell 中执行 ``~/.bash_profile`` ，并停止寻找其他文件。如果没有找到，那么它将按照顺序查找 ``~/.bash_login`` 和 ``~/.profile`` ，并只执行第一个可读的文件。

总的来说，登录式 Shell 读取配置文件过程如下：

``/etc/profile`` –> ``/etc/profile.d/*.sh`` –> ``~/.bash_profile`` –> ``~/.bashrc`` –> ``/etc/bashrc``

交互登录式 Shell 可以使用 ``exit`` 或 ``logout`` 命令退出 Shell。

登出时首先会读取 ``~/.bash_logout`` 文件，然后会读取 ``/etc/bash.bash_logout`` 文件。

.. note::

    su 加了 ``-`` 或 ``-l`` 参数，会进入登录式 Shell，即切换到新用户之后，当前的 Shell 会加载新用户对应的环境变量和各种设置，并进入新用户的目录（ ``pwd`` ）。
    
.. note::
    
    su 表示 **switch user** ；sudo 表示 **super user do** 。 bashrc 的 rc 表示 **run commands** 。

非登录式（Non-Login Shell）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

交互非登录式 Shell 是指不需要用户名和密码也不指定 -login 选项即可打开的 Shell，比如直接在终端运行 ``bash`` 打开一个 Bash Shell，或者在 Linux 系统桌面上打开一个终端 terminal 窗口程序，亦或者通过 ``su username`` 进入。

非登录式 Shell 读取配置文件过程：

``~/.bashrc`` –> ``/etc/bashrc`` –> ``/etc/prodile.d/*.sh``

Shell 会读取（执行） ``~/.bashrc`` 文件而不会读取 ``/etc/profile`` 文件，这也是为什么修改 ``/etc/profile`` 文件后，如果未重新登录系统，则新打开的交互非登录式 Shell 下并未生效修改过的内容。

交互非登录式 Shell 只能使用 ``exit`` 退出 Shell。

.. note::

    要识别一个 Shell 是否为登录式 Shell，只需在该 Shell 下执行 ``echo $0`` ，如果输出的前缀是 ``-`` ，例如 ``-bash`` ``-su`` ，则说明是登录式 Shell。
    
.. note::

    - ``id`` 查询有效用户的 UID 和 GID、groups 信息（print real and effective user and groups）
    
    - ``who`` 查询当前登录在系统上的登录用户（登录前）的信息（show who is logged on）
    
    - ``who am i`` 等同于 ``who -m`` ，只打印执行该命令的登录用户的信息
    
    - ``whoami`` 查询当前有效用户的名字（print effective userid）； ``su`` 之后，与 ``who am i`` 打印结果是不一样的。

非交互式 Shell
----------------------

非交互式 Shell 是指以 Shell 脚本形式执行。在这种模式下，Shell 不与用户进行交互，而是读取存放在 Shell 脚本文件中的命令并执行，当读取到脚本文件结尾 ``EOF`` 时，Shell 终止。

Bash Shell 提供了 ``BASH_ENV`` 环境变量用于指定启动非交互式 Shell 时需要启动的文件（大多数 Linux 发行版没有设定该环境变量）。

非交互式 Shell 如果作为交互式 Shell 的孩子 Shell，此时会继承父 Shell 的全部全局环境变量；如果直接在交互式 Shell 下执行，则可以直接使用当前 Shell 的所有环境变量。

Shell 父子关系
---------------------

**父 Shell** 是用于登录某个远程主机或虚拟控制器终端或在 GUI 中运行终端仿真器时所启动的默认的交互式 Shell。

在当前 Shell 执行脚本文件的方式有：

- ``source script`` （script 文件可以没有可执行权限）

- ``. script`` （script 文件可以没有可执行权限）

**子 Shell** （Subshell） 是父 Shell 进程调用了 ``fork()`` 函数，在内存中复制出一个与父 Shell 进程几乎完全一样的子进程。

- 子 Shell 继承了父 Shell 的所有环境变量（包括全局和局部变量）。

- 可以通过环境变量 ``BASH_SUBSHELL`` （其值表明子 Shell 的嵌套深度）判断是第几层子 Shell（0 说明当前 Shell 不是子 Shell）。

Shell 中创建子 Shell 的方式有：

- ```command[;command...]```

- ``( command[;command...] )`` （可嵌套）

- ``command1 | command2``

::

    $ echo $BASH_SUBSHELL; (echo $BASH_SUBSHELL)
    0
    1

**孩子 Shell** （Child Shell）是父 Shell 进程调用了 ``fork()`` 函数后又调用了 ``execve()`` 函数来执行新的 Shell 命令（比如 ``bash`` ），从而覆盖 ``fork()`` 复制出来的 Shell 子进程。

- 孩子 Shell 只继承到父 Shell 的全局环境变量（而不能访问到父 Shell 的局部环境变量）。

- 可以通过环境变量 ``SHLVL`` （其值表明孩子 Shell 的嵌套深度）判断是第几层孩子 Shell（启动的第一个 Shell 其 ``SHLVL`` 为 1）。

Shell 中创建孩子 Shell 的方式有：

- ``bash script`` 以 Bash Shell 为例，script 在孩子 Shell 中执行（script 文件可以没有可执行权限）

- ``./script`` 前提是 script 文件具有可执行权限，script 在孩子 Shell 中执行

比如创建 a.sh 内容如下::

    echo 'a test'
    echo $SHLVL
    echo $SHELL
    echo $v

其中 ``v`` 是定义的局部变量，值设定为3。

执行 ``source a.sh`` ，结果为::

    a test
    1
    /bin/bash.exe
    3


执行 ``bash a.sh`` ，结果为::

    a test
    2
    /bin/bash.exe


.. note::

    全局环境变量通过 ``export`` 定义::

        export GLOBALVAR='global var'
        localvar='local var'

    删除变量定义用 ``unset`` 。

    打印当前所有全局环境变量可以用命令 ``env`` 或 ``export -p`` 。

    打印单个全局环境变量可以用命令 ``echo $HOME`` 或 ``printenv HOME`` 。


参考资料
----------------

1. linux之登录式shell和非登录式shell

  https://cloud.tencent.com/developer/article/2014892

2. LinuxShell分类

  https://cloud.tencent.com/developer/article/1948441

3. LinuxShell父子关系概述

  https://cloud.tencent.com/developer/article/1948423

4. 详解shell中source、sh、bash、./执行脚本的区别

  https://blog.51cto.com/u_15127521/3786240

5. .bashrc文件和.bash_profile文件的区别

  https://www.zhihu.com/question/22990045

6. 深度解析 Linux 命令 su 和 sudo 的区别

  https://segmentfault.com/a/1190000040873017

7. Linux 命令之who、who am i、whoami 的区别

  https://zhuanlan.zhihu.com/p/105770975
