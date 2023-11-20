分支管理
=============

.. highlight:: bash

分支管理
------------

.. warning::

    Github 已经将 master 分支改名为 main。

- ``git checkout -b dev`` 创建分支 dev，并切换到 dev 分支（此时可以正常 add、commit 等）。相当于下面两条指令：

  - ``git branch dev`` 创建分支
  - ``git checkout dev`` 切换分支

.. note::

  从 master 分支创建 dev分支，则 dev 分支的仓库已经包含了 master 分支的内容，但是在 master 分支下，无法看到 dev 分支新增或修改的内容。

- ``git branch`` -r：查看远程分支，-a：查看所有分支（包括本地分支）。

- ``git merge dev`` 把 dev 分支的内容合并到当前分支（如 master 分支）。

- ``git branch -d dev`` （合并之后）删除 dev 分支。

流程如下（图片来源于 `Git教程 - 廖雪峰的官方网站 <https://www.liaoxuefeng.com/wiki/896043488029600/900003767775424>`_ ）：

**1.** 初始状态： **master** 分支。

.. image:: ./03_master.png
    :width: 300px
    :align: center

**2.** 创建并切换到 **dev** 分支。

.. image:: ./03_create_branch.png
    :width: 300px
    :align: center

**3.** 更新 **dev** 分支。

.. image:: ./03_commit_branch.png
    :width: 300px
    :align: center

**4.** 合并 **dev** 分支到 **master** 分支。

.. image:: ./03_merge_branch.png
    :width: 300px
    :align: center

**5.** 删除 **dev** 分支。

.. image:: ./03_delete_branch.png
    :width: 300px
    :align: center

.. note::

    协同开发场景下，在开发自己的分支时，要注意合并 master 分支的最新更新： ``git pull origin master`` ，手动解决冲突。


.. tip::

    在所有分支中查找目标字符串::

      git branch -a | cut -c3- | cut -d' ' -f 1 | xargs git grep "target_string"

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

5. Using Git, how could I search for a string across all branches

  https://stackoverflow.com/questions/7151311/using-git-how-could-i-search-for-a-string-across-all-branches