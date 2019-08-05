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

八皇后问题
--------------

八皇后问题共有 92 组解。

.. code-block:: cpp
    :linenos:

    bool place(int t, int* x)
    {
      for(int j = 0; j < t; ++j)
      {
        if(x[j] == x[t] || abs(j - t) == abs(x[j] - x[t])) return false; // 在同一列或同一斜线上
      }
      return true;
    }

    void Backtrack(int t, int n, int* x, int& sum)
    {
      if(t == n) ++sum;
      else
      {
        for(int i = 0; i < n; ++i)
        {
          x[t] = i;
          if(place(t, x)) Backtrack(t+1, n, x, sum);
        }
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

- 按字典序输出序列 :math:`1,2,...,n` 的全排列。Hint：深度优先遍历。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      void DFS(int* arr, bool* used, int n, int t)
      {
          if(t == n)
          {
              for(int i = 0; i < n; ++i) cout << arr[i] << ends;
              cout << endl;
              return;
          }
          for(int digit = 1; digit <= n; ++digit)
          {
              if(!used[digit - 1])
              {
                  used[digit - 1] = true;
                  arr[t] = digit;
                  DFS(arr, used, n, t+1);
                  used[digit - 1] = false;
              }
          }
      }

- [LeetCode] Permutation Sequence 输出序列 :math:`1,2,...,n` 的第 :math:`k` 个排列（字典序）。Hint：方法一，按字典序深度优先遍历；方法二，逐步缩小搜索范围，如：
  :math:`perm [ 1,2,3 ] = \{1 + perm [ 2,3 ] \} + \{2 + perm [ 1,3 ] \} + \{3 + perm [ 1,2 ] \}` 。

    https://leetcode.com/problems/permutation-sequence/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // https://leetcode.com/problems/permutation-sequence/discuss/22507/%22Explain-like-I'm-five%22-Java-Solution-in-O(n)

      class Solution
      {
      public:
          string getPermutation(int n, int k)
          {
              string nums = "";
              vector<int> factorial(n+1, 1);
              for(int i = 1; i <= n; ++i)
              {
                  nums += to_string(i);
                  factorial[i] = i;
              }
              partial_sum(factorial.begin(), factorial.end(), factorial.begin(), multiplies<int>()); // f(n) = n!, f(0) = 1

              string res = "";
              while(n)
              {
                  int id = (k - 1) / factorial[n-1]; // k - 1，下标从 0 开始
                  res += nums[id];
                  nums.erase(nums.begin() + id); // 得到 n - 1 个数的序列
                  k -= id * factorial[n-1]; // 在 n - 1 个数的序列中继续查找第 k - id * factorial[n-1] 个排列
                  --n;
              }
              return res;
          }
      };

- 输出序列 :math:`1,2,...,n` 的所有子集（组合），共 :math:`2^n` 组。Hint：方法一，回溯，二叉子集树；方法二，递归，序列每增加一个数，组合数增加一倍，增加的这些组合是在之前的组合的基础上插入该数得到的；
  方法三，当 :math:`n < 32` ，可以使用一个 int 型的变量 :math:`k` （ :math:`1 \leqslant k \leqslant 2^n` ）来表示组合的状态，当该变量的二进制表示的第 :math:`i` 位为 1，则表示当前组合中包含数字 :math:`i` 。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 方法一，回溯

      void backtrack(int n, vector<int>& tmp, vector<vector<int>>& res)
      {
        if (n == 0)
        {
          res.push_back(tmp);
          return;
        }
        backtrack(n - 1, tmp, res); // 不包含 n
        tmp.push_back(n);
        backtrack(n - 1, tmp, res); // 包含 n
        tmp.pop_back();
      }

      vector<vector<int>> combination(int n)
      {
        assert(n > 0);
        vector<vector<int>> res;
        vector<int> tmp;
        backtrack(n, tmp, res);
        return res;
      }

    .. code-block:: cpp
      :linenos:

      // 方法二，递归

      void combinationRecursive(int n, vector<vector<int>>& res)
      {
        if (n == 1)
        {
          res[1].push_back(1);
          return;
        }

        combinationRecursive(n - 1, res);

        int pre_num = pow(2, n - 1); // 在 1 ~ n-1 的组合上插入数字 n
        for (int i = 0; i < pre_num; ++i)
        {
          res[i + pre_num].push_back(n);
          for (int j = 0; j < res[i].size(); ++j)
          {
            res[i + pre_num].push_back(res[i][j]);
          }
        }
      }

      vector<vector<int>> combination(int n)
      {
        assert(n > 0);
        int num = pow(2, n);
        vector<vector<int>> res(num, vector<int>{});
        combinationRecursive(n, res);
        return res;
      }

    .. code-block:: cpp
      :linenos:

      // 方法三，统计二进制中 1 的个数

      vector<vector<int>> combination(int n)
      {
        assert(n > 0);
        int num = pow(2, n);
        vector<vector<int>> res(num, vector<int>{});
        int k = num - 1;
        while (k >= 0)
        {
          int pos = n - 1;
          while (pos >= 0)
          {
            if (k & (1 << pos)) res[k].push_back(pos + 1);
            --pos;
          }
          --k;
        }
        return res;
      }



- [LeetCode] Distinct Subsequences II 子序列个数（含重复元素的组合数）。Hint：方法一，动态规划，设 :math:`dp[k]` 是以 :math:`S[k]` 结尾的子序列个数，
  如果不考虑重复，则 :math:`dp[k] = dp[0] + dp[1] + \cdots + dp[k-1] + 1` ，即在前面的子序列末尾追加 :math:`S[k]` ，或 :math:`S[k]` 单独构成的子序列（ :math:`+1` ）；
  然而要减掉以 :math:`S[k]` 结尾的重复子序列： :math:`dp[k]\ -= dp[r],\ 0 \leqslant r < k \ \&\& \ S[k]=S[r]` ；
  方法二，回溯：设当前子序列集合最后一个元素的下标为 :math:`i` ，在把当前字符（设下标为 :math:`t` ）加入子序列集合时，
  需要考虑区间 :math:`(i, t)` （如果当前子序列集合为空，区间为 :math:`[0, t)` ）内是否有 :math:`S[t]` 的重复元素，如果有，则不能把 :math:`S[t]` 插入当前子序列中，否则就造成重复；回溯方法严重超时。

    https://leetcode.com/problems/distinct-subsequences-ii/submissions/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 方法一

      class Solution
      {
      public:
          int distinctSubseqII(string S)
          {
              if(S.empty()) return 0;
              vector<long long> dp(S.size(), 0);
              dp[0] = 1;
              for(size_t i = 1; i < S.size(); ++i)
              {
                  dp[i] = accumulate(dp.begin(), dp.begin() + i, 1LL); // + 1，这里的 1LL 表示 long long int，默认的 int 型导致溢出，结果错误
                  for(size_t k = 0; k < i; ++k)
                  {
                      if(S[k] == S[i]) // 减去重复
                      {
                          dp[i] -= dp[k];
                          while(dp[i] < 0) dp[i] += 1000000007; // 减法操作可能会使得 dp[i] < 0
                      }
                  }
                  dp[i] = dp[i] % 1000000007;
              }
              return accumulate(dp.begin(), dp.end(), 0LL) % 1000000007; // 0LL
          }
      };

    .. code-block:: cpp
      :linenos:

      // 方法一改进型

      // 设 dp[k] 是以 S[k] 结尾的不重复子序列个数（定义与上面的方法一相同），
      // 设 end[i] 是以字符 'a' + i 结尾的子序列个数，0 <= i < 26，
      // 如果该字符出现在多个位置，如 {j，k，l}，则 end[i] = dp[j] + dp[k] + dp[l]，
      // 由方法一可知：dp[l] = \sum_{m=0}^{l-1} dp[m] + 1 - dp[j] - dp[k]，
      // 因此 end[i] = \sum_{m=0}^{l-1} dp[m] + 1 = \sum_{n=0}^25 end[n] + 1

      class Solution
      {
      public:
          int distinctSubseqII(string S)
          {
              if(S.empty()) return 0;
              long long end[26] = {0};
              for(size_t i = 0; i < S.size(); ++i)
              {
                  end[S[i] - 'a'] = accumulate(end, end + 26, 1LL) % 1000000007;
              }
              return accumulate(end, end + 26, 0LL) % 1000000007;
          }
      };

    .. code-block:: cpp
      :linenos:

      // 方法二

      class Solution
      {
      public:
          int distinctSubseqII(string S)
          {
              if(S.empty()) return 0;
              int ans = 0;
              vector<int> subS; // 当前子序列集合
              DFS(S, 0, subS, ans);
              return ans;
          }
      private:
          bool hasRepeat(string& S, vector<int>& subS, int t)
          {
              bool repeat = false;
              size_t i;
              if(subS.empty()) i = 0;
              else i = subS.back() + 1;
              for(; i < t; ++i)
              {
                  if(S[i] == S[t])
                  {
                      repeat = true;
                      break;
                  }
              }
              return repeat;
          }
          void DFS(string& S, int t, vector<int>& subS, int &ans)
          {
              if(t == S.size())
              {
                  if(!subS.empty()) ans = (ans + 1) % 1000000007;
                  return;
              }
              DFS(S, t+1, subS, ans); // 当前子序列集合不包括 S[t]
              if(!hasRepeat(S, subS, t)) // 区间 (i, t) （或 [0, t)）内不包括 S[t] 的重复字符，才可以把 S[t] 加入当前子序列集合
              {
                  subS.push_back(t);
                  DFS(S, t+1, subS, ans);
                  subS.pop_back();
              }
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
              bool** flag = new bool*[M+2]; // 设置一圈边界，标记为 false，后面访问 board 中的 4 个领域不用再判断是否越界；flag 的大小为 (M+2)x(N+2)
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


- Knuth-Shuffle，公平的洗牌算法：生成每一种排列的概率都是 :math:`\frac{1}{n!}`。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      void shuffle(int* arr, int n)
      {
        for(int i = n - 1; i >= 0; --i)
        {
          swap(arr[i], arr[rand()%(i+1)]);
        }
      }
