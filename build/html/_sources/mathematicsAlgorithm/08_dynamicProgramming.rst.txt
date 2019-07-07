动态规划
=============

矩阵连乘
-------------

矩阵连乘，通过调整加括号的方式，使得乘法元素次数最少。设矩阵链 :math:`A[0:n-1]` ， :math:`A[i]` 的维度为 :math:`p_i \times p_{i+1}` 。 :math:`m[i][j]` 是计算 :math:`A[i:j],\ 1 \leqslant i \leqslant j \leqslant n` 所需的最少乘法次数。

递归关系：

.. math::
  :nowrap:

  $$
  m[i][j] =
  \begin{cases}
     min \{ m[i][k] + m[k+1][j] + p_i \times p_{k+1} \times p_{j+1} \},\ i \leqslant k < j & & i \ne j \\
     0 & &  i = j
  \end{cases}

  $$

.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Code}`

  .. code-block:: cpp
    :linenos:

    // s[i][j] 记录 A[i:j] 的划分点 k
    void matrixChain(int* p, int n, int** m, int** s)
    {
      for(int i = 0; i < n; ++i) m[i][i] = 0;
      for(int gap = 1; gap < n; ++gap)
      {
        for(int i = 0; i + gap < n; ++i)
        {
          int j = i + gap;
          m[i][j] = m[i+1][j] + p[i] * p[i+1] * p[j+1]; // k = i
          s[i][j] = i;
          for(int k = i+1; k < j; ++k)
          {
            int cost = m[i][k] + m[k+1][j] + p[i] * p[k+1] * p[j+1];
            if(cost < m[i][j])
            {
              m[i][j] = cost;
              s[i][j] = k;
            }
          }
        }
      }
    }

|


最长公共子序列
------------------

用 :math:`c[i][j]` 记录序列 :math:`X[0:i-1]` （前 :math:`i` 个字符）和 :math:`Y[0:j-1]` （前 :math:`j` 个字符）的最长公共子序列的长度。

递归关系：

.. math::
  :nowrap:

  $$
  c[0][j] = 0,\ 0 \leqslant j \leqslant n \\
  c[i][0] = 0,\ 0 \leqslant i \leqslant m
  $$

  $$
  c[i][j] =
  \begin{cases}
     c[i-1][j-1] + 1 & & {i,j > 0;\ X[i-1] = Y[j-1]} \\
     max\{ c[i-1][j], c[i][j-1] \} & & {i,j > 0;\ X[i-1] \ne Y[j-1]}
  \end{cases}
  $$


.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Code}`

  .. code-block:: cpp
    :linenos:

    void lcsLength(char* x, int m, char* y, int n, int** c) // c 对应的实参为 int *c[]
    {
      for(int i = 0; i <= m; ++i) c[i][0] = 0;
      for(int j = 0; j <= n; ++j) c[0][j] = 0;
      for(int i = 1; i <= m; ++i)
      {
        for(int j = 1; j <=n; ++j)
        {
          if(x[i-1] == y[j-1]) c[i][j] = c[i-1][j-1] + 1;
          else c[i][j] = max(c[i-1][j], c[i][j-1]);
        }
      }
    }

  .. code-block:: cpp
    :linenos:

    /* 记录并构造公共子序列 */

    void lcsLength(char* x, int m, char* y, int n, int** c, int** b)
    {
      for(int i = 0; i <= m; ++i) c[i][0] = 0;
      for(int j = 0; j <= n; ++j) c[0][j] = 0;
      for(int i = 1; i <= m; ++i)
      {
        for(int j = 1; j <=n; ++j)
        {
          if(x[i-1] == y[j-1])
          {
            c[i][j] = c[i-1][j-1] + 1;
            b[i][j] = 0;
          }
          else
          {
            if(c[i-1][j] > c[i][j-1])
            {
              c[i][j] = c[i-1][j];
              b[i][j] = 1;
            }
            else
            {
              c[i][j] = c[i][j-1];
              b[i][j] = 2;
            }
          }
        }
      }
    }

    void lcs(char* x, int m, int n, int** b)
    {
      if(m == 0 || n == 0) return;
      if(b[m][n] == 0)
      {
        lcs(x, m-1, n-1, b);
        cout << x[m-1];
      }
      else if(b[m][n] == 1) lcs(x, m-1, n, b);
      else lcs(x, m, n-1, b);
    }

|

最长上升子序列
------------------

- 方法一

  设 :math:`dp[i]` 是以 :math:`a[i]` 结尾的最长上升子序列的长度。

  递归关系：

  .. math::

      dp[i] = max\{ 1, dp[j]+1\ |\ j < i\ \text{且}\ a[j] < a[i]\}.

.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Code}`

  .. code-block:: cpp
      :linenos:

      /* O(n^2) in time.*/
      int n;
      int a[MAX_N];

      int dp[MAX_N];

      int solve()
      {
        int res = 0;
        for(int i = 0; i < n; ++i)
        {
          dp[i] = 1;
          for(int j = 0; j < i; ++ j)
          {
            if(a[j] < a[i]) dp[i] = max(dp[i], dp[j] + 1);
          }
          res = max(res, dp[i]);
        }
        return res;
      }


- 方法二

  设 :math:`dp[i]` 是长度为 :math:`i+1` 的上升子序列中末尾元素的最小值。

.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Code}`

  .. code-block:: cpp
      :linenos:

      /* https://leetcode.com/problems/longest-increasing-subsequence/ */
      /* O(nlogn) in time.*/
      class Solution
      {
      public:
        int lengthOfLIS(vector<int>& nums)
        {
          if(nums.size()<=1) return nums.size();
          int inf = INT_MAX;
          int len = nums.size();
          int* dp = new int[len];
          fill(dp, dp+len, inf);
          for(int k = 0; k < len; ++k) *lower_bound(dp, dp+len, nums[k]) = nums[k];
          int length = lower_bound(dp, dp+len, inf) - dp;
          delete[] dp;
          return length;
        }
      };

|

最大子段和
---------------

设 :math:`dp[i]` 是以 :math:`a[i]` 结尾的最大子段和。

递归关系：

.. math::

    dp[i] = max\{ dp[i-1] + a[i], a[i] \},\ 1 \leqslant i < n.

.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Code}`

  .. code-block:: cpp
      :linenos:

      int maxSum(int* a, int n)
      {
        int dp = 0;
        int res = 0;
        for(int i = 0; i < n; ++i)
        {
          if(dp > 0) dp += a[i];
          else dp = a[i];
          res = max(res, dp);
        }
        return res;
      }

|


0-1背包问题
------------------

设 :math:`dp[i][j]` 表示从 :math:`0` 到 :math:`i-1` 这前 :math:`i` 个物品中选出总重量不超过 :math:`j` 的物品时总价值的最大值。

递归关系：

.. math::
  :nowrap:

  $$
  dp[0][j] = 0,\ 0 \leqslant j \leqslant W
  $$

  $$
  dp[i+1][j] =
  \begin{cases}
     dp[i][j] & & j < w[i] \\
     max\{ dp[i][j], dp[i][j-w[i]] + v[i] \} & &  j \geqslant w[i]
  \end{cases}
  $$

.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Code}`

  .. code-block:: cpp
      :linenos:

      int n, W;
      int w[MAX_N], v[MAX_N];
      int dp[MAX_N+1][MAX_W+1];
      int solve()
      {
        for(int i = 0; i < n; ++i)
        {
          for(int j = 0; j <= W; ++j)
          {
            if(j < w[i]) dp[i+1][j] = dp[i][j];
            else dp[i+1][j] = max(dp[i][j], dp[i][j-w[i]] + v[i]);
          }
        }
        return dp[n][W];
      }

  .. code-block:: cpp
      :linenos:

      // 由于计算 dp[i+1] 只需要用到 dp[i] 和 dp[i+1]，因此可以进一步降低空间复杂度
      int dp[2][MAX_W+1];
      int solve()
      {
        for(int i = 1; i <= n; ++i)
        {
          for(int j = 0; j <= W; ++j)
          {
            if (j < w[i - 1]) dp[i & 1][j] = dp[(i - 1) & 1][j];
            else dp[i & 1][j] = max(dp[(i - 1) & 1][j], dp[(i - 1) & 1][j - w[i - 1]] + v[i - 1]);
          }
        }
        return dp[n & 1][W];
      }

|

实例
-----------------

- 有面值1,5,10,20,50,100的人民币，求问10000有多少种组成方法？

  https://www.zhihu.com/question/315108379

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
      :linenos:

      import numpy as np
      money = np.array([1, 5, 10, 20, 50, 100])
      dp = np.array([[0 for i in range(10000+1)] for j in range(6+1)], dtype=np.int64)
      ## dp[m,n]: first m currency values, make money n
      dp[0,:] = 0
      dp[:,0] = 1
      for m in range(1,6+1):
          for n in range(1, 10000+1):
              if n >= money[m-1]:
                  dp[m,n] = dp[m,n-money[m-1]] + dp[m-1,n]
              else:
                  dp[m,n] = dp[m-1,n]
      print dp[6, 10000]

    .. code-block:: cpp
      :linenos:

      // 作者：李泽政
      // 链接：https://www.zhihu.com/question/315108379/answer/620254961

      #include<cstdio>
      #define maxn 10001
      long long dp[maxn];
      int main(void)
      {
          int i,j,num[] = {5, 10, 20, 50, 100};
          for(i = 0; i < maxn; ++i)
              dp[i] = 1; // 作者把 1 从 num[] 中去掉了，转化到初始化中。全用 1 元只能得到一种组成方案
          for(i = 0; i < 5; ++i)
              for(j = num[i]; j < maxn; ++j)
                  dp[j] += dp[j - num[i]];
          printf("%lld", dp[maxn - 1]);
          return 0;
      }


- 如何用最少的次数测出鸡蛋会在哪一层摔碎？

  https://www.zhihu.com/question/19690210

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
      :linenos:

      ## 作者：知乎用户
      ## 链接：https://www.zhihu.com/question/19690210/answer/18079633
      ## f(n,m)：n 层楼，m 个鸡蛋所需最少次数
      ## f(0, m) = 0
      ## f(n, 1) = n
      ## f(n, m) = min{max{f(k-1, m-1), f(n-k, m)}} + 1, 1 <= k <= n。 k 表示尝试在第 k 层扔下鸡蛋。

      import functools
      @functools.lru_cache(maxsize=None)
      def f(n, m):
          if n == 0:
              return 0
          if m == 1:
              return n

          ans = min([max([f(i - 1, m - 1), f(n - i, m)]) for i in range(1, n + 1)]) + 1
          return ans

      print(f(100, 2))	# 14
      print(f(200, 2))	# 20

- 机器人走方格。从 :math:`(0,0)` 走到 :math:`(x-1,y-1)` ，每一步只能往右或往下走。网格图 :math:`map` 定义了一些障碍点（ :math:`map[i][j] \ne 1` )，不能从障碍点通过。有多少种走法？
  延伸：如果没有障碍点，一共有 :math:`C_{(x-1)+(y-1)}^{(x-1)}` 种走法。

  https://www.nowcoder.com/practice/b3ae8b9782af4cf29253afb2f6d6907d?tpId=8&tqId=11034&rp=1&ru=%2Fta%2Fcracking-the-coding-interview&qru=%2Fta%2Fcracking-the-coding-interview%2Fquestion-ranking

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // dp(i, j) = dp(i-1, j) + dp(i, j-1)
      // 注意边界

      int countWays(vector<vector<int> > map, int x, int y)
      {
          vector<int> dp(y, 0);
          if(map[0][0] != 1) dp[0] = 0; // 起点初始化
          else dp[0] = 1;

          for(int row = 0; row < x; ++row)
          {
              for(int col = 0; col < y; ++col)
              {
                  if(row || col) // 忽略起点处
                  {
                      if(map[row][col] != 1) dp[col] = 0;
                      else
                      {
                          long long fromUp = 0; // long long 防止溢出
                          if(row > 0) fromUp = dp[col];
                          long long fromLeft = 0;
                          if(col > 0) fromLeft = dp[col-1];
                          dp[col] = (int)((fromUp + fromLeft)%1000000007);
                      }
                  }
              }
          }
          return dp[y-1];
      }

- :math:`n` 个骰子点数之和及其频数。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      // 方法一：动态规划
      // dp[k, n] 表示 k 个骰子，点数和为 n 的频数
      // dp[k, n] = dp[k-1, n-1] + dp[k-1, n-2] + dp[k-1, n-3] + dp[k-1, n-4] + dp[k-1, n-5] + dp[k-1, n-6]

      vector<int> diceSum(int n)
      {
        assert(n > 0);
        vector<vector<int>> dp(2, vector<int>(n*6+1, 0)); // n 个骰子，最大和为 6n
        fill(dp[1].begin()+1, dp[1].begin()+7, 1); // 1 个骰子，初始化

        for (int k = 2; k <= n; ++k)
        {
          fill(dp[k & 1].begin(), dp[k & 1].end(), 0); // k 个骰子，最小和为 k，最大和为 6k
          for (int s = k; s <= k * 6; ++s)
          {
            for (int i = 1; i <= 6 && s - i >= k-1; ++i) // k-1 个骰子，最小和为 k-1
            {
              dp[k & 1][s] += dp[(k - 1) & 1][s - i];
            }
          }
        }
        return dp[n & 1];
      }

    .. code-block:: python
      :linenos:

      ## 方法二：多项式系数
      ## 多项式 (x + x^2 + x^3 + x^4 + x^5 + x^6) ^ n 的系数就是点数和的频数，阶次对应点数和

      from numpy.polynomial.polynomial import Polynomial

      def diceSum(n):
          ## (0 + x + x^2 + x^3 + x^4 + x^5 + x^6) ^ n
          p = Polynomial((0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)) ** n
          return p.coef

- 正则表达式匹配。pattern 中 '.' 可以表示任意一个字符，'\*' 表示它前面的字符可以出现任意次（包括 0 次）。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
      :linenos:

      ## 动态规划，top-down
      ## dp[i][j] 表示 string：[i, len(string)) 与 pattern：[j, len(pattern)) 的匹配结果
      ## 空间复杂度：O(len(string) * len(pattern))

      class Solution(object):
          def isMatch(self, string, pattern):
              """
              :type s: str
              :type p: str
              :rtype: bool
              """
              dp = [[False] * (len(pattern) + 1) for _ in range(len(string) + 1)]
              dp[-1][-1] = True ## 初始化

              for s in range(len(string), -1, -1):
                  for p in range(len(pattern)-1, -1, -1):
                      flag = s < len(string) and pattern[p] in {string[s], '.'}
                      if p+1 < len(pattern) and pattern[p+1] == '*':
                          dp[s][p] = dp[s][p+2] or (flag and dp[s+1][p]) ## 匹配 0 次 or 多次
                      else:
                          dp[s][p] = flag and dp[s+1][p+1]
              return dp[0][0]

    .. code-block:: python
      :linenos:

      ## 存储复用，空间复杂度：O(2 * len(pattern))
      ## 注意：有些值需要更新，不能复用错误的值

      class Solution(object):
          def isMatch(self, string, pattern):
              dp = [[False] * (len(pattern) + 1) for _ in range(2)]

              for s in range(len(string), -1, -1):
                  if s == len(string):
                      dp[s&1][-1] = True ## 初始化
                  else:
                      dp[s&1][-1] = False ## 由于后面的循环不会更新 dp[s&1][-1]，如果直接复用之前的值，那么一直是 True，将导致错误
                  for p in range(len(pattern)-1, -1, -1):
                      flag = s < len(string) and pattern[p] in {string[s], '.'}
                      if p+1 < len(pattern) and pattern[p+1] == '*':
                          dp[s&1][p] = dp[s&1][p+2] or (flag and dp[(s+1)&1][p])
                      else:
                          dp[s&1][p] = flag and dp[(s+1)&1][p+1]
              return dp[0][0]
