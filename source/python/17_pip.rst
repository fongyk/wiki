pip
=========

pip 是 Python 的包管理工具。

.. highlight:: bash
  :linenothreshold: 2

安装 pip
------------

Linux 和 Mac OS 可以使用以下两种方法安装：

- ensurepip
  
  ::

    python -m ensurepip --upgrade

- get-pip.py

  ::

    curl -sS https://bootstrap.pypa.io/get-pip.py | python 

Windows 下建议直接下载 Python 安装程序，安装过程中一并安装 pip 并设置环境变量。不推荐下载免安装版本。

基本指令
------------

.. note::

  如果不能直接使用 pip 命令，可能是因为安装目录不在系统的 ``PATH`` 中，此时应该执行::

    python -m pip <pip arguments>

  ``python -m`` 指定 Python 解释器（系统可能安装了多个 Python 版本）。

pip 22.2.2 支持如下命令：

.. code-block:: text
  :linenos:

  install                     Install packages.
  download                    Download packages.
  uninstall                   Uninstall packages.
  freeze                      Output installed packages in requirements format.
  inspect                     Inspect the python environment.
  list                        List installed packages.
  show                        Show information about installed packages.
  check                       Verify installed packages have compatible dependencies.
  config                      Manage local and global configuration.
  search                      Search PyPI for packages.
  cache                       Inspect and manage pip's wheel cache.
  index                       Inspect information available from package indexes.
  wheel                       Build wheels from your requirements.
  hash                        Compute hashes of package archives.
  completion                  A helper command used for command completion.
  debug                       Show information useful for debugging.
  help                        Show help for commands.


- 安装

  常用参数：

  -r, --requirement <file>    安装给定的文件安装包

    :: 
      
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

  -t, --target <dir>    指定安装路径；需要把 <dir> 目录添加到环境变量 ``PYTHONPATH`` 。

  --prefix <dir>    指定安装路径的前缀，生成 bin、lib 等目录；需要把 <dir>/lib/python/site-packages 目录添加到环境变量 ``PYTHONPATH`` 。

  --user  将包安装到个人目录（默认安装路径是 ``USER_SITE`` ），不需要管理员权限。执行 ``python -m site`` 查看包的安装路径（site-packages）。 

  --force-reinstall    强制重新安装包，即使该包已经是最新版本。

  -i, --index-url <url>    指定 Python 包的索引，默认是 https://pypi.org/simple，推荐使用国内镜像。

  -U, --upgrade    升级包到最新版本。



- 卸载

  ::

    pip uninstall <包名>
    pip uninstall -r requirements.txt

- 升级 pip

  ::

    pip install -U pip
    python -m pip install --upgrade pip

- freeze：查看已经安装的包及版本信息

  ::

    $ pip freeze
    alabaster==0.7.12
    Babel==2.10.3
    beautifulsoup4==4.11.1
    certifi==2022.9.24
    charset-normalizer==2.1.1
    ...

- list：列出已安装的包

  ::

    ## 查询可升级的包
    pip list -o 

- search：在 PyPI 查询包

  ::

    pip search <包名>

- show：显示已安装的包的信息

  ::

    pip show <包名>

- config：查看或编辑配置，配置文件在 /etc/pip.conf 或 ~/.config/pip/pip.conf 。参考 `<https://pip.pypa.io/en/stable/topics/configuration/>`_ 。

  :: 

    python -m pip config [<file-option>] list
    python -m pip config [<file-option>] [--editor <editor-path>] edit
    python -m pip config [<file-option>] get command.option
    python -m pip config [<file-option>] set command.option value
    python -m pip config [<file-option>] unset command.option
    python -m pip config [<file-option>] debug


.. tip::
    
  使用清华源/科大源加速安装::

    pip install <包名> -i https://pypi.tuna.tsinghua.edu.cn/simple
    pip install <包名> -i https://mirrors.ustc.edu.cn/pypi/web/simple

  设为默认源::

    # 使用本镜像站来升级 pip
    pip install -i https://mirrors.ustc.edu.cn/pypi/web/simple pip -U
    pip config set global.index-url https://mirrors.ustc.edu.cn/pypi/web/simple


参考资料
--------------

1. User Guide

  https://pip.pypa.io/en/stable/user_guide/

2. Python pip 常用命令

  https://www.cnblogs.com/BlueSkyyj/p/8268621.html
