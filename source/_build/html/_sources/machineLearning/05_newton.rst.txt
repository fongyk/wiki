牛顿方法
=============

牛顿方法（Newton's method, Newton-Raphson method）可以有效地近似实值函数的根。


一维
----------

.. math::

    x_{n+1} = \  x_n - \frac{f(x_n)}{f^{\prime}(x_n)}

.. image:: ./05_newton.gif
  :width: 420px
  :align: center


高维
------------

.. math::

    x_{n+1} & = & \  x_n - J^{-1} F(x_n). \\
    x & \in & \ \mathbb{R}^k,\\
    F & : & \ \mathbb{R}^k \rightarrow \mathbb{R}^k, \\
    J & \in & \ \mathbb{R}^{k \times k}, [\text{Jacobian matrix}] \\
    J_{ij} & = & \ \frac{\partial F_i}{\partial x_j}.  \\


由于求解 Jacobian matrix 的逆复杂度较高，因此可以通过求解以下等式来节省时间开销：

.. math::

    J \cdot (x_{n+1} - x_n) = -F(x_n).

收敛问题
------------------

- 初始点问题

  - 导数为0，出现除0操作

    .. math::

        f(x) & = &\  1 - x^2,\\
        x_0 & = &\  0, \\
        f^{\prime}(x_0) & = &\ 0.

  - 死循环

    .. math::

        f(x) & = &\  x^3 - 2x + 2,\\
        x_0 & = &\  0, \\
        x_1 & = &\  1, x_2 = 0, x_3 = 1, ... .

- 根的导数不存在或不连续

- 有时候收敛速度慢

应用
--------------

- 最大/最小化问题

  - 一维

    .. math::

        x_{n+1} = x_n - \frac{f^{\prime}(x_n)}{f^{\prime\prime}(x_n)}

  - 高维

    .. math::

        x_{n+1} & = &\ x_n - H^{-1} \nabla F(x_n),\\
        H_{ij} & = &\ \frac{\partial^2 F}{\partial x_i \ \partial x_j}. [\text{Hessian matrix}]


- 求倒数（reciprocal）

  .. math::

      f(x) & = &\  a - \frac{1}{x},\\
      x_{n+1} & = &\ x_n - \frac{f(x_n)}{f^{\prime}(x_n)} \\
       & = &\ x_n (2 - a x_n).

- 开根号（sqrt）

  .. math::

      f(x) & = &\  x^2 - a,\\
      x_{n+1} & = &\ x_n - \frac{f(x_n)}{f^{\prime}(x_n)} \\
      & = &\ x_n - \frac{x_n^2 - a}{2x_n}.

  .. code-block:: python
    :linenos:

    def Sqrt(a):
      x = a
      while abs(x*x - a) > 1e-3:
          x = x - (x*x - a) / float(2 * x)
      return x


参考资料
---------------

1. Wikipedia: Newton's method

  https://en.wikipedia.org/wiki/Newton%27s_method
