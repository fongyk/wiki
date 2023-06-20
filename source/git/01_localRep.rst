本地版本库
===========

**Git** 是先进的分布式版本控制系统。

.. image:: ./01_git-operations.png
    :width: 700px
    :alt: 图片来源：http://blog.podrezo.com/git-introduction-for-cvssvntfs-users/
    :align: center
    :target: http://blog.podrezo.com/git-introduction-for-cvssvntfs-users

|

- **workspace** ：工作区

- **stage** ：暂存区

- **local repository** ：本地版本库

- **remote repository** ：远程仓库


本地版本库
------------

创建与修改
^^^^^^^^^^^^^^^^

- ``git init`` 把当前目录变为 Git 可管理的仓库（目录下多了子目录 .git/ ，自动创建的第一个分支 master，以及指向 master 的一个指针叫 ``HEAD`` ）。

  .. code-block:: text
    :linenos:

    $ tree .git
    .git
    ├── HEAD
    ├── config
    ├── description
    ├── hooks
    │   ├── applypatch-msg.sample
    │   ├── commit-msg.sample
    │   ├── fsmonitor-watchman.sample
    │   ├── post-update.sample
    │   ├── pre-applypatch.sample
    │   ├── pre-commit.sample
    │   ├── pre-merge-commit.sample
    │   ├── pre-push.sample
    │   ├── pre-rebase.sample
    │   ├── pre-receive.sample
    │   ├── prepare-commit-msg.sample
    │   ├── push-to-checkout.sample
    │   └── update.sample
    ├── info
    │   └── exclude
    ├── objects
    │   ├── info
    │   └── pack
    └── refs
        ├── heads
        └── tags

- ``git add <file>`` 把文件加入暂存区。

  - ``git add [dir]`` ：把工作区指定目录的 **所有变化** 提交到暂存区，包括文件内容 **修改（modified）** 以及 **新文件（new）** ，但不包括被删除的文件。

  - ``git add -u`` ： ``git add --update`` ，将已监控文件（即 **tracked file** ）的修改和删除提交到暂存区，不会提交新文件（untracked file）。

  - ``git add -A`` ： ``git add --all``，是上面两个功能的合集。

- ``git commit -m "add file"``  提交到本地版本库，并写 log。

- ``git commit --amend`` 修改 commit 注释。

- ``git status`` 查看本地仓库的状态（文件是不是被 tracked？修改是不是已经 commit？... 等）。

- ``git diff`` 比较暂存区和工作区的差异（修改还没有 add）。
  
  - ``git diff <file>`` 只比较某个文件修改前后的差异。
  - ``git diff <commit>`` 比较某次 commit 和当前版本（HEAD）的差异。
  - ``git diff <commit1> <commit2>`` 比较两次 commit 的差异。

- ``git log`` 查看版本历史记录，包括版本的 hash 值、commit 注释等信息。

- ``git reflog`` 查看可引用的历史版本记录，一般是为了找到所需的 commit 索引，从而进行版本回退或恢复操作所使用。

  .. code-block:: text
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
    :target: https://www.liaoxuefeng.com/wiki/896043488029600/897271968352576

|

**HEAD 指针指向当前分支。**

- ``git checkout <commit>`` 切换到某次 commit 之后的状态。

  - ``git checkout -`` 返回 checkout 之前的状态。

  - 可以通过 ``git reflog`` 查看所有的 commit 记录，找到最新的 commit 并切换回去。

- ``git checkout -- <file>`` 取消对已经 commit 内容的修改。

- ``git reset <file>`` 取消对暂存区的修改（to unstage），还原到工作区。

- ``git reset [<mode>] [<commit>]``

  - ``--soft`` 从本地仓库撤销到暂存区（撤销了 git commit，不撤销 git add）。
  - ``--mixed`` 默认 mode，撤销 git commit 和 git add，工作区内容保持。
  - ``--hard`` 本地仓库回到之前版本，暂存区和工作区的修改都被丢弃。
  - reset 一般用于本地最新 commit 或工作区/暂存区的还原，如果 reset 了已经 push 到远程仓库的 commit，那么直接 push 会产生错误。

- ``git revert <commit>``

  - 用于回滚之前的某次/某些（有 bug 的）commit，不会删除之前的 commit 记录，会增加新的 revert 记录。
  - 回滚中间某次 commit 可能会产生冲突，因为后面的某次 commit 可能修改了相同的文件（修改了同一行，或者删除了文件）。此时需要先解决冲突（通过 ``git status`` 查看提示），参考 github 文档 -- `使用命令行解决合并冲突 <https://docs.github.com/zh/pull-requests/collaborating-with-pull-requests/addressing-merge-conflicts/resolving-a-merge-conflict-using-the-command-line?platform=linux>`_ ，然后执行 ``git add -A`` ， ``git revert --continue`` 。
  - 放弃当前 revert 操作： ``git revert --abort`` 。
  - 如果需要回滚多个连续的 commit ，使用 ``git revert -n commit_begin..commit_end`` ，左开右闭，如果需要包括左边的 commit，使用 ``commit_begin^`` 。
  - ``-n`` 表示 no commit，不自动提交，后续需要手动提交。因为回滚多个 commit 的时候，默认会自动产生多个提交记录，因此最好手动做一次提交。

.. tip::

    - ``HEAD`` ``HEAD~0`` 表示最新 commit 版本。
    - ``HEAD^`` ``HEAD~1`` 表示上一个 commit 之后的版本。
    - ``HEAD^^`` ``HEAD~2`` 表示上上个 commit 之后的版本。
    - ...

.. tip::

    要引用某次 commit 的版本，可以用 ``HEAD`` ``HEAD^`` 等形式表示，也可以用版本号的 hash 值如 7ed6。版本号的 hash 值不需要是完整的，只需要前缀的几位，能够和其他 hash 值区分开就行。

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

8. 图解Git

  https://marklodato.github.io/visual-git-guide/index-zh-cn.html

9. 这才是真正的Git——Git内部原理揭秘！

  https://zhuanlan.zhihu.com/p/96631135

10. git-revert

  https://git-scm.com/docs/git-revert