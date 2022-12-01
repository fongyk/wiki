算法复杂度与主定理
========================

递归算法的复杂性分析方法：代入法、递归树、主定理。这里只讨论主定理方法。

主定理方法应用于如下的递归形式：

.. math::

    T(n) = aT(\frac{n}{b}) + f(n).

其中，:math:`a \geqslant 1,\ b\geqslant 1` ，:math:`f` 是渐进正的。


渐进分析
---------------

假设对于所有 :math:`n` ，满足 :math:`f(n) \geqslant 0,\ g(n) \geqslant 0` 。

- 渐进上界 :math:`\mathcal{O}`

  .. math::

      \mathcal{O}(g(n)) = \{ f(n) | \text{存在正常数} c \text{和} n_0 \text{使得对所有} n \geqslant n_0 \text{有：} 0 \leqslant f(n) \leqslant cg(n) \}

- 渐进下界 :math:`\Omega`

  .. math::

      \Omega(g(n)) = \{ f(n) | \text{存在正常数} c \text{和} n_0 \text{使得对所有} n \geqslant n_0 \text{有：} 0 \leqslant cg(n) \leqslant f(n) \}


- 渐进近界 :math:`\Theta`

  .. math::

      \Theta(g(n)) = \{ f(n) | \text{存在正常数} c_1,\ c_2 \text{和} n_0 \text{使得对所有} n \geqslant n_0 \text{有：} c_1g(n) \leqslant f(n) \leqslant c_2g(n) \}

定理：

.. math::

      \Theta(g(n)) = \mathcal{O}(g(n)) \cap \Omega(g(n))


主定理
------------

需要比较 :math:`f(n)` 和 :math:`n^{\log_b a}` 。

- :math:`f(n) = \mathcal{O}(n^{\log_b a - \epsilon})` ： :math:`f(n)` 的增长速度比 :math:`n^{\log_b a}` 慢一个 :math:`n^{\epsilon}` 因子。

  .. math::

      T(n) = \Theta (n^{\log_b a})

- :math:`f(n) = \Theta (n^{\log_b a} \log^k n)` ： :math:`f(n)` 与 :math:`n^{\log_b a} \log^k n` 具有相似的增长速度。

  .. math::

      T(n) = \Theta (n^{\log_b a} \log^{k+1} n)

- :math:`f(n) = \Omega (n^{\log_b a + \epsilon})` ： :math:`f(n)` 的增长速度比 :math:`n^{\log_b a}` 快一个 :math:`n^{\epsilon}` 因子，且满足 :math:`af(\frac{n}{b}) \leqslant cf(n),\ 0 < c < 1` 。

  .. math::

      T(n) = \Theta (f(n))

例子：

.. math::

      T(n) = 4T(\frac{n}{2}) + n & \rightarrow &\ \epsilon = 1,\ T(n) = \Theta (n^2) \\
      T(n) = 4T(\frac{n}{2}) + n^2 & \rightarrow &\ k=0,\ T(n) = \Theta (n^2 \log n) \\
      T(n) = 4T(\frac{n}{2}) + n^3 & \rightarrow &\ \epsilon = 1,\ c=\frac{1}{2},\ T(n) = \Theta (n^3)
