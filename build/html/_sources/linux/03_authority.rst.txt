权限管理
=================

文件描述符
---------------

``ls -l`` 命令输出的第 1 个字段就是描述文件和目录权限的编码。

::

  drwxrwxr-x 13 fong fong 4096 5月   7 10:33 source/


第一个字符代表对象的类型：

  - -：普通文件
  - d：目录
  - l：链接
  - c：字符型设备文件
  - b：块设备文件
  - n：网络设备文件

之后是 3 组三字符的编码，每一组定义了 3 种访问权限（若没有某种权限，使用 \- 代替）：

  - r：可读
  - w：可写
  - x：可执行

``ls -F`` 会在可执行文件的文件名后加一个 ``*`` ，目录后方加 ``/`` 。

3 组权限对应对象的 3 个安全等级：

  - 对象的属主（登录名 fong）
  - 对象的属组（组名 fong）
  - 系统其它用户

第 2 个字段是文件链接数，第 3 个字段是属主，第 4 个字段是属组，第 5 个字段是占用存储大小，第 6 个字段是最后修改时间。

.. note::

  除了 ``r`` ``w`` ``x`` ，还会见到 ``s`` ``t`` ，分别表示 SetUid/SetGid、粘滞位。


粘滞位
----------------

.. code-block:: bash
  :linenos:

  $ ll / | grep tmp
  drwxrwxrwt 1 root root 4.0K 2022-11-20 22:16:34 tmp/
  $ ll /var | grep tmp
  drwxrwxrwt 2 root root 4.0K 2022-08-27 01:43:44 tmp/

上面两个存放临时文件的系统目录的权限最后一位是 ``t`` ，这是粘滞位。当目录被设置了粘滞位以后，即使用户对该目录有写权限，也不能删除该目录中其他用户的文件，只有文件的拥有者和 root 用户才可以删除。这就达到了各个用户可以在同一目录中读、写、修改、删除文件，但是不能随意删除其他用户文件的目的。

设置粘滞位：

.. code:: bash

  chmod +t <dir>

.. note::

  如果权限最后一位是 ``T`` ，说明该目录没有可执行权限，应执行： ``chmod +x <dir>`` 。

默认文件权限
----------------

``umask`` 查看默认文件权限， ``unask -S`` 打印符号化的权限：

.. code-block:: bash
  :linenos:

  $ umask
  0002
  $ umask -S
  u=rwx,g=rwx,o=rx
  ## 临时修改默认权限 （若要长期生效，把 umask 0022 写进 ~/.bashrc）
  $ umask 0022
  $ umask
  0022
  $ umask -S
  u=rwx,g=rx,o=rx

第 1 位用于 SetUid（对应 4 ）或 SetGid（对应 2 ）或粘着位（Sticky Bit，对应 1），后 3 位表示文件或目录对应的 umask 八进制值，分别对应 3 组权限。

.. table:: Linux文件权限码
  :align: center

  ===========================    ===========================    ===========================
              权限                          二进制值                       八进制值
  ===========================    ===========================    ===========================
              \- \- \-                        000                            0
              \- \- x                         001                            1
              \- w \-                         010                            2
              \- w x                          011                            3
              r \- \-                         100                            4
              r \- x                          101                            5
              r w \-                          110                            6
              r w x                           111                            7
  ===========================    ===========================    ===========================


umask 值只是 **掩码** ，屏蔽不想授予的权限，即：真正的权限是用 **全权限** 值减去 umask 值（逻辑与运算）。
文件的默认全权限值是 **666** ，目录的全权限值是 **777** 。当 umask=0022，新建文件默认权限是 644，新建目录默认权限是 755。

.. code-block:: bash
  :linenos:

  $ which passwd
  /usr/bin/passwd
  $ ll /usr/bin/passwd
  -rwsr-xr-x 1 root root 63K 2022-03-14 16:26:09 /usr/bin/passwd*

``passwd`` 这个指令的属主权限里面有个 ``s`` ，说明这个文件设置了 SetUid，作用是：拥有该文件的执行权限的任意用户，在执行该文件的时候，都是以该文件的属主（root）的权限来执行的。因为用户密码需要写入 /etc/shadow ，而普通用户是没有权限直接写这个文件的。

.. attention::

  基于安全考虑，很多操作系统会忽视对 Shell 脚本进行 SetUid 的操作，执行脚本的时候不会赋予期望的权限。

.. note::

  修改文件或目录的属主、属组使用命令 ``chown`` ，需要 root 权限。

改变权限
-----------------

::

  chmod [-cfvR] [--help] [--version] [mode] [file...]

参数：

  -c    若该文件权限确实已经更改，才打印更改动作

  -f    若该文件权限无法被更改，也不打印错误讯息

  -v    打印权限变更的详细动作

  -R    对目前目录下的所有文件与子目录进行相同的权限变更（即以递回的方式逐个变更）

mode:

::

  [ugoa] [+-=] [rwxXst]

- u 表示对象的属主，g 表示对象的属组成员，o 表示系统其它用户，a 表示所有用户。

- \+ 表示增加权限、- 表示取消权限、= 表示唯一设定权限。

- r 表示可读，w 表示可写，x 表示可执行。

.. code-block:: bash
  :linenos:

  $ mkdir test
  $ ls -l
  drwxr-xr-x  2 fong fong 4096 5月   7 13:34 test/
  $ chmod -v 777 test
  mode of 'test' changed from 0755 (rwxr-xr-x) to 0777 (rwxrwxrwx)
  $ chmod -v a-w test
  mode of 'test' changed from 0777 (rwxrwxrwx) to 0555 (r-xr-xr-x)


参考资料
---------------


1. chmod(1) — Linux manual page

  https://man7.org/linux/man-pages/man1/chmod.1.html

2. chown(2) — Linux manual page

  https://man7.org/linux/man-pages/man2/chown.2.html

3. How Do I Set Up Setuid, Setgid, and Sticky Bits on Linux?

  https://www.liquidweb.com/kb/how-do-i-set-up-setuid-setgid-and-sticky-bits-on-linux/

4. umask leading 0

  https://askubuntu.com/questions/741321/umask-leading-0

5. Shell 命令运行原理和权限详解

  https://mp.weixin.qq.com/s/Uz50VbCmzpIqcB7aPwu3gw