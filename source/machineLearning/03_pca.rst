主成分分析
=================

**PCA** : Principal Component Analysis.

**最大可分性** ：所有样本点到超平面的投影能尽可能分开（投影后样本点方差最大化）。

PCA 是一种正交线性变换，把数据变换到一个新的坐标系统中，把相关变量变换为不相关变量。


.. image:: ./03_pca.png
  :align: center
  :width: 500 px


优化目标
--------------

样本点到超平面的投影为 :math:`W^{\top}X` ，假设 :math:`X` 已经中心化。

.. math::

  \underset{W}{\mathrm{max}} & \ Tr(W^{\top}XX^{\top}W) \\
  s.t. & \ W^{\top}W=I. \\
  & \ X \in \mathbb{R}^{d \times m}, \\
  & \ W \in \mathbb{R}^{d \times d^\prime}, \\
  & \ d^\prime < d.

推导
---------

利用拉格朗日乘子法，

.. math::

  L = - Tr(W^{\top}XX^{\top}W) + \lambda (W^{\top}W - I),\quad \lambda \neq 0.

令 :math:`L` 对 :math:`W` 和 :math:`\lambda` 的偏导为 0 得：

.. math::

    XX^{\top}W &=\ \lambda W, \\
    W^{\top}W &=\ I.

对协方差矩阵 :math:`XX^{\top}` 进行特征值分解即可。

如何选择 :math:`d^\prime` 个特征向量？
  :math:`X` 经过 :math:`w_j` 投影后的方差为 :math:`w_j^{\top} X X^{\top} w_j = \lambda_j w_j^{\top} w_j = \lambda_j` ，
  即 :math:`XX^{\top}` 的第 :math:`j` 个特征值对应了样本投影后的第 :math:`j` 个属性的方差。本着方差最大化的原则，
  选取最大的 :math:`d^\prime` 个特征值对应的特征向量。


求解
---------

1. 样本中心化： :math:`X` 减均值。

2. 计算样本的协方差矩阵 :math:`C = XX^{\top}` ；

3. 对协方差矩阵做特征值分解（EVD）；

4. 取最大的 :math:`d^\prime` 个特征值 :math:`(\lambda_1, \lambda_2,...,\lambda_{d^\prime})` 对应的特征向量：

    .. math::

      W = (w_1, w_2,...,w_{d^\prime})

PCA-Whitening
-------------------

白化（Whitening）的目的是降低输入的冗余性：

- 特征之间相关性降低

- 所有特征具有相同的方差

.. math::

  x_{rot} &=\  W^{\top} x, \\
  x_{pca\ white, i} &=\  \frac{x_{rot, i}}{\sqrt{\lambda_i}}

SVD分解
----------

.. math::

  A &=\ U \Sigma V^{\top},\\
  A & \in \mathbb{R}^{m \times n}, \\
  r &=\ rank(A),\\
  U & \in \mathbb{R}^{m \times r}, \\
  \Sigma & \in \mathbb{R}^{r \times r}, \\
  V & \in \mathbb{R}^{n \times r}.

其中 :math:`U` 是 :math:`AA^{\top}` 的特征向量矩阵， :math:`V` 是 :math:`A^{\top}A` 的特征向量矩阵。

当 :math:`d` 很大时， :math:`C=XX^{\top}` 是很高维的矩阵，计算该矩阵并求特征向量开销大。此时对 :math:`X` 做SVD分解，得到 :math:`U` 便是
协方差矩阵 :math:`C` 的特征向量。

参考资料
-----------

1. 周志华《机器学习》Page 229 -- 232。

2. ufldl

  http://ufldl.stanford.edu/wiki/index.php/PCA

3. 约束优化方法之拉格朗日乘子法与KKT条件

  https://www.cnblogs.com/ooon/p/5721119.html

4. 关于拉格朗日乘子法及KKT条件的探究

  https://wenku.baidu.com/view/48af72d6fc4ffe473268ab8b.html
