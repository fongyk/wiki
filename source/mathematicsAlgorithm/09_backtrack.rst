回溯
===========

总体思路是深度优先遍历（DFS）。

子集树
-----------

子集树大小为 :math:`\mathcal{O}(m^n)` ，:math:`m` 是树的分支个数（ :math:`m` 叉树），:math:`n` 是树的深度。

算法描述：

.. code-block:: cpp
    :linenos:

    void Backtrack(int t)
    {
      if(t >= n) Output(x);
      else
      {
        for(int i = 0; i < m; ++i)
        {
          x[t] = i;
          if(Constrain(t) and Bound(t)) Backtrack(t+1);
        }
      }
    }


排列树
------------

排列树大小为 :math:`\mathcal{O}(n!)` 。

算法描述：

.. code-block:: cpp
    :linenos:

    void Backtrack(int t)
    {
      if(t >= n) Output(x);
      else
      {
        for(int k = t; k < n; ++k)
        {
          Swap(x[t], x[k]);
          if(Constrain(t) and Bound(t)) Backtrack(t+1);
          Swap(x[t], x[k]);
        }
      }
    }


0-1背包问题
--------------

算法描述：

.. code-block:: cpp
    :linenos:

    void Backtrack(int t)
    {
      if(t >= n)
      {
        best_value = curr_value;
        bext_x = x;
        return;
      }
      else
      {
        if(curr_weight + w[t] <= W)
        {
          x[t] = 1;
          curr_weight += w[t]; // 进入左子树
          curr_value += v[t];
          Backtrack(t+1);

          curr_weight -= w[t]; // 状态恢复
          curr_value -= v[t];
        }
        x[t] = 0;
        Backtrack(t+1); // 进入右子树
      }
    }

实例
------------

- 全排列（含重复元素）。Hint：在交换第 :math:`i` 个元素与第 :math:`j` 个元素之前，要求数组的 :math:`[i, j)` 区间中的元素没有与第 :math:`j` 个元素重复。

    https://blog.csdn.net/so_geili/article/details/71078945

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      int cnt = 0; // 不同排列的个数

      //检查[from,to)之间的元素和第to号元素是否相同
      bool isRepeat(int* A, int from, int to)
      {
          for(int i = from; i < to; i++)
          {
              if(A[to] == A[i]) return true;
          }
          return false;
      }

      void permutation(int* A, int t, int n)
      {
          if(t == n)
          {
              cnt++;
              Output(A);
          }
          else
          {
              for(int j = t; j < n; j++)
              {
                  if(!isRepeat(A, t, j))
                  {
                      swap(A[t], A[j]);
                      permutation(A, t+1, n);
                      swap(A[t], A[j]);
                  }
              }
          }
      }


- Next Permutation 下一个排列。Hint：从后往前先找到第一个开始下降的数字 :math:`x` （下标 :math:`i` ），再从后往前找到第一个比 :math:`x` 大的数 :math:`y` （下标 :math:`j` ）；交换 :math:`x` 和 :math:`y` ；翻转区间 :math:`[i+1, end]` 。

    https://www.cnblogs.com/grandyang/p/4428207.html

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution
      {
      public:
          void nextPermutation(vector<int> &num)
          {
              int i, j, n = num.size();
              for (i = n - 2; i >= 0; --i)
              {
                  if (num[i + 1] > num[i])
                  {
                      for (j = n - 1; j > i; --j)
                      {
                          if (num[j] > num[i]) break;
                      }
                      swap(num[i], num[j]);
                      reverse(num.begin() + i + 1, num.end());
                      return;
                  }
              }
              reverse(num.begin(), num.end()); // 当前排列是最大的排列，则翻转为最小的排列
          }
      };

- Word search 查找字符串路径。

    https://leetcode.com/problems/word-search/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution {
      public:
          bool find_path(vector<vector<char>>& board, string word, bool** flag, int x, int y, int k)
          {
              if(k == word.size()) return true;
              for(int t = 0; t < 4; ++t)
              {
                  int tx = x + mv[t][0];
                  int ty = y + mv[t][1];

                  if(flag[tx+1][ty+1] && board[tx][ty] == word[k])
                  {
                      flag[tx+1][ty+1] = false; // 设置 flag
                      if(find_path(board, word, flag, tx, ty, k+1)) return true;
                      flag[tx+1][ty+1] = true; // flag 还原
                  }

              }
              return false;
          }
          bool exist(vector<vector<char>>& board, string word) {
              if(word=="") return true;
              if(board.size()==0) return false;
              int M = board.size();
              int N = board[0].size();
              bool** flag = new bool*[M+2];
              for(int m = 0; m < M+2; ++m)
              {
                  flag[m] = new bool[N+2];
                  for(int n = 0; n < N+2; ++n)
                  {
                      if(m==0 || m==M+1 || n==0 || n==N+1) flag[m][n] = false;
                      else flag[m][n] = true;
                  }
              }
              bool EXIST = false;
              for(int i = 0; i < M; ++i)
              {
                  for(int j = 0; j < N; ++j)
                  {
                      if(board[i][j] == word[0])
                      {
                          flag[i+1][j+1] = false; // 注意： flag 的下标与 board 相差 1
                          if(find_path(board, word, flag, i, j, 1))
                          {
                              EXIST = true;
                              break; // 跳出第二重循环
                          }
                          flag[i+1][j+1] = true; // flag 还原
                      }
                  }
                  if(EXIST) break; // 跳出第一重循环
              }

              for(int m = 0; m < M+2; ++m) delete[] flag[m];
              delete[] flag;

              return EXIST;
          }
      private:
          static const int mv[4][2];
      };

      const int Solution::mv[4][2] = {{-1,0},{0,-1},{0,1},{1,0}};
