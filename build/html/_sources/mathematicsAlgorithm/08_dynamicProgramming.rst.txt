动态规划
=============

矩阵连乘
-------------

矩阵连乘，通过调整加括号的方式，使得乘法元素次数最少。设矩阵链 :math:`A[0:n-1]` ， :math:`A[i]` 的维度为 :math:`p_i \times p_{i+1}` 。
:math:`m[i][j]` 是计算 :math:`A[i:j],\ 0 \leqslant i \leqslant j \leqslant n-1` 所需的最少乘法次数。

递推关系：

.. math::
  :nowrap:

  $$
  m[i][j] =
  \begin{cases}
     \mathrm{min} \{ m[i][k] + m[k+1][j] + p_i \times p_{k+1} \times p_{j+1} \},\ i \leqslant k < j & & i \ne j \\
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


最长公共子序列
------------------

用 :math:`c[i][j]` 记录序列 :math:`X[0:i-1]` （前 :math:`i` 个字符）和 :math:`Y[0:j-1]` （前 :math:`j` 个字符）的最长公共子序列的长度。

递推关系：

.. math::

  c[0][j] & =  0,\ 0 \leqslant j \leqslant n \\
  c[i][0] & =  0,\ 0 \leqslant i \leqslant m

.. math::
  :nowrap:

  $$
  c[i][j] =
  \begin{cases}
     c[i-1][j-1] + 1 & & {i,j > 0;\ X[i-1] = Y[j-1]} \\
     \mathrm{max}\{ c[i-1][j], c[i][j-1] \} & & {i,j > 0;\ X[i-1] \ne Y[j-1]}
  \end{cases}
  $$


.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Code}`

  .. code-block:: cpp
    :linenos:

    void lcsLength(char* x, int m, char* y, int n, int** c)
    {
      for(int i = 0; i <= m; ++i) c[i][0] = 0;
      for(int j = 0; j <= n; ++j) c[0][j] = 0;
      for(int i = 1; i <= m; ++i)
      {
        for(int j = 1; j <=n; ++j)
        {
          if(x[i-1] == y[j-1]) c[i][j] = c[i-1][j-1] + 1; // 注意：这里是比较 x[i-1] 和 y[j-1]，而不是 x[i] 和 y[j]
          else c[i][j] = max(c[i-1][j], c[i][j-1]);
        }
      }
    }

  .. code-block:: cpp
    :linenos:

    /* 记录并构造公共子序列 */

    // 方法一

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

  .. code-block:: cpp
    :linenos:
    
    // 方法二
    string lcs(const string a, const string b)
    {
      const int m = a.size();
      const int n = b.size();
      vector<vector<string>> dp(2, vector<string>(n+1, ""));
      for(int i = 1; i <= m; ++i)
      {
        for(int j = 1; j <= n; ++j)
        {
          if(a[i-1] == b[j-1]) dp[i&1][j] = dp[(i-1)&1][j-1] + a[i-1];
          else dp[i&1][j] = dp[(i-1)&1][j].size() > dp[i&1][j-1].size()? dp[(i-1)&1][j]: dp[i&1][j-1];
        }
      }
      string res = dp[m&1][n];
      dp.clear();
      dp.shrink_to_fit();
      return res;
    } 


相关题：最短编辑距离。

.. math::

  d[0][j] & = j,\ 0 \leqslant j \leqslant n \\
  d[i][0] & = i,\ 0 \leqslant i \leqslant m


.. math::
  :nowrap:

  $$
  d[i][j] =
  \begin{cases}
     d[i-1][j-1] & & {i,j > 0;\ X[i-1] = Y[j-1]} \\
     \mathrm{min} \{ d[i-1][j], d[i][j-1], d[i-1][j-1] \} + 1 & & {i,j > 0;\ X[i-1] \ne Y[j-1]}
  \end{cases}
  $$


最长上升子序列
------------------

- 方法一

  设 :math:`dp[i]` 是以 :math:`a[i]` 结尾的最长上升子序列的长度。

  递推关系：

  .. math::

      dp[i] = \mathrm{max}\{ 1, dp[j]+1\ |\ j < i\ \text{且}\ a[j] < a[i]\}.

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


最大子段和
---------------

设 :math:`dp[i]` 是以 :math:`a[i]` 结尾的最大子段和。

递推关系：

.. math::

    dp[i] = \mathrm{max}\{ dp[i-1] + a[i], a[i] \},\ 1 \leqslant i < n.

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
          dp = max(dp + a[i], a[i]);
          res = max(res, dp);
        }
        return res;
      }



0-1背包问题
------------------

设 :math:`dp[i][j]` 表示从 :math:`0` 到 :math:`i-1` 这前 :math:`i` 个物品中选出总重量不超过 :math:`j` 的物品时总价值的最大值。

递推关系：

.. math::
  :nowrap:

  $$
  dp[0][j] = 0,\ 0 \leqslant j \leqslant W
  $$

  $$
  dp[i+1][j] =
  \begin{cases}
     dp[i][j] & & j < w[i] \\
     \mathrm{max}\{ dp[i][j], dp[i][j-w[i]] + v[i] \} & &  j \geqslant w[i]
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


状态压缩动态规划
------------------------

动态规划的状态有时候不容易表示出来，需要用一些编码技术，把状态用简单的方式表示出来（压缩）。
典型方式：当需要表示一个集合有哪些元素时，往往用一个整数表示，整数的二进制表示中的1表示对应位置的元素存在于集合中，0表示不存在。

[Poj 3254] Corn Fields
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

问题描述：一个 :math:`N \times N` 的矩阵牧场，每个方格单元有两种状态：可放牧（1）和不可放牧（0）；在这块牧场放牛，要求两个相邻的方格不能同时放牛（不包括斜着的），即牛与牛不能挨着；问有多少种放牛方案（一头牛都不放也是一种方案）？

策略：用一个集合（状态压缩）维护所有不相邻的情况，在此基础上再去考虑哪些方格可放牧。
设 :math:`dp[i][j]` 表示：在第 :math:`i` 行状态为 :math:`j\ (0 \leq j \leq 2^m-1)` 时，
前 :math:`i+1` 行牧场方格总共的放牛方案数量。

递推关系：

.. math::
  :nowrap:

  $$
  dp[i][j] = 
  \begin{cases}
  1 & & {i=0;\ \text{状态 j 可以放牧且牛不相邻}} \\
  \sum_{j^{\prime}} dp[i-1][j^{\prime}] & & {i>0;\ \text{状态 j 可以放牧且牛不相邻}} \\
  0 & & {\text{状态 j 不可以放牧或牛相邻}}
  \end{cases}
  $$

.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Code}`

  .. code-block:: cpp
    :linenos:

    const int N = 13;
    const int M = 1 << N;
    const int mod = 10000007;
    int field[N][N]; // 方格能否放牧的标志
    int row_nadj_state[M]; // 不相邻的行状态编码
    int row_forbid_state[M]; // 不可放牧的位置编码
    int dp[N][M];

    bool hasAdj(int s)
    {
      return (s & (s<<1));
    }
    bool locForbid(int i, int j)
    {
      return (row_forbid_state[i] & row_nadj_state[j]);
    }
    int solve()
    {
      for(int i = 0; i < N; ++i)
      {
        for(int c = 0; c < N; ++c)
        {
          if(field[i][c] == 0) row_forbid_state[i] += 1 << c;
        }
      }
      int k = 0; // 不相邻行状态的数量
      for(int s = 0; s < M; ++s)
      {
        if(!hasAdj(s)) row_nadj_state[k++] = s;
      }
      for(int j = 0; j < k; ++j)
      {
        if(!locForbid(0, j)) dp[0][j] = 1; // 第1行初始化
      }
      for(int i = 1; i < N; ++i)
      {
        for(int j = 0; j < k; ++j)
        {
          if(locForbid(i, j)) continue;
          for(int pre_j = 0; pre_j < k; ++pre_j)
          {
            if(locForbid(i-1, pre_j)) continue;
            if(!(row_nadj_state[pre_j] & row_nadj_state[j]))
            {
              dp[i][j] += dp[i-1][pre_j]; // 上下两行牛不相邻
              dp[i][j] = dp[i][j] % mod;
            }
          }
        }
      }
      int res = 0;
      for(int j = 0; j < k; ++j)
      {
        res += dp[N-1][j];
        res = res % mod;
      }
      return res;
    }


[Poj 3311] Hie With The Pie
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

问题描述：一个送外卖的人，从起点0出发，要经过所有地点一次，然后再回到起点，求最少花费的代价（旅行商问题）。

策略：假设当前已经访问过的顶点集合为 :math:`S` （起点0当做未访问过），当前所在顶点为 :math:`v` ，  :math:`dp[S][v]` 表示：从 :math:`v` 出发访问剩余所有顶点，最终回到起点0的路径的权重总和的最小值。设 :math:`V` 表示所有顶点的集合。

递推关系：

.. math::

  dp[V][0] &= 0 \\
  dp[S][v] &=  \mathrm{min}\{ dp[S \cup u][u] + d[v][u] \},\ u \notin S
  

.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Code}`

  .. code-block:: cpp
    :linenos:

    // 递归：时间复杂度 O(n^2 \times 2^n)
    int d[N][N]; // 邻接矩阵
    int dp[1 << N][N]; 

    int minCost(int S, int v)
    {
      if(dp[S][v] >= 0) return dp[S][v]; // 记忆化搜索已经有的结果
      if(S == (1<<N)-1 && v == 0) return dp[S][v] = 0; // 递归终止条件：已访问过所有顶点并返回起点0
      int res = INF;
      for(int u = 0; u < N; ++u)
      {
        if(!(S >> u & 1)) // 顶点 u 未访问过，下一步移动到顶点 u 
        {
          res = min(res, minCost(S | 1 << u, u) + d[v][u]);
        }
      }
      return dp[S][v] = res;
    }
    int solve()
    {
      memset(dp, -1, sizeof(dp));
      return minCost(0, 0);
    }

  .. code-block:: cpp
    :linenos:

    // 循环
    int d[N][N]; // 邻接矩阵
    int dp[1 << N][N]; 
    int solve()
    {
      for(int S = 0; S < 1<<N; ++S) fill(dp[S], dp[S] + N, INF); // 用足够大的值初始化
      dp[(1<<N)-1][0] = 0; // 初始化
      for(int S = (1<<N)-2; S >= 0; --S)
      {
        for(int v = 0; v < N; ++v) // 当 v 不属于集合 S，dp[S][v]是无效的、从 0 出发不可达的状态
        {
          for(int u = 0; u < N; ++u)
          {
            if(!(S >> u & 1)) dp[S][v] = min(dp[S][v], dp[S | 1<<u][u] + d[v][u]);
          }
        }
      }
      return dp[0][0];
    }


相反地，参考资料1将 :math:`dp[S][v]` 定义为：走完集合 :math:`S` 后最后停留在顶点 :math:`v` 的最小代价。

实例
-----------------

- 有面值 1,5,10,20,50,100 的人民币，求问 10000 有多少种组成方法？

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
          // 把 1 从 num[] 中去掉了，转化到初始化中。全用 1 元只能得到一种组成方案
          for(i = 0; i < maxn; ++i)
              dp[i] = 1; 
          for(i = 0; i < 5; ++i)
              for(j = num[i]; j < maxn; ++j)
                  dp[j] += dp[j - num[i]];
          printf("%lld", dp[maxn - 1]);
          return 0;
      }

      // 注意：
      // 上面的两重 for 循环位置不能交换
      // 如果交换了，那么得到的结果将会包含重复的组合（只是排列顺序不同）
      // 其含义为：在 dp[j - num[i]] 的组合末尾添加 num[i] 得到 dp[j]


- 如何用最少的次数测出鸡蛋会在哪一层摔碎？

  https://www.zhihu.com/question/19690210

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: python
      :linenos:

      ## 作者：知乎用户
      ## 链接：https://www.zhihu.com/question/19690210/answer/18079633
      ## f(n, m)：n 层楼，m 个鸡蛋所需最少次数
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

    .. code-block:: python
      :linenos:

      def solve(N, M):
          if N < 1 or M < 1:
              return 0

          inf = float('inf')
          f = [[inf for _m in range(M+1)] for _n in range(N+1)]
          for m in range(M+1):
              f[0][m] = 0
              f[1][m] = 1
          for n in range(2, N+1):
              f[n][1] = n

          for n in range(2, N+1):
              for m in range(2, M+1):
                  for k in range(1, n+1):
                      f[n][m] = min(f[n][m], max(f[k-1][m-1], f[n-k][m]) + 1)

          return f[N][M]

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

- [LeetCode] Knight Dialer 马踏数字键盘。Hint：回溯算法超时，用动态规划，考虑空间复用。

  https://leetcode.com/problems/knight-dialer/

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class Solution 
      {
      public:
          int knightDialer(int n) 
          {
              if(n < 1) return 0;
              if(n == 1) return 10;
              int mod = 1000000007;
              const int row = 4;
              const int col = 3;
              vector<vector<int>> dp(2, vector<int>(row*col, 0));
              for(int i = 0; i < row*col; ++i)
              {
                  if(i != 9 && i != 11) dp[0][i] = 1;
              }
              int res = 0;
              for(int t = 1; t < n; ++t)
              {
                  fill(dp[t&1].begin(), dp[t&1].end(), 0); // 空间复用，需要预先清零
                  for(int i = 0; i < row*col; ++i)
                  {
                      if(i != 9 && i != 11) // 略过非数字键
                      {
                          for(int k = 0; k < 8; ++k)
                          {
                              int x = i / col + mv[k][0]; // 获取行列号
                              int y = i % col + mv[k][1];
                              if(x < 0 || x >= row || y < 0 || y >= col) continue;
                              dp[t&1][i] += dp[(t-1)&1][x*col+y];
                              dp[t&1][i] %= mod;
                          }
                      }
                      if(t == n-1) res = (res + dp[t&1][i]) % mod;
                  }
              }
              return res;
          }
      private:
          const static int mv[8][2];
      };
      const int Solution::mv[8][2] = {{-2,-1},{-2,1},{-1,-2},{-1,2},{1,-2},{1,2},{2,-1},{2,1}};

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

  https://leetcode.com/problems/regular-expression-matching/
  
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


- 最大子矩阵的和。Hint：行区间遍历，列区间采用动态规划，时间复杂度 :math:`\mathcal{O}(n^3)` 。

  .. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Code}`

    .. code-block:: cpp
      :linenos:

      class SubMatrix
      {
      public:
          int sumOfSubMatrix(vector<vector<int> > mat, int n)
          {
              if(n <= 0) return 0;
              for(int r = 1; r < n; ++r)
              {
                  for(int c = 0; c < n; ++c)
                  {
                      mat[r][c] += mat[r-1][c]; // 计算前 r 行和，避免后面重复计算
                  }
              }
              int res = INT_MIN;
              for(int r1 = 0; r1 < n; ++r1)
              {
                  for(int r2 = r1; r2 < n; ++r2)
                  {
                      vector<int> subMat(mat[r2].begin(), mat[r2].end());
                      if(r1 > 0)
                      {
                          for(int c = 0; c < n; ++c) subMat[c] -= mat[r1-1][c]; // subMat 是行区间 [r1, r2] 的和
                      }
                      int dp = 0;
                      for(int c = 0; c < n; ++c)
                      {
                          dp = max(dp + subMat[c], subMat[c]);
                          res = max(res, dp);
                      }
                  }
              }
              return res;
          }
      };


参考资料
-------------

1. 状态压缩DP入门

  https://cnblogs.com/ibilllee/p/7651971.html
