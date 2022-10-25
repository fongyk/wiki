pip
=========

``pip`` 是 python 的包管理工具。

基本指令
------------

.. code-block:: text
  :linenos:

  install                     Install packages.
  download                    Download packages.
  uninstall                   Uninstall packages.
  freeze                      Output installed packages in requirements format.
  list                        List installed packages.
  show                        Show information about installed packages.
  check                       Verify installed packages have compatible dependencies.
  search                      Search PyPI for packages.
  wheel                       Build wheels from your requirements.
  hash                        Compute hashes of package archives.
  completion                  A helper command used for command completion.
  help                        Show help for commands.


- 安装

  ::

    pip install <包名>
    pip install -r requirements.txt

  requirements.txt 使用 ``== >= <= > <`` 来指定版本，不写则默认为最新版本，格式如：

  .. code-block:: text
    :linenos:

    APScheduler==2.1.2
    Django==1.5.4
    MySQL-Connector-Python==2.0.1
    MySQL-python==1.2.3
    PIL==1.1.7
    South==1.0.2

- 卸载

  ::

    pip uninstall <包名>
    pip uninstall -r requirements.txt

- 升级包

  ::

    pip install -U <包名>
    pip install <包名> --upgrade

- 升级 pip

  ::

    pip install -U pip
    python -m pip install --upgrade pip

- freeze：查看已经安装的包及版本信息

- list：列出已安装的包

  ::

    pip list -o ## 查询可升级的包

- search：在 PyPI 查询包

  ::

    pip search <包名>

- show：显示已安装的包的信息

  ::

    pip show <包名>


.. note::

  如果不能直接使用 pip 命令，可能是因为安装目录不在系统的 PATH 中，此时可以执行::

    python -m pip <pip arguments>
    
  使用清华源/科大源加速安装::

    pip install <包名> -i https://pypi.tuna.tsinghua.edu.cn/simple
    pip install <包名> -i https://mirrors.ustc.edu.cn/pypi/web/simple

  设为默认源::

    # 使用本镜像站来升级 pip
    pip install -i https://mirrors.ustc.edu.cn/pypi/web/simple pip -U
    pip config set global.index-url https://mirrors.ustc.edu.cn/pypi/web/simple



参考资料
--------------

1. Python pip 常用命令

  https://www.cnblogs.com/BlueSkyyj/p/8268621.html

2. User Guide

  https://pip.pypa.io/en/stable/user_guide/
