裴蜀定理
============

在数论中，裴蜀定理（裴蜀等式/贝祖定理）是一个关于最大公约数的定理。

对任何整数 :math:`a` 、:math:`b` 和 :math:`m` ，关于未知数 :math:`x` 和 :math:`y` 的不定方程（解只能是整数）：

.. math::

    ax + by = m

有整数解当且仅当 :math:`m` 是 :math:`a` 和 :math:`b` 的最大公约数的倍数。

裴蜀等式有解时必然有无穷多个整数解，每组解 :math:`x` 和 :math:`y` 都称为裴蜀数，可用 `扩展欧几里得算法 <https://oi-wiki.org/math/number-theory/gcd/#%E6%89%A9%E5%B1%95%E6%AC%A7%E5%87%A0%E9%87%8C%E5%BE%97%E7%AE%97%E6%B3%95>`_ 求得。

裴蜀等式也可以用来给最大公约数定义：最小的可以写成 :math:`ax + by` 形式的正整数。

特别地，方程 :math:`ax + by = 1` 有解当且仅当 :math:`a` 和 :math:`b` 互质（最大公约数是 1）。


最大公约数
-----------------

设 :math:`a \geq b` 且均为正整数，其最大公约数（Greatest Common Divisor）性质如下：

- :math:`\gcd(a, b) = \gcd(b, a)`
- :math:`\gcd(a, b) = \gcd(a\%b, b)`
- :math:`\gcd(a, b) = \gcd(a-b, b)`
- 当 :math:`a` 和 :math:`b` 都是偶数时，:math:`\gcd(a, b) = 2 \times \gcd(a/2, b/2)`
- 当 :math:`a` 是偶数、 :math:`b` 是奇数时，:math:`\gcd(a, b) = \gcd(a/2, b)`
- 当 :math:`a` 是奇数、 :math:`b` 是偶数时，:math:`\gcd(a, b) = \gcd(a, b/2)`

辗转相除法《几何原本》
^^^^^^^^^^^^^^^^^^^^^^^^^

取模运算比较耗时。

.. code-block:: cpp
    :linenos:

    int gcd(int a, int b)
    {
        if (a < b) swap(a, b);
        int r;
        while (r = a % b)
        {
            a = b;
            b = r;
        }
        return b;
    }


更相减损术 《九章算术》
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

当两个数相差较大时，递归比较深。

.. code-block:: cpp
    :linenos:

    int gcd(int a, int b)
    {
        if(a == b) return a;
        if(a > b) return gcd(a-b, b);
        else return gcd(a, b-a);
    }


Binary GCD Algorithm
^^^^^^^^^^^^^^^^^^^^^^^^^

使用移位运算和减法代替除法。

.. code-block:: cpp
    :linenos:

    int gcd(int a, int b)
    {
        if(a == b) return a;
        if(!(a&1) && !(b&1)) return 2 * gcd(a>>1, b>>1);
        else if(!(a&1)) return gcd(a>>1, b);
        else if(!(b&1)) return gcd(a, b>>1);
        else return a > b? gcd(a-b, b): gcd(a, b-a);
    }


最小公倍数
------------------

最小公倍数（Least Common Multiple）是能同时被给定的多个整数整除的最小正整数。

最小公倍数和最大公约数满足：

.. math::

    \gcd(a,b) \times \mathrm{lcm}(a,b) = | a \times b|


.. tip::

    Python 库函数： ``math.gcd`` ``math.lcm``

    C++ 库函数： ``std::gcd`` ``std::lcm`` （C++ 17 标准，头文件 ``<numeric>`` ）

质因数分解
---------------

.. code-block:: python
      :linenos:

      ## 不断除以 2 之后，2 的倍数都不可能再整除 n；3,5,7,... 同理。
      ## 思想类似于：找到 n 以内的素数，即把素数的倍数都排除。
      def decomp(n):
          ans = []
          prime = 2
          while n >= prime:
              if n % prime == 0:
                  ans.append(prime)
                  n /= prime
              else:
                  prime += 1
        return ans

水壶问题
-------------

https://leetcode.com/problems/water-and-jug-problem

判断用两个水壶能否量出指定体积的水。


.. code-block:: python
    :linenos:

    import math
    class Solution:
        def canMeasureWater(self, jug1Capacity: int, jug2Capacity: int, targetCapacity: int) -> bool:
            if jug1Capacity + jug2Capacity < targetCapacity:
                return False
            if jug1Capacity == 0 or jug2Capacity == 0:
                return targetCapacity in [0, jug1Capacity + jug2Capacity]
            return targetCapacity % math.gcd(jug1Capacity, jug2Capacity) == 0
            


参考资料
-------------

1. 裴蜀定理

  https://zh.wikipedia.org/wiki/%E8%B2%9D%E7%A5%96%E7%AD%89%E5%BC%8F

2. 最大公约数

  https://oi-wiki.org/math/number-theory/gcd/

3. Greatest common divisor

  https://en.wikipedia.org/wiki/Greatest_common_divisor