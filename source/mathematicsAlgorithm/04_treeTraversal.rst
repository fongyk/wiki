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

先序遍历是深度优先遍历（DFS）。

- 递归

.. code-block:: cpp
  :linenos:

  void preOrderRecur(TreeNode* T)
  {
    if(!T) return;
    else
    {
      visit(T -> val);
      preOrderRecur(T -> left);
      preOrderRecur(T -> right);
    }
  }

- 非递归

.. code-block:: cpp
  :linenos:

  void preOrderNonRecur(TreeNode* T)
  {
    stack<TreeNode*> stk;
    while(T || !stk.empty())
    {
      while(T)
      {
        visit(T -> val);
        stk.push(T);
        T = T -> left;
      }
      if(!stk.empty())
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

    void inOrderRecur(TreeNode* T)
    {
      if(!T) return;
      else
      {
        inOrderRecur(T -> left);
        visit(T -> val);
        inOrderRecur(T -> right);
      }
    }

- 非递归

.. code-block:: cpp
  :linenos:

  void inOrderNonRecur(TreeNode* T)
  {
    stack<TreeNode*> stk;
    while(T || !stk.empty())
    {
      while(T)
      {
        stk.push(T);
        T = T -> left;
      }
      if(!stk.empty())
      {
        T = stk.top();
        stk.pop();
        visit(T -> val);
        T = T -> right;
      }
    }
  }


后序遍历
-------------

- 递归

.. code-block:: cpp
  :linenos:

  void postOrderRecur(TreeNode* T)
  {
    if(!T) return;
    else
    {
      postOrderRecur(T -> left);
      postOrderRecur(T -> right);
      visit(T -> val);
    }
  }

- 非递归

  - 方法一：后序遍历顺序是：left - right - root；先序遍历顺序是：root - left - right。采用先序遍历的方式，用栈来存储节点（FILO），得到的是按 root - right - left 顺序遍历的临时结果；把临时结果逆序输出，就是后序遍历的结果。

  .. code-block:: cpp
    :linenos:

    vector<int> postOrderNonRecur(TreeNode* T)
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

    vector<int> postOrderNonRecur(TreeNode* T)
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

层次遍历是广度优先遍历（BFS）。

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
      visit(T -> val);
      if(T -> left) Q.push(T -> left);
      if(T -> right) Q.push(T -> right);
    }
  }


实例
------------

- [LeetCode] Binary Tree Maximum Path Sum 最大路径和，路径连续但可以不经过根节点。Hint：路径有三种形式：在左子树中，在右子树中，跨越根节点。

  https://leetcode.com/problems/binary-tree-maximum-path-sum/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int maxPathSum(TreeNode* root)
          {
              int res = INT_MIN;
              maxPathSumEndWithRoot(root, res);
              return res;
          }
      private:
          int maxPathSumEndWithRoot(TreeNode* root, int& res) // 以 root 结尾的路径的最大和
          {
              if(root)
              {
                  int sumEndWithLeft = maxPathSumEndWithRoot(root->left, res); // 以 root->left 结尾的路径的最大和
                  int sumEndWithright = maxPathSumEndWithRoot(root->right, res); // 以 root->right 结尾的路径的最大和
                  int sumEndWithRoot = root->val + max(0, max(sumEndWithLeft, sumEndWithright)); // 以 root 结尾的路径的最大和，必须包含根节点本身，最多包含左右节点中的一个

                  sumEndWithLeft = max(0, sumEndWithLeft);
                  sumEndWithright = max(0, sumEndWithright);
                  int sumCrossRoot = root->val + sumEndWithLeft + sumEndWithright;
                  // 以上三步等价于：int sumCrossRoot = root->val + max(0, max(sumEndWithLeft+sumEndWithright, max(sumEndWithLeft, sumEndWithright)));
                  // 通过根节点的路径有四种情况：只包含根节点、包含根节点+左节点、包含根节点+右节点、包含根节点+左节点+右节点

                  res = max(res, sumCrossRoot);
                  // sumCrossRoot 表示通过节点 root 的路径的最大和
                  // 这里没有比较 res 与左子树路径最大和、右子树路径最大和，是因为在计算 sumEndWithLeft、sumEndWithright 的过程中（第15、16行），已经更新了 res
                  // 函数 maxPathSumEndWithRoot 会遍历树的每一个节点，因此 res 会和所有路径的路径和进行比较。

                  return sumEndWithRoot;
              }
              else return 0;
          }
      };

- [LeetCode] Populating Next Right Pointers in Each Node II 建立层次右向指针。Hint：层次遍历的下一个节点就是当前节点的 next 指针所指。

  https://leetcode.com/problems/populating-next-right-pointers-in-each-node-ii/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          Node* connect(Node* root)
          {
              if(!root) return root;
              queue<Node*> que;
              que.push(root);
              que.push(nullptr);
              Node* head = nullptr;
              while(!que.empty())
              {
                  Node* p = que.front();
                  que.pop();
                  if(!head)
                  {
                      head = p;
                      if(!que.empty()) que.push(nullptr);
                  }
                  else
                  {
                      head -> next = p;
                      head = p;
                  }
                  if(p)
                  {
                      if(p->left) que.push(p->left);
                      if(p->right) que.push(p->right);
                  }
              }
              return root;
          }
      };

- [LeetCode] Invert Binary Tree 翻转二叉树。Hint：方法一，递归；方法二，深度优先遍历；方法三，广度优先遍历。

  https://leetcode.com/problems/invert-binary-tree/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 方法一：递归

      class Solution
      {
      public:
          TreeNode* invertTree(TreeNode* root)
          {
              if(root)
              {
                  swap(root -> left, root -> right);
                  invertTree(root -> left);
                  invertTree(root -> right);
              }
              return root;
          }
      };

    .. code-block:: cpp
      :linenos:

      // 方法二：深度优先遍历

      class Solution
      {
      public:
          TreeNode* invertTree(TreeNode* root)
          {
              TreeNode* node = root;
              stack<TreeNode*> stk;
              while(node || !stk.empty())
              {
                  while(node)
                  {
                      stk.push(node);
                      node = node -> left;
                  }
                  if(!stk.empty())
                  {
                      node = stk.top();
                      stk.pop();
                      swap(node -> left, node -> right);
                      node = node -> left; // 翻转之后的左子树是原来的右子树
                  }
              }
              return root;
          }
      };

    .. code-block:: cpp
      :linenos:

      // 方法三：广度优先遍历

      class Solution
      {
      public:
          TreeNode* invertTree(TreeNode* root)
          {
              queue<TreeNode*> qe;
              if(root) qe.push(root);
              while(!qe.empty())
              {
                  TreeNode* node = qe.front();
                  qe.pop();
                  swap(node -> left, node -> right);
                  if(node -> left) qe.push(node -> left);
                  if(node -> right) qe.push(node -> right);
              }
              return root;
          }
      };

- [LeetCode] Balanced Binary Tree 平衡二叉树。Hint：后序遍历，在判断子树是否平衡的同时，保存子树的高度，避免重复计算。

  https://leetcode.com/problems/balanced-binary-tree/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          bool isBalanced(TreeNode* root)
          {
              int height = 0;
              return isBalanced(root, height);
          }
      private:
          bool isBalanced(TreeNode* root, int& height)
          {
              if(!root)
              {
                  height = 0;
                  return true;
              }
              int leftHeight;
              int rightHeight;
              if(isBalanced(root->left, leftHeight) && isBalanced(root->right, rightHeight))
              {
                  if(abs(leftHeight - rightHeight) <= 1)
                  {
                      height = max(leftHeight, rightHeight) + 1;
                      return true;
                  }
              }
              return false;
          }
      };


- [LeetCode] House Robber III 不包含相邻元素的最大路径和。Hint：后序遍历；包含或不包含头节点。

  https://leetcode.com/problems/house-robber-iii/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int rob(TreeNode* root)
          {
              int inclu_root = 0; // 包含头节点的最大和
              int exclu_root = 0; // 不包含头节点的最大和
              return rob(root, inclu_root, exclu_root);
          }
      private:
          int rob(TreeNode* root, int& inclu_root, int& exclu_root)
          {
              if(!root) return 0;
              int inclu_left = 0, exclu_left = 0;
              rob(root -> left, inclu_left, exclu_left);
              int inclu_right = 0, exclu_right = 0;
              rob(root -> right, inclu_right, exclu_right);
              inclu_root = root -> val + exclu_left + exclu_right;
              exclu_root = max(inclu_left, exclu_left) + max(inclu_right, exclu_right);
              return max(inclu_root, exclu_root);
          }
      };


- [LeetCode] Path Sum III 路径和为目标值。Hint：先序遍历，把每个节点当做起始节点。

  https://leetcode.com/problems/path-sum-iii/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          int pathSum(TreeNode* root, int sum)
          {
              int cnt = 0;
              traverse(root, sum, cnt);
              return cnt;
          }
      private:
          void traverse(TreeNode* root, int target, int& cnt)
          {
              if(root)
              {
                  getSumFromRoot(root, target - root->val, cnt); // 以 root 为起点的路径和
                  traverse(root->left, target, cnt);
                  traverse(root->right, target, cnt);
              }
          }
          void getSumFromRoot(TreeNode* root, int target, int& cnt)
          {
              if(target == 0) cnt ++;
              // 当后续路径和为 0，也是一条满足要求的路径，因此当 target 减到 0 之后不能立即返回，也需要继续遍历。
              if(root->left) getSumFromRoot(root->left, target - root->left->val, cnt);
              if(root->right) getSumFromRoot(root->right, target - root->right->val, cnt);
          }
      };

- [LeetCode] Lowest Common Ancestor of A Binary Tree 二叉树的最近公共祖先。Hint：后序遍历，两个节点在同一子树中，或有一个是根节点。

  https://leetcode-cn.com/problems/lowest-common-ancestor-of-a-binary-tree

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution 
      {
      public:
          TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) 
          {
              if(!root || !p || !q) return root;
              TreeNode* res = nullptr;
              postOrderTraversal(root, p, q, res);
              return res;
          }
      private:
          // 返回值表示：p 或 q 在 root 的子树中（包括根节点root） 
          bool postOrderTraversal(TreeNode* root, TreeNode* p, TreeNode* q, TreeNode* &res)
          {
              if(!root) return false;
              if(res) return false; // 已经有结果了，后面不需要再遍历了
              bool lson = postOrderTraversal(root->left, p, q, res);
              bool rson = postOrderTraversal(root->right, p, q, res);
              if((lson && rson) || ((root == p || root == q) && (lson || rson))) res = root;
              return lson || rson || root == p || root == q;
          }
      };


参考资料
--------------

1. 二叉树后序遍历非递归的三种写法 (数据结构)

  https://www.cnblogs.com/demian/p/8117888.html
