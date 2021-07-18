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

  git add -u ：git add \- \-update，仅监控已经被 add 的文件（即 **tracked file** ），会将文件的修改和删除提交到暂存区，不会提交新文件（untracked file）。

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

- ``git mv file_from file_to`` 重命名文件，相当于 ``mv file_from file_to; git rm file_from; git add file_to`` 。要从 Git 中移除某个文件，就必须要从已跟踪文件清单中移除（确切地说，是从暂存区域移除），然后再提交。 ``git rm`` 就是用于完成此项工作，并连带从工作目录中删除指定的文件，这样以后就不会出现在未跟踪文件清单中了。

忽略文件
^^^^^^^^^^^^^^^

一般我们总会有些文件无需纳入 Git 的管理，也不希望它们总出现在未跟踪文件列表。通常都是些自动生成的文件，比如日志文件，或者编译过程中创建的临时文件等。在这种情况下，我们可以创建一个名为 .gitignore 的文件，列出要忽略的文件模式。

文件 .gitignore 的格式规范如下：

- 所有空行或者以 ``＃`` 开头的行都会被 Git 忽略。

- 可以使用标准的 glob 模式匹配。

- 匹配模式可以以 ``/`` 开头防止递归（只在当前目录下匹配，不进入子目录）。

- 匹配模式可以以 ``/`` 结尾指定目录。

- 要忽略指定模式以外的文件或目录，可以在模式前加上惊叹号 ``!`` 表示取反。

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

6. ProGit

  https://www.progit.cn/

7. gitignore

  https://github.com/github/gitignore
