二叉树遍历
=============

定义
------------

.. code-block:: cpp
  :linenos:

  // Definition for a binary tree node.
  struct TreeNode
  {
     int val;
     TreeNode *left;
     TreeNode *right;
     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
  };

先序遍历
--------------

- 递归

.. code-block:: cpp
  :linenos:

  void preOrder_Recur(TreeNode* T)
  {
    if(!T) return;
    else
    {
      visite(T -> val);
      preOrder_Recur(T -> left);
      preOrder_Recur(T -> right);
    }
  }

- 非递归

.. code-block:: cpp
  :linenos:

  void preOrder_NonRecur(TreeNode* T)
  {
    stack<TreeNode*> stk;
    while(T || !stk.empty())
    {
      while(T)
      {
        visite(T -> val);
        stk.push(T);
        T = T -> left;
      }
      if(! stk.empty)
      {
        T = stk.top();
        stk.pop();
        T = T -> right;
      }
    }
  }

中序遍历
--------------

- 递归

  .. code-block:: cpp
    :linenos:

    void inOrder_Recur(TreeNode* T)
    {
      if(!T) return;
      else
      {
        inOrder_Recur(T -> left);
        visite(T -> val);
        inOrder_Recur(T -> right);
      }
    }

- 非递归

.. code-block:: cpp
  :linenos:

  void inOrder_NonRecur(TreeNode* T)
  {
    stack<TreeNode*> stk;
    while(T || !stk.empty())
    {
      while(T)
      {
        stk.push(T);
        T = T -> left;
      }
      if(! stk.empty)
      {
        T = stk.top();
        stk.pop();
        visite(T -> val);
        T = T -> right;
      }
    }
  }


后序遍历
-------------

- 递归

.. code-block:: cpp
  :linenos:

  void postOrder_Recur(TreeNode* T)
  {
    if(!T) return;
    else
    {
      postOrder_Recur(T -> left);
      postOrder_Recur(T -> right);
      visite(T -> val);
    }
  }

- 非递归

  - 方法一：后序遍历顺序是：left - right - root；先序遍历顺序是：root - left - right。采用先序遍历的方式，用栈来存储节点（FILO），得到的是按 root - right - left 顺序遍历的临时结果；把临时结果逆序输出，就是后序遍历的结果。

  .. code-block:: cpp
    :linenos:

    vector<int> postOrder_NonRecur(TreeNode* T)
    {
      vector<int> res;
      stack<TreeNode*> nodePtr;
      if(T) nodePtr.push(T);
      while(! nodePtr.empty())
      {
        T = nodePtr.top();
        nodePtr.pop();

        res.push_back(T -> val);
        if(T -> left) nodePtr.push(T -> left);
        if(T -> right) nodePtr.push(T -> right);
      }
      reverse(res.begin(), res.end());
      return res;
    }

  - 方法二：一个节点如果不存在右子树，则遍历完左子树之后可以直接访问该节点的值；如果存在右子树，用一个额外的栈（inNode）来临时保存该节点。访问完该节点的右子树之后，就从栈弹出该节点进行访问。

  .. code-block:: cpp
    :linenos:

    vector<int> postOrder_NonRecur(TreeNode* T)
    {
      vector<int> res;
      stack<TreeNode*> nodePtr;
      stack<TreeNode*> inNode;
      while(T || ! nodePtr.empty())
      {
          while(T)
          {
              nodePtr.push(T);
              T = T -> left;
          }
          T = nodePtr.top();
          nodePtr.pop();

          if(T -> right)
          {
              inNode.push(T);
              T = T -> right;
          }
          else
          {
              res.push_back(T -> val);
              while(!inNode.empty() && T == inNode.top() -> right)
              // 访问完节点的右子树之后，就从栈弹出该节点进行访问
              {
                  res.push_back(inNode.top() -> val);
                  T = inNode.top();
                  inNode.pop();
              }
              T = NULL;
          }
      }
      return res;
    }


层次遍历
----------------

.. code-block:: cpp
  :linenos:

  void layerTraversal(TreeNode* T)
  {
    queue<TreeNode*> Q;
    if(T) Q.push(T);
    while(!Q.empty())
    {
      T = Q.front();
      Q.pop();
      visite(T -> val);
      if(T -> left) Q.push(T -> left);
      if(T -> right) Q.push(T -> right);
    }
  }


参考资料
--------------

1. 二叉树后序遍历非递归的三种写法 (数据结构)

  https://www.cnblogs.com/demian/p/8117888.html
