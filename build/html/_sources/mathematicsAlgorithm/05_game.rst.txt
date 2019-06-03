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
