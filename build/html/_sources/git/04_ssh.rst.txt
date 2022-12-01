SSH 
===========

git 提供两类 URL 地址：

- HTTPS URL（例如 https://github.com/user/repo.git）
  
- SSH URL（例如 git@github.com:user/repo.git）

在命令行上使用 HTTPS URL 将 git clone、git fetch、git pull 或 git push 执行到远程存储库时，将要求提供用户名和密码。

SSH 是一种安全的网络协议（Secure Shell），git 使用这种协议进行远程加密登录。SSH 登录安全性由非对称加密保证，生成一个公钥和一个私钥。
SSH 采用加密技术验证远程主机，同时允许远程主机验证用户。
设置 SSH key 的目的是为了节省输入用户名、密码的过程，同时保证传输安全。


配置 SSH key
-------------------

git config
^^^^^^^^^^^^^^^^^

::

    git config --global user.name '<your name>'
    git config --global user.email '<your email>'

查看配置： ``git config --global --list`` 。

所有的配置保存在 ``~/.gitconfig`` 。


生成密钥
^^^^^^^^^^^^^^^^^

首先检查 ``~/.ssh`` 目录是否存在、目录中是否已经存在密钥文件。如果没有，说明还未生成过密钥。执行下列命令生成密钥::

    ssh-keygen -t rsa -C "<your email>"

如果不设置密码可以一路回车。 ``~/.ssh`` 目录下会生成 id_rsa（私钥）和 id_rsa.pub（公钥）。



使用 SSH agent
^^^^^^^^^^^^^^^^^^^^^^^^^^

SSH agent 是密钥管理器，保护 SSH 密钥并配置身份验证代理，这样就不必在每次使用 SSH 密钥时重新输入密码。
运行 ssh-agent 以后，使用 ``ssh-add`` 将私钥交给 ssh-agent 保管，其他程序需要身份验证的时候可以将验证申请交给 ssh-agent 来完成整个认证过程。
使用不同的密钥连接到不同的主机时，需要手动指定对应的密钥，而 ssh-agent 可以自动帮助我们选择对应的密钥进行认证。

Linux 系统下 ssh-agent 是自动启动的。

- 执行 ``ssh-add -l`` 查看是否有密钥被加载。

- 如果没有被加载，则执行 ``ssh-add ~/.ssh/<private_key_file>`` 加载私钥。

如果提示 “Error connecting to agent: No such file or directory” 说明你的 ssh-agent 并没有运行，执行 ``eval $(ssh-agent)`` 或 ``eval `ssh-agent``` 启动。 ``echo $SSH_AGENT_PID`` 查看 ssh-agent 进程 ID。
如果想杀掉 ssh-agent 进程，执行 ``ssh-agent -k`` 。


Github 添加公钥
^^^^^^^^^^^^^^^^^^^^^^^^^^

把 ``~/.ssh`` 目录下公钥的内容添加到 Github 。


测试 SSH 连接
^^^^^^^^^^^^^^^^^^^^^^^

::

    % ssh -T git@github.com
    Hi <your name>! You've successfully authenticated, but GitHub does not provide shell access.

如果看到上面的内容，说明连接成功。有时，防火墙会完全拒绝 SSH 连接（端口 22），可以尝试使用通过 HTTPS 端口建立的 SSH 连接克隆。
要测试通过 HTTPS 端口的 SSH 是否可行，请运行以下 SSH 命令::

    % ssh -T -p 443 git@ssh.github.com
    Hi <your name>! You've successfully authenticated, but GitHub does not provide shell access.

第一次连接会把 ``[ssh.github.com]:443`` 添加到 ``~/.ssh/known_hosts`` 。

如果你能在端口 443 上通过 SSH 连接到 git@ssh.github.com，则可覆盖你的 SSH 设置来强制与 GitHub.com 的任何连接均通过该服务器和端口运行。
要在 SSH 配置文件中设置此行为，请在 ~/.ssh/config 编辑该文件，并添加以下部分::

    Host ssh.github.com
        Hostname ssh.github.com
        Port 443
        User git

再次执行 ``ssh -T git@github.com`` 进行验证。

.. note::

    如果 push 的时候仍然要求输入用户名和密码，说明之前是用 HTTPS URL 指向远程主机，执行以下命令修改成 SSH URL::

        git remote set-url origin git@github.com:<Username>/<Project>.git

    查看 URL::

        git remote get-url origin

参考资料
---------------

1. 关于远程仓库
   
  https://docs.github.com/cn/get-started/getting-started-with-git/about-remote-repositories

2. 在 HTTPS 端口使用 SSH

  https://docs.github.com/cn/authentication/troubleshooting-ssh/using-ssh-over-the-https-port

3. Git ssh key 作用与配置

  https://blog.csdn.net/qq_39366020/article/details/106431194

4. ssh agent详解
   
  https://zhuanlan.zhihu.com/p/126117538

5. ssh-agent

  https://wangchujiang.com/linux-command/c/ssh-agent.html

6. Push to GitHub without a password using ssh-key

  https://stackoverflow.com/questions/14762034/push-to-github-without-a-password-using-ssh-key