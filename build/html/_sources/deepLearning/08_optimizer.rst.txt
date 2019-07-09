优化算法
==============


可视化
------------

**等高线**

.. image:: ./08_contours_evaluation_optimizers.gif
  :align: center
  :width: 500


**鞍点**

.. image:: ./08_saddle_point_evaluation_optimizers.gif
  :align: center
  :width: 600


SGD
-----------------

这里 **SGD** 指小批量梯度下降算法。

小批量损失：:math:`\mathcal{L}` ，学习率：:math:`\eta` ，Hadamard积：:math:`\odot` 。

.. math::

  g & \leftarrow &\ \nabla_{\theta} \mathcal{L} (\theta; x^{(i:i+n)}; y^{(i:i+n)}) &\  [\text{计算梯度}] \\
  \theta & \leftarrow &\  \theta - \eta g &\  [\text{参数更新}]

特点
  - 相比于单样本SGD，可以降低参数更新时的方差，收敛更稳定；可以充分地利用深度学习库中高度优化的矩阵操作来进行更有效的梯度计算

  - 不能保证很好的收敛性：如果选择的太小，收敛速度会很慢；如果太大，损失函数就会在极小值处不停地震荡甚至偏离；容易困在鞍点。鞍点：不是局部极值点的驻点（一阶梯度为零）。

  - 选择合适的学习率比较困难：对所有的参数更新使用同样的学习率。对于稀疏数据或者特征，有时我们可能想更快更新对应于不经常出现的特征的参数，对于常出现的特征更新慢一些。

Momentum
--------------

.. math::

  v & \leftarrow &\  \gamma v - \eta \nabla_{\theta} \mathcal{L}(\theta) &\  [\text{速度更新}] \\
  \theta & \leftarrow &\  \theta + v &\ [\text{参数更新}]

动量（momentum）方法旨在加速学习，特别是处理高曲率、小但一致的梯度，或是带噪声的梯度。动量算法积累了之前梯度指数级衰减的移动平均，并且沿该方向继续移动。
当许多连续的梯度指向相同的方向时，步长最大。

特点
 - 下降初期，使用上一次参数更新；下降方向一致，乘上较大的 :math:`\gamma` 能够进行很好的加速。

 - 下降中后期，在局部最小值来回震荡的时候，梯度接近0， :math:`\gamma` 能够使得更新幅度增大，跳出陷阱。

 - 梯度改变方向时，能够减少更新。


Adagrad
-------------

.. math::

  g & \leftarrow &\ \nabla_{\theta} \mathcal{L}(\theta) &\  [\text{计算梯度}] \\
  r & \leftarrow &\ r + g \odot g &\  [\text{累计平方梯度}] \\
  \Delta \theta & \leftarrow &\ - \frac{\eta}{\sqrt{r+\epsilon}} \odot g &\  [\text{梯度除以累计平方梯度的平方根}] \\
  \theta & \leftarrow &\  \theta + \Delta \theta &\ [\text{参数更新}]


特点
  - 独立地适应所有模型参数的学习率，适合处理稀疏数据。对于梯度 :math:`g` 较大的参数（这些参数关联着频繁出现的特征），有一个快速下降的学习率；
    对于梯度 :math:`g` 较小的参数（这些参数关联着不频繁出现的特征），学习率有相对较小的下降。

  - 从训练开始累积平方梯度，导致有效学习率过早和过量减小，导致训练过早停止。


Adadelta
--------------

.. math::

  g & \leftarrow &\ \nabla_{\theta} \mathcal{L}(\theta) &\  [\text{计算梯度}] \\
  E[g^2] & \leftarrow &\ \gamma E[g^2] + (1 - \gamma) g \odot g  &\  [\text{累计平方梯度：指数衰减平均}] \\
  RMS[g] & \leftarrow &\ \sqrt{E[g^2] + \epsilon} &\  [\text{梯度均方根}] \\
  E[\Delta \theta^2] & \leftarrow &\ \gamma E[\Delta \theta^2] + (1 - \gamma) \Delta \theta \odot \Delta \theta  &\  [\text{平方参数增量平滑}] \\
  RMS[\Delta \theta] & \leftarrow &\ \sqrt{E[\Delta \theta^2] + \epsilon} &\  [\text{参数增量均方根}] \\
  \Delta \theta & \leftarrow &\  - \frac{RMS[\Delta \theta]}{RMS[g]} \odot g  &\ [\text{参数增量}] \\
  \theta & \leftarrow &\  \theta + \Delta \theta &\ [\text{参数更新}]

Adadelta 是 Adagrad 的改进。

特点
  - 使用指数衰减平均值，使得能够在找到凸碗状结构后快速收敛。

  - 不用依赖于全局学习率，然而引入了新的超参：衰减系数 :math:`\gamma` 。

  - 训练初中期，加速效果很快。


RMSprop
-----------------

.. math::

  g & \leftarrow &\ \nabla_{\theta} \mathcal{L}(\theta) &\  [\text{计算梯度}] \\
  r & \leftarrow &\ \gamma r + (1 - \gamma) g \odot g &\  [\text{累计平方梯度：指数衰减平均}] \\
  \Delta \theta & \leftarrow &\  - \frac{\eta}{\sqrt{r+\epsilon}} \odot g &\ [\text{参数增量}] \\
  \theta & \leftarrow &\  \theta + \Delta \theta &\ [\text{参数更新}]


RMSprop 趋于 Adagrad 和 Adadelta 之间。

特点
  - 使用指数衰减平均值，使得能够在找到凸碗状结构后快速收敛。

  - 仍然依赖于全局学习率。


Adam
----------------

.. math::

  g & \leftarrow &\ \nabla_{\theta} \mathcal{L}(\theta) &\  [\text{计算梯度}] \\
  t & \leftarrow &\ t + 1 &\  [\text{迭代次数}] \\
  m & \leftarrow &\ \beta_1 m + (1 - \beta_1) g &\  [\text{有偏一阶矩}] \\
  n & \leftarrow &\ \beta_1 n + (1 - \beta_2) g \odot g &\  [\text{有偏二阶矩}] \\
  \hat{m} & \leftarrow &\ \frac{m}{1 - \beta_1^t} &\  [\text{修正一阶矩}] \\
  \hat{n} & \leftarrow &\ \frac{n}{1 - \beta_2^t} &\  [\text{修正二阶矩}] \\
  \Delta \theta & \leftarrow &\  - \eta \frac{\hat{m}}{\sqrt{\hat{n}+\epsilon}} \odot g &\ [\text{参数增量}] \\
  \theta & \leftarrow &\  \theta + \Delta \theta &\ [\text{参数更新}]

相当于 RMSprop + Momentum。

特点
  - 结合了 Adagrad 善于处理稀疏梯度（不同的参数计算不同的自适应学习率）和 RMSprop 善于处理非平稳目标的优点。

  - 经过矩修正后，每一次迭代的学习率都有确定范围，使得参数更新比较平稳。

参考资料
-----------

1. An overview of gradient descent optimization algorithms

  http://ruder.io/optimizing-gradient-descent/

2. 深度学习——优化器算法Optimizer详解

  https://cloud.tencent.com/developer/article/1118673

3. 深度学习——优化器算法Optimizer详解

  https://www.cnblogs.com/guoyaohua/p/8542554.html

4. An overview of gradient descent optimization algorithms

  https://arxiv.org/pdf/1609.04747.pdf
