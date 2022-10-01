球盒问题
===============

把 :math:`n` 个球放到 :math:`m` 个盒子中，总共有多少种放法？

根据球是否相同、盒是否相同、是否允许空盒，分 8 种情形讨论。


球同，盒不同，无空盒
-------------------------

插空法：:math:`n` 个球中间有 :math:`n-1` 个间隙，不能有空盒，所以在 :math:`n-1` 个间隙选出 :math:`m-1` 个间隙。

.. math::
  :nowrap:

  $$
  \begin{cases}
     C_{n-1}^{m-1} & & n \geqslant m \\
     0 & &  n < m
  \end{cases}

  $$


球同，盒不同，允许空盒
-------------------------

本问题等价于“把 :math:`n+m` 个相同的球放到 :math:`m` 个不同盒子中，且无空盒”，即先在每个盒子中放 1 个球。

因此，放法有：

.. math::

  C_{n+m-1}^{m-1}.


球不同，盒同，无空盒
-------------------------

设 :math:`dp[n][m]` 表示 :math:`n` 个球放到 :math:`m` 个盒子中且无空盒的放法。
如果前 :math:`n-1` 个球已经使用了 :math:`m` 个盒子中，则第 :math:`n` 个球可以放到任意一个盒子中（与任意一组球结合）；
如果前 :math:`n-1` 个球只使用了 :math:`m-1` 个盒子中，则第 :math:`n` 个球只能放到剩下的空盒子中。

.. math::

  dp[n][m] &=&\ m \times dp[n-1][m] + dp[n-1][m-1],\quad 1 \leqslant m \leqslant n. \\
  dp[k][k] &=&\ 1,\quad k \geqslant 0. \\
  dp[k][0] &=&\ 0,\quad k \geqslant 1. \\
  dp[0][k] &=&\ 1,\quad k \geqslant 0.



球不同，盒同，允许空盒
-------------------------

设 :math:`dp[n][m]` 表示 :math:`n` 个球放到 :math:`m` 个盒子中且无空盒的放法，递推公式如上。

可以枚举空盒的个数，则放法有：

.. math::

  \sum_{k=1}^m dp[n][k].


球不同，盒不同，无空盒
-------------------------

设 :math:`dp[n][m]` 表示 :math:`n` 个球放到 :math:`m` 个盒子中且无空盒的放法，递推公式如上。

需要考虑盒子的排列，则放法有：

.. math::

  dp[n][m] \times m!.



球不同，盒不同，允许空盒
-------------------------

每个球都有 :math:`m` 种选择，放法有：

.. math::

  m^n.



球同，盒同，允许空盒
-------------------------

设 :math:`dp[n][m]` 表示 :math:`n` 个球至多使用 :math:`m` 个盒子（即允许空盒）的放法，可以分为两种情况：一，无空盒， :math:`dp[n-m][m]` ，即每个盒子先放 1 个球；
二，至多使用 :math:`m-1` 个盒子， :math:`dp[n][m-1]` 。递推公式如下：

.. math::

  dp[n][m] &=&\ dp[n][m-1] + dp[n-m][m],\quad 1 \leqslant m \leqslant n. \\
  dp[n][m] &=&\ dp[n][n],\quad m \geqslant n. \\
  dp[k][0] &=&\ 0,\quad k \geqslant 1. \\
  dp[0][k] &=&\ 1,\quad k \geqslant 0. \\
  dp[1][k] &=&\ 1,\quad k \geqslant 1. \\
  dp[k][1] &=&\ 1,\quad k \geqslant 0.


球同，盒同，无空盒
-------------------------

设 :math:`dp[n][m]` 表示 :math:`n` 个球至多使用 :math:`m` 个盒子（即允许空盒）的放法，递推公式如上。

先在每个盒子先放 1 个球，则无空盒的放法有：

.. math::
  :nowrap:

  $$
  \begin{cases}
     dp[n-m][m] & & n \geqslant m \\
     0 & &  n < m
  \end{cases}

  $$


参考资料
--------------

1. 排列组合 "n个球放入m个盒子m"问题 总结

  https://blog.csdn.net/qwb492859377/article/details/50654627?tdsourcetag=s_pctim_aiomsg
