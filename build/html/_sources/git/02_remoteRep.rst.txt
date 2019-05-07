远程仓库
=========

.. image:: ./01_git-operations.png
    :width: 700px
    :alt: 图片来源：http://blog.podrezo.com/git-introduction-for-cvssvntfs-users/
    :align: center

（图片来源：http://blog.podrezo.com/git-introduction-for-cvssvntfs-users/）

- **workspace** ：工作区

- **stage** ：暂存区

- **local repository** ：本地版本库

- **remote repository** ：远程仓库


远程仓库
-------------

- ``git clone <版本库的网址>`` 从远程主机克隆一个版本库。

- ``git remote`` 管理主机名，使用参数 -v，可以参看远程主机的网址。

  .. code-block:: bash
    :linenos:

    $ git remote -v
    origin  git@github.com:******/******.git (fetch)
    origin  git@github.com:******/******.git (push)
    ## 结果表明：当前只有一台远程主机，叫做 origin 。

- ``git fetch <远程主机名>`` 将某个远程主机的更新，全部取回本地。默认情况下，git fetch取回所有分支（branch）的更新。

- ``git fetch <远程主机名> <分支名>`` 如果只想取回特定分支的更新，可以指定分支名，比如master。

- ``git branch`` -r：查看远程分支，-a：查看所有分支（包括本地分支）。

- ``git merge origin/master`` 在本地分支上合并远程分支（origin/master）。

- ``git pull <远程主机名> <远程分支名>:<本地分支名>`` 取回远程主机某个分支的更新，再与本地的指定分支合并。比如，取回origin主机的next分支，与本地的master分支合并，需要写成 ``git pull origin next:master`` 。如果远程分支是与当前分支合并，可直接写为 ``git pull origin next`` 。等效于fetch+merge： ``git fetch origin`` ， ``git merge origin/next`` 。

.. note::

  Git Pull Failed: Your local changes would be overwritten by merge. Commit, stash or revert them.

  - 保留未push的本地代码，并把git服务器上的代码pull到本地（本地刚才修改的代码将会被暂时封存起来）。

    - git stash
    - git pull origin master（其中origin master表示git的主分支）
    - git stash pop

  - 完全地覆盖本地的代码，只保留服务器端代码，则直接回退到上一个版本，再进行pull。

    - git reset --hard
    - git pull origin master


- ``git push <远程主机名> <本地分支名>:<远程分支名>`` 将本地分支的更新，推送到远程主机。


参考资料
-----------

1. Git和Github简单教程

  https://www.cnblogs.com/schaepher/p/5561193.html#reset

2. Git教程

  https://www.liaoxuefeng.com/wiki/896043488029600

3. Git使用教程

  http://www.cnblogs.com/tugenhua0707/p/4050072.html

4. Git操作详解

  https://www.cnblogs.com/bestzhang/p/6903338.html

5. Git Pull Failed

  https://blog.csdn.net/gymaisyl/article/details/84899191
