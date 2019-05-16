反向传播
===============

.. image:: ./07_backprop.jpg
    :width: 700px
    :align: center

.. table:: 符号说明
  :align: center

  ===============================   ===================================================================================================
             符号                           含义
  ===============================   ===================================================================================================
   :math:`n`                           网络层数
   :math:`C_l`                         第 :math:`l` 层神经元个数（不包括偏置）
   :math:`g(x)`                        激活函数
   :math:`w^{(l)}_{ji}`                第 :math:`l` 层第 :math:`i` 个神经元与第 :math:`l+1` 层第 :math:`j` 个神经元的连接权重
   :math:`b^{(l)}_i`                   第 :math:`l+1` 层第 :math:`i` 个神经元的偏置
   :math:`z^{(l)}_i`                   第 :math:`l` 层第 :math:`i` 个神经元的输入
   :math:`a^{(l)}_i`                   第 :math:`l` 层第 :math:`i` 个神经元的激活值
   :math:`\delta^{(l)}_i`              第 :math:`l` 层第 :math:`i` 个神经元的误差（error）
   :math:`y_j`                         标签第 :math:`j` 维（第 :math:`j` 类）
   :math:`\mathcal{L}_{w,b}(x)`        损失函数，简称 :math:`\mathcal{L}`
   :math:`x`                           训练样本
   :math:`m`                           小批量训练样本个数
  ===============================   ===================================================================================================


前向传播
---------------

.. math::

  z^{(l+1)}_i & = & \  b^{(l)}_i + \sum_{j=1}^{C_l}w^{(l)}_{ij}a^{(l)}_j, \\
  g(t) & = & \  \frac{1}{1 + e^{-t}}, \\
  g^{\prime}(t) & = & \ (1 - g(t))g(t) , \\
  a^{(l)}_i & = & \  g(z^{(l)}_i).

**误差** 定义为：

.. math::

  \delta^{(l)}_i = \  \frac{\partial{\mathcal{L}}}{\partial{z^{(l)}_i}}


误差反向传播
-------------------

**MSE** （Mean Squared Error）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

对每一个样本，损失为：

.. math::

  \mathcal{L} = \frac{1}{2} \sum_{j=1}^{C_n}(y_j - a^{(n)}_j)^2.

最后一层的误差：

.. math::

  \delta^{(n)}_i & = & \  \frac{\partial{\mathcal{L}}}{\partial{z^{(n)}_i}} \\
                 & = & \  \frac{1}{2} \frac{\partial{\bigg [ \sum_{j=1}^{C_n}(y_j - a^{(n)}_j)^2 \bigg ]}}{\partial{z^{(n)}_i}} \\
                 & = & \  \frac{1}{2} \frac{\partial{\bigg [ (y_i - g(z^{(n)}_i))^2 \bigg ]}}{\partial{z^{(n)}_i}} \\
                 & = & \  - (y_i - g(z^{(n)}_i)) g^{\prime}(z^{(n)}_i)

递推前层误差：

.. math::

  \delta^{(l)}_i & = & \  \frac{\partial{\mathcal{L}}}{\partial{z^{(l)}_i}} \\
                  & = & \  \sum_{j=1}^{C_{l+1}} \frac{\partial{\mathcal{L}}}{\partial{z^{(l+1)}_j}} \frac{\partial{z^{(l+1)}_j}}{\partial{a^{(l)}_i}} \frac{\partial{a^{(l)}_i}}{\partial{z^{(l)}_i}} \\
                  & = & \  \sum_{j=1}^{C_{l+1}} \frac{\partial{\mathcal{L}}}{\partial{z^{(l+1)}_j}} \frac{\partial{\left ( b^{(l)}_i + \sum_{k=1}^{C_l}w^{(l)}_{jk}a^{(l)}_k \right )}}{\partial{a^{(l)}_i}} \frac{\partial{a^{(l)}_i}}{\partial{z^{(l)}_i}} \\
                  & = & \  \sum_{j=1}^{C_{l+1}} \delta^{(l+1)}_j w_{ji}^{(l)} g^{\prime}(z^{(l)}_i) \\
                  & = & \  g^{\prime}(z^{(l)}_i) \sum_{j=1}^{C_{l+1}} \delta^{(l+1)}_j w_{ji}^{(l)}


权重和偏置的梯度：

.. math::

  \frac{\partial{\mathcal{L}}}{\partial{w_{ij}^{(l)}}} & = & \  \frac{\partial{\mathcal{L}}}{\partial{z^{(l+1)}_i}} \frac{\partial{z^{(l+1)}_i}}{\partial{w_{ij}^{(l)}}} \\
                                                     & = & \  \delta^{(l+1)}_i \frac{\partial{z^{(l+1)}_i}}{\partial{w_{ij}^{(l)}}} \\
                                                     & = & \  \delta^{(l+1)}_i \frac{\partial{\left ( b^{(l)}_i + \sum_{k=1}^{C_l}w^{(l)}_{ik}a^{(l)}_k \right )}}{\partial{w_{ij}^{(l)}}} \\
                                                     & = & \  \delta^{(l+1)}_i a^{(l)}_j \\
  \frac{\partial{\mathcal{L}}}{\partial{b_i^{(l)}}} & = & \  \delta^{(l+1)}_i


梯度下降
  - 权重更新

    .. math::

      w_{ij}^{(l)} \leftarrow w_{ij}^{(l)} - \alpha \times \frac{1}{m} \sum_x \frac{\partial{\mathcal{L}}}{\partial{w_{ij}^{(l)}}} = w_{ij}^{(l)} - \frac{\alpha}{m} \sum_x \delta^{(l+1)}_i a^{(l)}_j


  - 偏置更新

    .. math::
      b_i^{(l)}  \leftarrow b_i^{(l)} - \alpha \times \frac{1}{m} \sum_x \frac{\partial{\mathcal{L}}}{\partial{b_i^{(l)}}} = b_i^{(l)} - \frac{\alpha}{m} \sum_x \delta^{(l+1)}_i


**Cross Entropy** （交叉熵）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

损失函数为：

.. math::

  \mathcal{L} = - \sum_{j=1}^{C_n} y_j \ln \hat{y}_j, \\
  y_j \in \{ 0,1 \}, \\
  \hat{y}_j = softmax(\mathbb{a}^{(n)}, j) = \frac{e^{a^{(n)}_j}}{\sum_{k=1}^{C_n} e^{a^{(n)}_k}}.

softmax偏导为：

.. math::
  :nowrap:

  $$
  \frac{\partial{\hat{y}_j}}{\partial{a^{(n)}_i}} =
  \begin{cases}
     - \hat{y}_j \hat{y}_i & & i \ne j \\
     \hat{y}_i (1 - \hat{y}_i) & &  i = j
  \end{cases}
  $$


另外，由链式法则（chain rule）：

.. math::

  \frac{\partial{\mathcal{L}}}{\partial{z^{(n)}_i}} & = & \  \frac{\partial{\mathcal{L}}}{\partial{a^{(n)}_i}} \frac{\partial{a^{(n)}_i}}{\partial{z^{(n)}_i}} \\
  \frac{\partial{\mathcal{L}}}{\partial{a^{(n)}_i}} & = & \  \sum_{j=1}^{C_n} \frac{\partial{\mathcal{L}}}{\partial{\hat{y}_j}} \frac{\partial{\hat{y}_j}}{\partial{a^{(n)}_i}} \\
  \frac{\partial{\mathcal{L}}}{\partial{\hat{y}_j}} & = & \  - \frac{y_j}{\hat{y}_j}

可推得：

.. math::

  \frac{\partial{\mathcal{L}}}{\partial{a^{(n)}_i}} & = & \  \sum_{j=1}^{C_n} \frac{\partial{\mathcal{L}}}{\partial{\hat{y}_j}} \frac{\partial{\hat{y}_j}}{\partial{a^{(n)}_i}} \\
                                                    & = & \  \frac{\partial{\mathcal{L}}}{\partial{\hat{y}_i}} \frac{\partial{\hat{y}_i}}{\partial{a^{(n)}_i}} + \sum_{j \ne i}^{C_n} \frac{\partial{\mathcal{L}}}{\partial{\hat{y}_j}} \frac{\partial{\hat{y}_j}}{\partial{a^{(n)}_i}} \\
                                                    & = & \  - \frac{y_i}{\hat{y}_i} \times \hat{y}_i (1 - \hat{y}_i) + \sum_{j \ne i}^{C_n} - \frac{y_j}{\hat{y}_j} \times \left ( - \hat{y}_j \hat{y}_i \right) \\
                                                    & = & \  - y_i \times (1 - \hat{y}_i) + \sum_{j \ne i}^{C_n}  y_j \times \hat{y}_i \\
                                                    & = & \  - y_i + \sum_{j=1}^{C_n}  y_j \times \hat{y}_i \\
                                                    & = & \  - y_i + \hat{y}_i


最后一层的误差：

.. math::

  \delta^{(n)}_i & = & \ \frac{\partial{\mathcal{L}}}{\partial{z^{(n)}_i}} \\
                 & = & \ \frac{\partial{\mathcal{L}}}{\partial{a^{(n)}_i}} \frac{\partial{a^{(n)}_i}}{\partial{z^{(n)}_i}} \\
                 & = & \ (- y_i + \hat{y}_i) g^{\prime}(z^{(n)}_i)


参考资料
-------------

1. 反向传播公式推导

  https://www.cnblogs.com/nowgood/p/backprop2.html#_nav_0

2. 神经网络--反向传播详细推导过程

  https://blog.csdn.net/qq_29762941/article/details/80343185
