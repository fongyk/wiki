前缀函数与 KMP 算法
=====================

字符串基础
--------------

子串
^^^^^^^^^^

字符串 :math:`S` 的子串 :math:`S[i:j],\ i \leq j` ，表示 :math:`S` 串中从 :math:`i` 到 :math:`j` 这一段（注意，这里表示为双闭区间），也就是顺次排列 :math:`S[i],S[i+1],\cdots,S[j]` 形成的字符串，子串长度为 :math:`j-i+1` 。

有时也会用 :math:`S[i:j],\ i > j` 来表示空串。


子序列
^^^^^^^^^^

字符串 :math:`S` 的子序列是从 :math:`S` 中将若干元素提取出来且不改变相对位置形成的序列，即 :math:`S[p_1],S[p_2],\cdots,S[p_k]` ， :math:`0\le p_1 < p_2 < \cdots < p_k < |S|` 。


前缀
^^^^^^^^^^

前缀是指从串首开始到某个位置 :math:`i` 结束的一个特殊子串。字符串 :math:`S` 以 :math:`S[i]` 结尾的前缀表示为 :math:`Prefix(S,i) = S[0:i]` 。

**真前缀** 指除了 :math:`S` 本身之外的前缀。

举例来说，字符串 ``abcabcd`` 的所有前缀为 ``{a, ab, abc, abca, abcab, abcabc, abcabcd}`` ，而它的真前缀为 ``{a, ab, abc, abca, abcab, abcabc}`` 。


后缀
^^^^^^^^^^

后缀是指从某个位置 :math:`i` 开始到整个串末尾结束的一个特殊子串。字符串 :math:`S` 以 :math:`S[i]` 开头的后缀表示为 :math:`Suffix(S,i) = S[i:|S|-1]` 。

**真后缀** 指除了 :math:`S` 本身之外的前缀。

举例来说，字符串 ``abcabcd`` 的所有后缀为 ``{d, cd, bcd, abcd, cabcd, bcabcd, abcabcd}`` ，而它的真后缀为 ``{d, cd, bcd, abcd, cabcd, bcabcd}`` 。


字典序
^^^^^^^^^^

以第 :math:`i` 个字符作为第 :math:`i` 关键字进行大小比较，空字符小于字符集内任何字符（即： :math:`a < aa` ）。


前缀函数
-------------

给定一个长度为 :math:`n` 的字符串 :math:`S` ，其前缀函数被定义为一个长度为 :math:`n` 的数组 :math:`\pi` ：

- 如果子串 :math:`S[0:i]` 有一对相等的真前缀与真后缀：:math:`S[0:k-1]` 和 :math:`S[i-(k-1):i]` ，那么 :math:`\pi[i]` 就是这个相等的真前缀/真后缀的长度，即 :math:`\pi[i] = k` ；

- 如果不止有一对相等的真前缀与真后缀，那么 :math:`\pi[i]` 就是其中最长的那一对的长度；

- 如果没有相等的，那么 :math:`\pi[i] = 0` 。

简单来说， :math:`\pi[i]` 就是子串 :math:`S[0:i]` 最长的相等的真前缀与真后缀的长度。特别地，规定  :math:`\pi[0] = 0` 。

举例来说，对于字符串 ``abcabcd`` ：

- :math:`\pi[0]=0` ，因为 ``a`` 没有真前缀和真后缀，根据规定为 0。

- :math:`\pi[1]=0` ，因为 ``ab`` 无相等的真前缀和真后缀。

- :math:`\pi[2]=0` ，因为 ``abc`` 无相等的真前缀和真后缀。

- :math:`\pi[3]=1` ，因为 ``abca`` 只有一对相等的真前缀和真后缀：``a``，长度为 1。

- :math:`\pi[4]=2` ，因为 ``abcab`` 相等的真前缀和真后缀只有 ``ab``，长度为 2。

- :math:`\pi[5]=3` ，因为 ``abcabc`` 相等的真前缀和真后缀只有 ``abc``，长度为 3。

- :math:`\pi[6]=0` ，因为 ``abcabcd`` 无相等的真前缀和真后缀。

同理可以计算字符串 ``aabaaab`` 的前缀函数为 ``[0, 1, 0, 1, 2, 2, 3]`` 。


朴素算法
-------------

两重循环、子串比较，时间复杂度 :math:`\mathcal{O}(n^3)` 。

.. code-block:: cpp
  :linenos:

  vector<int> prefixFunction(const string& s)
  {
    int n = (int)s.length();
    vector<int> pi(n); // pi[0] = 0
    for (int i = 1; i < n; i++)
      for (int j = i; j >= 0; j--)
        if (s.substr(0, j) == s.substr(i - j + 1, j))
        {
          pi[i] = j;
          break;
        }
    return pi;
  } 


优化算法
----------

第一个优化
^^^^^^^^^^

相邻的前缀函数值至多相差 1，即 :math:`| \pi[i] - \pi[i+1] | \leq 1` 。

当 :math:`S[i+1] = S[\pi[i]]` ，此时 :math:`\pi[i+1] = \pi[i] + 1` 。

.. math:: 

    \underbrace{\overbrace{S_0 ~ S_1 ~ S_2}^{\pi[i] = 3} ~ S_3}_{\pi[i+1] = 4} ~ \cdots ~ \underbrace{\overbrace{S_{i-2} ~ S_{i-1} ~ S_{i}}^{\pi[i] = 3} ~ S_{i+1}}_{\pi[i+1] = 4}


第二个优化
^^^^^^^^^^

当 :math:`S[i+1] \neq S[\pi[i]]` ，我们希望找到对于子串 :math:`S[0:i]` ，仅次于 :math:`\pi[i]` 的第二长度 :math:`j` ，使得在位置 :math:`i` 的前缀性质仍得以保持，也即 :math:`S[0:j - 1] = S[i - j + 1: i]` 。

.. math:: 

    \overbrace{\underbrace{S_0 ~ S_1}_j ~ S_2 ~ S_3}^{\pi[i]} ~ \cdots ~ \overbrace{S_{i-3} ~ S_{i-2} ~ \underbrace{S_{i-1} ~ S_{i}}_j}^{\pi[i]} ~ S_{i+1}

如果我们找到了这样的长度 :math:`j` ，那么仅需要再次比较 :math:`S[i+1]` 和 :math:`S[j]` 。如果它们相等，那么就有 :math:`\pi[i + 1] = j + 1` ；否则，我们需要找到子串 :math:`S[0:i]` 中仅次于 :math:`j` 的第二长度 :math:`j^{(2)}` ，使得前缀性质得以保持，如此反复，直到 :math:`j=0` 。如果 :math:`S[i+1] \neq S[0]` ，则 :math:`\pi[i + 1] = 0` 。

观察上图可以发现，因为 :math:`S[0:\pi[i] - 1] = S[i- \pi[i] + 1: i]` ，所以对于 :math:`S[0:i]` 的第二长度 :math:`j` ，有这样的性质：

.. math::

    S[0:j - 1] = S[i - j + 1: i]= S[\pi[i] - j : \pi[i] - 1].

也就是说 :math:`j=\pi[\pi[i] - 1]` 。

显然我们可以得到一个关于 :math:`j` 的状态转移方程：

.. math::

    j^{(n)}=\pi[j^{(n-1)} - 1], \ j^{(n-1)} > 0.


所以最终我们可以构建一个不需要进行任何字符串比较，并且只进行 :math:`\mathcal{O}(n)` 次操作的算法。

.. code-block:: cpp
  :linenos:

  vector<int> prefixFunction(const string& s) 
  {
    int n = (int)s.length();
    vector<int> pi(n);
    for (int i = 1; i < n; i++)
    {
      int j = pi[i - 1];
      while (j > 0 && s[i] != s[j]) j = pi[j - 1];
      if (s[i] == s[j]) j++;
      pi[i] = j;
    }
    return pi;
  }

虽然上面代码中还有一个 while 循环，但是该过程的摊还代价是 :math:`\mathcal{O}(1)` ，当前面的 while 循环执行得比较长时，后续的 while 循环会更短。

这是一个 **在线** 算法，即当数据到达时处理它。举例来说，可以一个字符一个字符的读取字符串，立即处理它们以计算出每个字符的前缀函数值。该算法仍然需要存储字符串本身以及先前计算过的前缀函数值，但如果我们已经预先知道该字符串前缀函数的最大可能取值 :math:`M` ，那么我们仅需要存储该字符串的前 :math:`M+1` 个字符以及对应的前缀函数值（ :math:`+1` 表示存储前一个位置的前缀函数值 :math:`\pi[i - 1] = 0` ；while 循环中 :math:`\pi[j - 1] < M` ）。


查找子串：KMP 算法
----------------------

问题描述
^^^^^^^^^^^^^

给定一个文本 :math:`T` 和一个字符串 :math:`S` ，我们尝试找到并展示 :math:`S` 在 :math:`T` 中的所有出现位置（occurrence）。


KMP 算法
^^^^^^^^^^^^^^

设 :math:`S` 长度为 :math:`n` ， :math:`T` 长度为 :math:`m` 。

构造一个字符串 :math:`S\#T` ，长度为 :math:`m+n+1` ，其中 :math:`\#` 是一个既不出现在 :math:`S` 中也不出现在 :math:`T` 中的分隔符。接下来计算该字符串的前缀函数。现在考虑该前缀函数除去开头 :math:`n+1` 个值（即属于字符串 :math:`S` 和分隔符的函数值）后其余函数值的意义。根据定义，:math:`\pi[i]` 为右端点在 :math:`i` 处的前缀函数值，由于分隔符的存在，该长度不可能超过 :math:`n` 。而如果等式 :math:`\pi[i] = n` 成立，则意味着 :math:`S` 完整地出现在该位置（即 :math:`S` 右端点与位置 :math:`i` 对齐）。注意：该位置的下标 :math:`i` 是对字符串 :math:`S\#T` 而言的，
当 :math:`\pi[i] = n` 成立，则字符串 :math:`S` 在字符串 :math:`T` 的 :math:`i - (n + 1) - (n - 1) = i - 2n` 处出现。

正如在前缀函数的计算中已经提到的那样，如果我们知道前缀函数的值永远不超过一特定值，那么我们不需要存储整个字符串以及整个前缀函数，而只需要二者开头的一部分。由于 :math:`\pi[i] \leq n` ，这意味着只需要存储字符串 :math:`S\#` 以及相应的前缀函数值即可。我们可以一次读入字符串 :math:`T` 的一个字符并计算当前位置的前缀函数值。

因此 Knuth-Morris-Pratt 算法（简称 KMP 算法）用 :math:`\mathcal{O}(m+n)` 的时间以及 :math:`\mathcal{O}(n)` 的空间解决了该问题。

参考资料
-------------

1. 字符串基础

  https://oi-wiki.org/string/basic/

2. 前缀函数与 KMP 算法

  https://oi-wiki.org/string/kmp/#knuth-morris-pratt
