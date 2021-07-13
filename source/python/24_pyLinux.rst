Python 执行 linux 命令
===========================

os.system
---------------

::

    os.system("cmd")

返回值是 shell 指令运行后返回的状态码，0 表示 shell 指令成功执行；256 表示未找到。该方法适用于 shell 命令不需要输出内容的场景。

.. code-block:: python
    :linenos:

    >>> import os
    >>> res = os.system("pwd")
    /data6/fong/maskrcnn_env/
    >>> res
    0
    >>> os.system("echo \"hello world\"")
    hello world
    0


os.popen
----------------
::

    os.popen("cmd")


返回一个类文件对象。当需要得到外部程序的输出结果时，本方法非常有用。调用该对象的 ``read()/readline()/readlines()`` 方法可以读取输出内容。

.. code-block:: python
    :linenos:

    >>> import os
    >>> res = os.popen("pwd")
    >>> res
    <os._wrap_close object at 0x7fa0b279ccf8>
    >>> res.read() ## 读取所有内容，放到一个字符串中
    '/data6/fong/maskrcnn_env\n'

    >>> res = os.popen("pwd")
    >>> res.readline()
    '/data6/fong/maskrcnn_env\n'

    >>> res = os.popen("pwd")
    >>> res.readlines()
    ['/data6/fong/maskrcnn_env\n']


subprocess
----------------

subprocess 模块允许我们启动一个新进程，并连接到它们的 stdin/stdout/stderr 管道，从而获取返回值。

run
^^^^^^^^^^

::

    subprocess.run(args, *, stdin=None, input=None, stdout=None, stderr=None, capture_output=False, shell=False, cwd=None, timeout=None, check=False, encoding=None, errors=None, text=None, env=None, universal_newlines=None)

- ``args`` ：表示要执行的命令，是一个字符串或参数列表。

- ``stdin/stdout/stderr`` ：子进程的标准输入、输出和错误。其值可以是 ``subprocess.PIPE`` 、 ``subprocess.DEVNULL`` 、一个已经存在的文件描述符、已经打开的文件对象或者  ``None`` 。

- ``shell`` ：如果该参数为 ``True`` ，将通过操作系统的 shell 执行指定的命令。

.. code-block:: python
    :linenos:


    >>> import subprocess

    >>> res = subprocess.run(["ls", "-l", "./code"])
    total 52
    drwxrwxr-x 11 fong fong  4096 3月  13 19:19 Clothes-Detection
    drwxrwxr-x  6 fong fong  4096 3月  13 11:37 DeepFashion2
    drwxrwxr-x  6 fong fong  4096 3月  13 19:23 Deep-Fashion-Analysis-ECCV2018
    drwxrwxr-x  5 fong fong  4096 3月  13 11:43 DeepFashion-retrieval-2019
    drwxrwxr-x  7 fong fong 36864 4月   1 13:20 utils
    >>> res
    CompletedProcess(args=['ls', '-l', './code'], returncode=0)

    >>> res = subprocess.run(["ls", "./code"], stdout=subprocess.PIPE)
    >>> res
    CompletedProcess(args=['ls', './code'], returncode=0, stdout=b'Clothes-Detection\nDeepFashion2\nDeep-Fashion-Analysis-ECCV2018\nDeepFashion-retrieval-2019\nutils\n')
    >>> res.stdout
    b'Clothes-Detection\nDeepFashion2\nDeep-Fashion-Analysis-ECCV2018\nDeepFashion-retrieval-2019\nutils\n'


Popen
^^^^^^^^^^^^^^

::

    class subprocess.Popen(args, bufsize=-1, executable=None, stdin=None, stdout=None, stderr=None, preexec_fn=None, close_fds=True, shell=False, cwd=None, env=None, universal_newlines=None, startupinfo=None, creationflags=0, restore_signals=True, start_new_session=False, pass_fds=(), *, encoding=None, errors=None, text=None)

.. code-block:: python
    :linenos:

    >>> import subprocess
    >>> p = subprocess.Popen("echo 16", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    >>> res = p.stdout.read()
    >>> type(res)
    <class 'bytes'>
    >>> res
    b'16\n'
    >>> float(res)
    16.0


pbs
------------

需要安装 pbs 包（更新后为 sh 包）。

.. code-block:: python
    :linenos:

    >>> import sh as pbs
    >>> pbs.ls("/")
    bin    data1  data5  home            lib32       mnt   run   sys  vmlinuz
    boot   data2  data6  initrd.img      lib64       opt   sbin  tmp  vmlinuz.old
    cdrom  data3  dev    initrd.img.old  lost+found  proc  snap  usr
    core   data4  etc    lib             media       root  srv   var
    >>> pbs.which("python")
    '/home/fong/anaconda3/envs/maskrcnn_benchmark/bin/python'


附录：os 常用命令
---------------------

- ``os.remove`` 删除文件

- ``os.rename`` 重命名文件

- ``os.walk`` 生成目录树下的所有文件名

- ``os.chdir`` 改变目录

- ``os.mkdir/os.makedirs`` 创建目录/多层目录

- ``os.rmdir/os.removedirs`` 删除目录/多层目录

- ``os.listdir`` 列出指定目录的文件

- ``os.getcwd`` 取得当前工作目录

- ``os.chmod`` 改变目录权限

- ``os.path.basename`` 去掉目录路径，返回文件名

- ``os.path.dirname`` 去掉文件名，返回目录路径

- ``os.path.join`` 将分离的各部分组合成一个路径名

- ``os.path.getsize`` 返回文件大小

- ``os.path.exists`` 是否存在

- ``os.path.isabs`` 是否为绝对路径

- ``os.path.isdir`` 是否为目录

- ``os.path.isfile`` 是否为文件


参考资料
-----------

1. python调用linux命令的方法

  https://blog.csdn.net/ZG_24/article/details/80733935

2. subprocess — Subprocess management

  https://docs.python.org/3.7/library/subprocess.html

3. Python3 subprocess

  https://www.runoob.com/w3cnote/python3-subprocess.html