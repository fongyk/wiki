本地版本库
===========

**Git** 是目前世界上最先进的分布式版本控制系统。

.. image:: ./01_git-operations.png
    :width: 700px
    :alt: 图片来源：http://blog.podrezo.com/git-introduction-for-cvssvntfs-users/
    :align: center

（图片来源：http://blog.podrezo.com/git-introduction-for-cvssvntfs-users/）

- **workspace** ：工作区

- **stage** ：暂存区

- **local repository** ：本地版本库

- **remote repository** ：远程仓库


本地版本库
------------

创建与修改
^^^^^^^^^^^^^^^^

- ``git init`` 把当前目录变为Git可管理的仓库（目录下多了子目录.git/，自动创建的第一个分支master，以及指向master的一个指针叫 ``HEAD`` ）。

- ``git add my_file`` 把文件加入暂存区。

.. note::

  git add . ：把工作时的 **所有变化** 提交到暂存区，包括文件内容 **修改（modified）** 以及 **新文件（new）** ，但不包括被删除的文件。

  git add -u ：git add \- \-update，仅监控已经被add的文件（即 **tracked file** ），他会将被修改的文件提交到暂存区。不会提交新文件（untracked file）。

  git add -A ：git add \- \-all，是上面两个功能的合集。

- ``git commit -m "add my_file"``  提交到本地版本库，并写log。

- ``git status`` 查看当前仓库的状态（文件是不是被tracked？修改是不是已经commit？... 等）。

- ``git diff`` 查看当前状态和最新的commit之间的不同（修改还没有add），命令可以加具体文件名以查看某个文件的修改。

- ``git diff <版本号，如7ed6b16>`` 查看当前状态和之前某次commit之间的不同。

- ``git log`` 查看commit记录。

- ``git reflog`` 查看之前每次commit之后的分支状态。

  .. code-block:: bash
    :linenos:

    $ git reflog
    41c873a (HEAD -> master) HEAD@{0}: commit: update b
    3e2b7f2 HEAD@{1}: reset: moving to HEAD
    3e2b7f2 HEAD@{2}: commit: update out
    7ed6b16 HEAD@{3}: reset: moving to HEAD
    7ed6b16 HEAD@{4}: commit: add a
    8337301 HEAD@{5}: commit (initial): add readme


版本管理
^^^^^^^^^^^

.. image:: ./01_head.jpg
    :width: 500px
    :alt: 图片来源：https://www.liaoxuefeng.com/wiki/896043488029600/897271968352576
    :align: center

（图片来源：https://www.liaoxuefeng.com/wiki/896043488029600/897271968352576）

**HEAD 指针指向当前版本的master分支。**

- ``git checkout -- my_file`` 如果修改或删除了已经commit的内容，这条指令可以丢弃该操作，一键还原。

- ``git reset --hard`` 撤销修改，回到上一次commit之后的状态。

- ``git reset --hard <版本号，如7ed6b16>`` 回到某一次commit之后的状态，同时会删除该次commit之后的commit log。



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

5. git add -A 和 git add . 的区别

  https://www.cnblogs.com/skura23/p/5859243.html
