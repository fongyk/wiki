代理
===========

HTTPS 连接
-----------------

使用 http 协议的代理::

    git config --global http.proxy "http://127.0.0.1:7890"
    git config --global https.proxy "http://127.0.0.1:7890"

使用 SOCKS 协议的代理::

    git config --global http.proxy 'socks5://127.0.0.1:7890' 
    git config --global https.proxy 'socks5://127.0.0.1:7890'

查看配置： ``git config -l --global`` 。配置保存在 ``~/.gitconfig`` 。

取消代理::

    git config --global --unset http.proxy
    git config --global --unset https.proxy


SSH 连接
------------------

新建/编辑 ``~/.ssh/config`` 文件

- 使用 http 协议的代理::

    Host github.com
        HostName github.com
        User git
        ProxyCommand nc -X connect -x 127.0.0.1:7890 %h %p

- 使用 SOCKS 协议的代理::

    Host github.com
        HostName github.com
        User git
        ProxyCommand nc -X 5 -x 127.0.0.1:7890 %h %p


参考资料
---------------

1. 如何为 Git 设置代理
  
  https://www.cnblogs.com/cscshi/p/15705045.html

2. 设置 socks5/http 代理，可用于git和shell终端

  https://blog.kelu.org/tech/2017/06/19/setting-socks5-proxy.html

3. .ssh/config 文件配置

  https://www.jianshu.com/p/a4ad95935f3f

4. git设置使用代理

  https://blog.csdn.net/libusi001/article/details/122229807