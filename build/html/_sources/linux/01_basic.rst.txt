基本命令
============

文件和目录
--------------------

.. code-block:: bash

  cd ..
  pwd
  ls -a -F -R -l

  cp [-i] src dst
  cp -R

  mv src des
  rm -i -r -f folder

  touch new ## 创建新文件或修改文件时间属性

  mkdir new
  rmdir new

  file my_file ## 查看文件类型

  cat -n log.txt
  tail log.txt
  head -5 log.txt

  wc file -c -w -l


磁盘空间
------------

.. code-block:: bash

  df -h
  du [-s] -h

处理数据文件
----------------

.. code-block:: bash

  sort [-n] log.txt ## -n : 行号

  grep [-n] [-c] t file ## find *t* in file

  gzip my*
  gunzip myfile.gz

  tar -cvf test.tar test/
  tar -xvf test.tar
  tar -xzvf test.tgz

参考资料
-----------

1. 《Linux命令行与shell脚本编程大全》

2. 每天一个linux命令目录

  http://www.cnblogs.com/peida/archive/2012/12/05/2803591.html
