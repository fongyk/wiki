基本命令
============

系统目录
------------

.. code:: bash

  ls /

该指令可以查看系统根目录。注意， ``/`` 是指根目录，而不是当前目录。

- **/bin** ：binary 的缩写, 这个目录存放着最经常使用的命令。

- **/boot** ：存放的是启动 Linux 时使用的一些核心文件，包括一些连接文件以及镜像文件。

- **/dev** ：device 的缩写, 该目录下存放的是 Linux 的外部设备，访问方式和访问文件是相同的。

- **/etc** ：存放系统管理所需要的配置文件和子目录。

- **/home** ：用户的主目录。

- **/lib** ：存放着系统最基本的动态连接共享库，其作用类似于 Windows 里的 DLL 文件。

- **/lost+found** ：当系统非法关机后，这里就存放了一些文件。

- **/media** ：系统会自动识别一些设备，例如 U 盘、光驱等等，当识别后，会把识别的设备挂载到这个目录下。

- **/mnt** ：临时挂载别的文件系统。

- **/root** ：超级权限者的用户主目录。

- **/usr** ：用户的很多应用程序和文件都放在这个目录下，类似于 Windows 下的 program files 目录。

- **/usr/bin** ：使用的应用程序与指令。

- **/var** ：将经常被修改的目录放在这个目录下，包括各种日志文件以及备份文件。



文件和目录
--------------------

.. code-block:: bash
    :linenos:

    cd ..
    pwd
    ls -a -F -R -l

    cp [-i] src dst
    cp -R

    mv src des
    rm -i -r -f folder

    ## 创建新文件或修改文件时间属性
    touch new 

    mkdir new
    rmdir new

    ## 查看文件类型
    file my_file 

    cat -n log.txt
    tail log.txt
    ## 追踪、动态打印
    tail -f log.txt 
    head -5 log.txt

    wc file -c -w -l

    ## 统计当前目录下的文件个数（不包括子目录中的文件）
    ls -l | grep "^-" | wc -l 
    ## 统计当前目录下的文件个数（包括子目录中的文件）
    ls -lR | grep "^-" | wc -l 
    ## 统计以 b 开头的目录下的全部文件个数（包括子目录中的文件）
    ls -lR b*/ | grep "^-" | wc -l 
    ## 统计当前目录下的目录/文件夹个数（不包括子目录中的文件）
    ls -l | grep "^d" | wc -l 



磁盘空间
------------

.. code-block:: bash
    :linenos:

    df -h
    du [-s] -h

处理数据文件
----------------

.. code-block:: bash
    :linenos:

    ## -n : 行号
    sort [-n] log.txt 

    ## find *t* in file
    grep [-n] [-c] t file 

    gzip my*
    gunzip myfile.gz

    tar -cvf test.tar test/
    tar -xvf test.tar
    tar -xzvf test.tgz

系统信息
----------------

.. code-block:: bash
    :linenos:

    ## 内核版本、硬件架构、处理器
    uname -a 
    ## 操作系统版本
    cat /etc/issue 
    ## cpu 信息
    cat /proc/cpuinfo
    ## 内存信息 
    cat /proc/meminfo 

参考资料
-----------

1. 《Linux命令行与shell脚本编程大全》

2. 每天一个linux命令目录

  http://www.cnblogs.com/peida/archive/2012/12/05/2803591.html
