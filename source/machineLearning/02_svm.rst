支持向量机
================

样本空间中任意点到超平面的距离为：

.. math::

  r = \frac{|w^{\top} x + b|}{\| w \|}

原始问题：

.. math::

  \underset{w,b}{min} \  \frac{1}{2} \left \| w \right \|^2 \\
  s.t. \  y_i(w^{\top} x + b) \geqslant 1, i=1,2,...,m

拉格朗日函数：

.. math::

  L(w,b,\alpha) = \frac{1}{2}w^{\top}w + \sum_{i=1}^m \alpha_i(1 - y_i(w^{\top} x + b)),\\
  \underset{w,b}{min}(\underset{\alpha_i>0}{max}L(w,b,\alpha))

对偶问题：

.. math::

  \underset{\alpha_i>0}{max}(\underset{w,b}{min}L(w,b,\alpha))

即：

.. math::

  \underset{\alpha>0}{max} \sum_{i=1}^m\alpha_i - \frac{1}{2} \sum_{i=1}^m \sum_{j=1}^m \alpha_i \alpha_j y_i y_j x_i^{\top} x_j,\  w=\sum_{i=1}^m\alpha_i y_i x_i

KKT条件：

.. math::

  y_i(w^{\top} x + b) \geqslant 1, \\
  \sum_{i=1}^m \alpha_i y_i = 0,\\
  \alpha_i (1 - y_i(w^{\top} x + b)) = 0.

核函数
------------

核函数 :math:`\mathcal{K}`

  - 对称半正定。( :math:`\mathcal{K} \geqslant 0: \forall z,\  z^{\top}\mathcal{K}z \geqslant 0.` )

  - 主要使用线性核，高斯核（RBF）。

  - 当特征维度高且样本少，不宜使用高斯核，容易过拟合。

  - 当特征维度低，且样本够多，考虑使用高斯核。首先需要特征缩放（归一化）。若 :math:`\sigma` 过大，导致特征间差异变小，欠拟合。

多分类
--------

1. 一对一（ :math:`O(N^2)` ）

2. 一对多（ :math:`O(N)` ）

3. 使用多分类loss

SVM库
-----------

sklearn, libsvm


优缺点
-------

优点
  - 基于结构风险最小化，泛化能力强（自带正则化， :math:`\left \| w \right \|^2` ）。

  - 它是凸优化问题，可得到全局最优。

  - SVM在小样本训练集上可得到比其他方法好的结果。

  - 利用核函数，可借助线性可分问题的求解方法，直接求解对应高维空间的问题。

缺点
  - SVM对缺失特征敏感。

  - 如何确定核函数？

  - 求解问题的二次规划，耗时耗存储。

解析
------

1. 为什么要间隔最大化？

  最优超平面，解唯一，更加鲁棒。

2. 为什么转化为对偶问题？

  - 便于求解（交换 :math:`\alpha` 和 :math:`(w,b)` 位置之后，可直接对 :math:`(w,b)` 求导）。

  - 解的过程可以引入核函数。


SVM与LR的异同
-----------------

相同点：

  - 都是分类算法。

  - 不考虑核函数，分类面都是线性。

  - 都是监督学习算法。

  - 都是判别模型。（判别模型：KNN，SVM，LR；生成模型：HMM，朴素贝叶斯）

不同点：

  - 本质不同：loss function不同

  - SVM只有支持向量影响模型，LR中每个样本都有作用。

  - SVM针对线性不可分问题有核函数。

  - SVM依赖样本间的距离测度，样本特征需要归一化，也就是说SVM基于距离，LR基于概率。

  - SVM是结构风险最小化算法（在训练误差和模型复杂度之间的折中，防止过拟合，从而达到真实误差最小化）。因为SVM自带正则（ :math:`\left \| w \right \|^2` ）。

参考资料
--------------

1. LR与SVM的异同

  https://www.cnblogs.com/zhizhan/p/5038747.html

2. 核函数

  https://www.cnblogs.com/loujiayu/archive/2013/12/19/3481320.html

3. SVM面试题

  https://www.jianshu.com/p/fa02098bc220

4. SVM的优缺点

  https://blog.csdn.net/fengzhizizhizizhizi/article/details/23911699

5. 机器学习技法--SVM的对偶问题

  https://www.jianshu.com/p/de882f0fc434

6. 周志华《机器学习》Page 121 -- 124。
