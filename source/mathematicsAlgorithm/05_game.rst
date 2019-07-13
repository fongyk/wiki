游戏与必胜策略
==================

硬币游戏
------------

**描述** ：有 :math:`x` 枚硬币，A 和 B 两个人轮流取，每次所取的硬币数量要在 :math:`a_1, a_2,...,a_k` 当中（其中包含 :math:`1` ）。
A 先取，取走最后一枚硬币的一方获胜。当双方都采取最优策略，谁会获胜？

**策略** ：动态规划。考虑轮到 A 时，还剩下 :math:`j` 枚硬币。当 :math:`j=0` ，A 必败；如果存在 :math:`a_i` ，使得 :math:`j - a_i` 是必败态，则 :math:`j` 就是必胜态；
如果对于所有的 :math:`a_i` ， :math:`1 \leqslant i \leqslant k` ，使得 :math:`j - a_i` 都是必胜态，则 :math:`j` 是必败态。


.. code-block:: cpp
  :linenos:

  int X, K, A[MAX_K];

  bool win[MAX_X + 1];

  void solve()
  {
    win[0] = false;
    for(int j = 1; j <= X; ++j)
    {
      win[j] = false;
      for(int i = 0; i < K; ++i)
      {
        win[j] = win[j] | (A[i]<=j && !win[j-A[i]]);
      }
    }
  }


Nim 游戏
---------------

**描述** ：有 :math:`n` 堆石子，每堆 :math:`a_i` 颗石子。A 和 B 两个人轮流取，每次从石子堆中至少取走一颗。A 先取，最后取光所有石子的一方获胜。当双方都采取最优策略，谁会获胜？

**策略** ： :math:`a_1\ \oplus\ a_2\ \oplus\ ...\ \oplus\ a_n \ne 0` （异或运算），则 A 必胜； :math:`a_1\ \oplus\ a_2\ \oplus\ ...\ \oplus\ a_n = 0` ，则 A 必败。


Grundy 数
--------------

**描述** ：有 :math:`n` 堆硬币，每堆 :math:`x_i` 枚硬币。A 和 B 两个人轮流取，每次所取的硬币数量要在 :math:`a_1, a_2,...,a_k` 当中（其中包含 :math:`1` ）。
A 先取，取走最后一枚硬币的一方获胜。当双方都采取最优策略，谁会获胜？

**策略** ：转换成 Nim， :math:`grundy(x_1)\ \oplus\ grundy(x_2)\ \oplus\ ...\ \oplus\ grundy(x_n) \ne 0` 则 A 必胜，否则必败。
当前状态的 grundy 值表示：从该状态出发，一步可达状态的 grundy 值的集合之外的最小非负整数。

.. code-block:: cpp
  :linenos:

  int N, K, X[MAX_N], A[MAX_K];

  int grundy[MAX_X + 1]; // 全局数组，初始化为 0

  void solve()
  {
    grundy[0] = 0;

    int max_x = *max_element(X, X+N);
    for(int j = 0; j <= max_x; ++j)
    {
      set<int> s;
      for(int i = 0; i < K; ++i)
      {
        if(A[i] < j) s.insert(grundy[j - A[i]]); // 一步可达状态的 grundy 值
      }
      int g = 0; // 集合之外的最小非负整数
      while(s.count(g) != 0) g++;
      grundy[j] = g;
    }

    int res = 0;
    for(int n = 0; n < N; ++n) res ^= grundy[X[n]];
    if(res != 0) cout << "A wins." << endl;
    else cout << "B wins." << endl;
  }


两端取数
---------------

**描述** ：有一串数字，A 和 B 两人轮流从两端取任意个数（至少取 1 个），直到取完所有的数。A 先取，两个人都采取最优策略，求 A 所取数的和比 B 所取数的和大多少？

**策略** ：动态规划。:math:`dp[i][j]` 表示从闭区间 :math:`[i,j]` 取完所有数字之后，先取的那个人所取数的和与后取的那个人所取数的和的差值。
假设第一个人先从区间 :math:`[i,j]` 取 :math:`k\ (1 \leqslant k \leqslant j-i+1)` 个数，可以从左端取，也可以从右端取。
如果从左端取，先取的人得到的和为 :math:`sum[i+k] - sum[i]` ，后取的人得到的和为 :math:`dp[i+k][j]` ；如果从右端取，先取的人得到的和为 :math:`sum[j+1] - sum[j-k+1]` ，后取的人得到的和为 :math:`dp[i][j-k]` 。
因此，

.. math::

  dp[i][j] = max\{ sum[i+k] - sum[i] - dp[i+k][j], sum[j+1] - sum[j-k+1] - dp[i][j-k] \},\ 1 \leqslant k \leqslant j-i+1.

其中 :math:`sum[i]` 表示数列区间 :math:`[0,i-1]` 的和（前 :math:`i` 项和）。

.. code-block:: cpp
  :linenos:

  int maxSum(vector<int> num)
  {
    int n = num.size();
    assert(n > 0);

    vector<vector<int>> dp(n, vector<int>(n, 0));
    for (int i = 0; i < n; ++i) dp[i][i] = num[i];

    vector<int> sum(n + 1, 0);
    partial_sum(num.begin(), num.end(), sum.begin()+1);

    for (int gap = 1; gap < n; ++gap)
    {
      for (int i = 0; i + gap < n; ++i)
      {
        int j = i + gap;
        dp[i][j] = sum[j+1] - sum[i]; // 第一个人一次取完区间内所有的数，则第二个人取的数和为 0
        for (int k = 1; k < j-i+1; ++k)
        {
          dp[i][j] = max(dp[i][j], max(sum[i+k] - sum[i] - dp[i+k][j], sum[j+1] - sum[j-k+1] - dp[i][j-k])); // 第一个人取 k 个数
        }
      }
    }

    int res = dp[0][n - 1];
    dp.clear(); dp.shrink_to_fit();
    sum.clear(); sum.shrink_to_fit();
    return res;
  }
