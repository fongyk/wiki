主成分分析PCA
===================

**最大可分性** ：样本点到超平面的投影能尽可能分开（投影后样本点方差最大化）。

优化目标
--------------

.. math::

  \underset{W}{max} \ tr(W^TXX^TW) \\
  s.t. \ W^TW=I. \\
  X \in \mathbb{R}^{d \times m}, \\
  W \in \mathbb{R}^{d \times d^\prime}, \ d^\prime < d.

求解
---------

1. 计算样本的协方差矩阵 :math:`C = XX^T` ；

2. 对协方差矩阵做特征值分解（EVD）；

3. 取最大的 :math:`d^\prime` 个特征值 :math:`(\lambda_1, \lambda_2,...,\lambda_{d^\prime})` 对应的特征向量：

    .. math::

      W = (w_1, w_2,...,w_{d^\prime})

PCA白化
-----------

白化的目的是降低输入的冗余性：
  - 特征之间相关性降低
  - 所有特征具有相同的方差

.. math::

  x_{rot} = W^T x, \\
  x_{pca\ white, i} \ = \frac{x_{rot, i}}{\sqrt{\lambda_i}}

SVD分解
----------

.. math::

  A = U \Sigma V^T,\\
  A \in \mathbb{R}^{m \times n}, \\
  rank(A) = r,\\
  U \in \mathbb{R}^{m \times r}, \\
  \Sigma \in \mathbb{R}^{r \times r}, \\
  V \in \mathbb{R}^{n \times r}

其中 :math:`U` 是 :math:`AA^T` 的特征向量矩阵， :math:`V` 是 :math:`A^TA` 的特征向量矩阵。

当 :math:`d` 很大时， :math:`C=XX^T` 是很高维的矩阵，计算该矩阵并求特征向量开销大。此时对 :math:`X` 做SVD分解，得到 :math:`U` 便是
协方差矩阵 :math:`C` 的特征向量。

参考资料
-----------

1. 周志华《机器学习》Page 229 -- 232。


2. ufldl

  http://ufldl.stanford.edu/wiki/index.php/PCA
