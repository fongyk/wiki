Deep Metric Learning
=========================

介绍一些 Deep Metric Learning （深度度量学习）的损失函数和训练样本对挖掘方法。

损失函数
-----------------------

以下损失函数中的 :math:`x` 表示 embedding。

Softmax Loss
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. math::

    \mathcal{L}(x_i) = - \log \left( \frac{e^{w^{\top}_{y_i} x_i + b_{y_i}}}{\sum_j e^{w^{\top}_j x_i + b_j}} \right)


Center Loss
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`A Discriminative Feature Learning Approach for Deep Face Recognition <https://kpzhang93.github.io/papers/eccv2016.pdf>`_

减小类内差异，每个类别在特征空间分别维护一个类中心。


.. math::

    \mathcal{L}(x_i) \ & = &\  \frac{1}{2} \| x_i - c_{y_i} \|_2^2 \\
    \Delta c_j \ & = &\  \frac{\sum_{i=1}^{m} \delta(y_i=j) \cdot (c_j - x_i)}{1 + \sum_{i=1}^{m} \delta(y_i=j)}

:math:`m` 是一个 batch 的大小。


Large Margin Softmax Loss
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`Large-Margin Softmax Loss for Convolutional Neural Networks <https://arxiv.org/pdf/1612.02295.pdf>`_

减小类内差异，增大类间差异。

.. math::

    w_j^{\top} x_i = \| w_j \| \| x_i \| \cos(\theta_j)

.. math::

    \mathcal{L}(x_i) = - \log \left( \frac{e^{\| w_{y_i} \| \| x_i \| \psi(\theta_{y_i}) }}{e^{\| w_{y_i} \| \| x_i \| \psi(\theta_{y_i}) } + \sum_{j \neq y_i} e^{\| w_j \| \| x_i \| \cos(\theta_j) }} \right)

.. math::
  :nowrap:

  $$
  \psi(\theta) =
  \begin{cases}
     \cos (m \theta) & & 0 \leq \theta \leq \frac{\pi}{m} \\
     D(\theta) & &  \frac{\pi}{m} < \theta \leq \pi
  \end{cases}
  $$

:math:`m` 表示 margin，:math:`D(\theta)` 是一个单调减函数，且 :math:`D(\frac{\pi}{m})=\cos(\frac{\pi}{m})` 。

SphereFace Loss
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`SphereFace: Deep Hypersphere Embedding for Face Recognition <https://arxiv.org/pdf/1704.08063.pdf>`_

在 Large Margin Softmax Loss 的基础上，令 :math:`\| w \| = 1` 。

.. math::

    w_j^{\top} x_i = \| w_j \| \| x_i \| \cos(\theta_j) = \| x_i \| \cos(\theta_j)

.. math::

    \mathcal{L}(x_i) = - \log \left( \frac{e^{\| x_i \| \cos(m \theta_{y_i}) }}{e^{\| x_i \| \cos(m \theta_{y_i}) } + \sum_{j \neq y_i} e^{\| x_i \| \cos(\theta_j) }} \right)


CosFace Loss
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`CosFace: Large Margin Cosine Loss for Deep Face Recognition <https://arxiv.org/pdf/1801.09414.pdf>`_

在余弦空间中最大化分类界限。

.. math::

    w_j^{\top} x_i = \| w_j \| \| x_i \| \cos(\theta_j) = \| x_i \| \cos(\theta_j) = s \cos(\theta_j)

.. math::

    \mathcal{L}(x_i) = - \log \left( \frac{e^{s(\cos(\theta_{y_i}) - m)}}{e^{s(\cos(\theta_{y_i}) - m)} + \sum_{j \neq y_i} e^{s \cos(\theta_j)}} \right)

:math:`m` 表示 margin，:math:`s` 表示超球面的半径。


ArcFace Loss
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`ArcFace: Additive Angular Margin Loss for Deep Face Recognition <https://arxiv.org/pdf/1801.07698.pdf>`_

在角度空间中最大化分类界限。

.. math::

    w_j^{\top} x_i = \| w_j \| \| x_i \| \cos(\theta_j) = \| x_i \| \cos(\theta_j) = s \cos(\theta_j)

.. math::

    \mathcal{L}(x_i) = - \log \left( \frac{e^{s(\cos(\theta_{y_i} + m))}}{e^{s(\cos(\theta_{y_i} + m))} + \sum_{j \neq y_i} e^{s \cos(\theta_j)}} \right)

:math:`m` 表示 margin，:math:`s` 表示超球面的半径。


Contrastive Loss
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`Dimensionality Reduction by Learning an Invariant Mapping <http://yann.lecun.com/exdb/publis/pdf/hadsell-chopra-lecun-06.pdf>`_

.. math::

    \mathcal{L}(x_i, x_j) = \mathbf{1} (y_i = y_j) \| x_i - x_j \|_2^2 + \mathbf{1} (y_i \neq y_j) max(0, m - \| x_i - x_j \|_2)^2


Triplet Loss
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`Distance Metric Learning for Large Margin Nearest Neighbor Classification <https://papers.nips.cc/paper/2795-distance-metric-learning-for-large-margin-nearest-neighbor-classification.pdf>`_

.. math::

    \mathcal{L}(x_a, x_p, x_n) = max(0, m + \| x_a - x_p \|_2^2 - \| x_a - x_n \|_2^2)

Margin Loss
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`Sampling Matters in Deep Embedding Learning <https://arxiv.org/pdf/1706.07567.pdf>`_

.. math::

    \mathcal{L}(x_i, x_j) = max(0, \alpha + y_{ij} (D_{i,j} - \beta))

:math:`y_{ij} \in \{ -1, 1 \}`，:math:`D_{ij}` 表示距离，:math:`\beta` 是可学习的参数。


Tuplet Margin Loss
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`Deep Metric Learning with Tuplet Margin Loss <http://openaccess.thecvf.com/content_ICCV_2019/papers/Yu_Deep_Metric_Learning_With_Tuplet_Margin_Loss_ICCV_2019_paper.pdf>`_

每个 batch 包含 :math:`k` 个类别，每个类别 :math:`n` 个样本，从其他的 :math:`k-1` 个类别中随机选取一个样本作为负例，可以组成 :math:`kn(n-1)` 个三元组。

.. math::

    \mathcal{L}(x_a, x_p) = \log \left( 1 + \sum_{i=1}^{k-1} e^{s \left( \cos(\theta_{an_i}) - \cos(\theta_{ap} - \beta) \right)} \right)

:math:`s` 是一个缩放因子。 


Angular Loss
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`Deep Metric Learning with Angular Loss <https://arxiv.org/pdf/1708.01682.pdf>`_

以三元组的角度为优化目标，最小化负样本对应的 :math:`\angle n` 。相比于 Triplet Loss 的优势：角度具有缩放不变性；角度的计算过程可以利用到三条边；角度的阈值比 Triplet Loss 的 margin 具有更明确的物理意义。

.. math::

    \mathcal{L}(\mathcal{B}) = \frac{1}{N} \sum_{x_a \in \mathcal{B}} \log \left( 1 + \sum_{x_n \in \mathcal{B}} e^{f_{a,p,n}} \right)

.. math::

    f_{a,p,n} = 4 \tan^2 \alpha (x_a + x_p)^{\top} x_n - 2 (1 + \tan^2 \alpha) x_a^{\top} x_p

:math:`\mathcal{B}` 表示一个 batch 的样本集合，:math:`N` 是 batch 的大小，:math:`\alpha` 是角度阈值。

N-pair Loss
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`Improved Deep Metric Learning with Multi-class N-pair Loss Objective <http://www.nec-labs.com/uploads/images/Department-Images/MediaAnalytics/papers/nips16_npairmetriclearning.pdf>`_

利用一个 batch 内的所有负例。

.. math::

    \mathcal{L}(x_i, x_i^+) = \log \left( 1 + \sum_{j \neq i} e^{x_i^{\top} x_j^+ - x_i^{\top} x_i^+} \right)


Lifted Structure Loss
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`Deep Metric Learning via Lifted Structured Feature Embedding <https://arxiv.org/pdf/1511.06452.pdf>`_

利用一个 batch 内的所有正负样本对。

.. math::

    \mathcal{L} = \frac{1}{2 | \mathcal{P} |} \sum_{(i,j) \in \mathcal{P}} max(0, \mathcal{L}_{i,j})^2 

.. math::

    \mathcal{L}_{i,j} = max \left( \underset{(i,k) \in \mathcal{N}}{max}(\alpha - D_{i,k}), \underset{(j,l) \in \mathcal{N}}{max}(\alpha - D_{j,l}) \right) + D_{i,j}

:math:`\mathcal{P}` 表示正样本对，:math:`\mathcal{N}` 表示负样本对，:math:`D_{i,j}` 表示样本对的距离，:math:`\alpha` 表示 margin。

NCA Loss
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`Neighbourhood Components Analysis <https://www.cs.toronto.edu/~hinton/absps/nca.pdf>`_

.. math::

    \mathcal{L}(x, y, \mathcal{Z}) = - \log \left( \frac{e^{-d(x, y)}}{\sum_{z \in \mathcal{Z}} e^{-d(x,z)}} \right)

:math:`d` 是距离函数，:math:`y` 是正例，:math:`\mathcal{Z}` 是负例集合。

Proxy NCA Loss
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`No Fuss Distance Metric Learning using Proxies <https://arxiv.org/pdf/1703.07464.pdf>`_

每一个类别都有一个可学习的 proxy，用来近似真实的数据点。:math:`x` 对应的正例为本类别的 proxy :math:`p(y)`，负例为所有其他类别的 proxy :math:`p(\mathcal{Z})` 。

.. math::

    \mathcal{L}(x) = - \log \left( \frac{e^{-d(x, p(y))}}{\sum_{p(z) \in p(\mathcal{Z})} e^{-d(x,p(z))}} \right)


Proxy Anchor Loss
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`Proxy Anchor Loss for Deep Metric Learning <https://arxiv.org/pdf/2003.13911.pdf>`_

为每一个类别赋予了一个 proxy，将一个 batch 的样本和所有的 proxy 之间求距离，拉近每个类别的样本和该类别对应的 proxy 之间的距离，拉远与其他类别的 proxy 之间的距离。相比于 Proxy NCA Loss，更加充分地利用了 batch 的数据。

.. math::

    \mathcal{L}(\mathcal{X}) = \frac{1}{| \mathcal{P}^+ |} \sum_{p \in \mathcal{P}^+} \log \left( 1 + \sum_{x \in \mathcal{X}_p^+} e^{-\alpha (s(x,p) - \delta)} \right) + \frac{1}{| \mathcal{P} |} \sum_{p \in \mathcal{P}} \log \left( 1 + \sum_{x \in \mathcal{X}_p^-} e^{\alpha (s(x,p) + \delta)} \right)

:math:`\mathcal{X}` 表示一个 batch 内所有样本的 embedding 集合；:math:`\mathcal{P}^+` 表示正例 proxy 的集合，也就是 batch 内的样本对应的 proxy 的集合；:math:`\mathcal{P}` 表示所有 proxy 的集合，也就是所有类别对应的 proxy 的集合；:math:`\mathcal{X}_p^+` 表示与 :math:`p` 同一类别的 embedding 集合，:math:`\mathcal{X}_p^- = \mathcal{X} - \mathcal{X}_p^+` ；:math:`s` 表示余弦相似度。


SoftTriple Loss
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`SoftTriple Loss: Deep Metric Learning Without Triplet Sampling <http://openaccess.thecvf.com/content_ICCV_2019/papers/Qian_SoftTriple_Loss_Deep_Metric_Learning_Without_Triplet_Sampling_ICCV_2019_paper.pdf>`_

考虑到同类数据的多样性，为每类数据学习 :math:`K` 个类中心；通过正则项自适应地合并相似的类中心。

.. math::

    S_{i, c} = \sum_{k=1}^K \frac{e^{\frac{1}{\gamma}x_i^{\top}w_c^k}}{\sum_{t=1}^K e^{\frac{1}{\gamma}x_i^{\top}w_c^t}} x_i^{\top}w_c^k 

.. math::

    \mathcal{L}(x_i) = - \log \frac{e^{\lambda (S_{i, y_i} - \delta )}}{e^{\lambda (S_{i, y_i} - \delta )} + \sum_{j \neq y_i} e^{\lambda S_{i, j}}}

Multi-Similarity loss
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`Multi-Similarity Loss with General Pair Weighting for Deep Metric Learning <http://openaccess.thecvf.com/content_CVPR_2019/papers/Wang_Multi-Similarity_Loss_With_General_Pair_Weighting_for_Deep_Metric_Learning_CVPR_2019_paper.pdf>`_

为给每一个样本对动态赋予一个权重，这个权重是体现在梯度上的。给样本赋权的核心在于判断样本的局部分布，即它们之间的相似性。局部样本之间的分布和相互关系并不仅仅取决于当前两个样本之间的距离或相似性，还取决于当前样本对与其周围样本对之间的关系。

.. math::

    w_{ij}^- = \frac{1}{e^{\beta(\lambda - S_{ij})} + \sum_{k \in \mathcal{N}_i} e^{\beta(S_{ik} - S_{ij})}} 

.. math::

    w_{ij}^+ = \frac{1}{e^{-\alpha(\lambda - S_{ij})} + \sum_{k \in \mathcal{P}_i} e^{-\alpha(S_{ik} - S_{ij})}} 

.. math::

    \mathcal{L}(x_i) = \frac{1}{\alpha} \log \left( 1 + \sum_{k \in \mathcal{P}_i} e^{-\alpha (S_{ik} - \lambda)} \right) + \frac{1}{\beta} \log \left( 1 + \sum_{k \in \mathcal{N}_i} e^{\beta (S_{ik} - \lambda)} \right)

:math:`\mathcal{P}_i` 表示正样本集合，:math:`\mathcal{N}_i` 表示负样本集合，:math:`S_{ij}` 表示样本对的相似度。


Normalized Temperature-scaled Cross Entropy Loss
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`A Simple Framework for Contrastive Learning of Visual Representations <https://arxiv.org/pdf/2002.05709.pdf>`_

自监督学习方法，采用数据增强的方法生成正样本对。

.. math::

    \mathcal{L} = \frac{1}{2N} \sum_{k=1}^N \left( \mathcal{L}(2k-1, 2k) + \mathcal{L}(2k, 2k-1) \right)

.. math::

    \mathcal{L}(i,j) = - \log \left( \frac{e^{s_{i,j}/\tau}}{\sum_{k=1}^{2N} \mathbf{1}(k \neq i) e^{s_{i,k}/\tau} } \right)

.. math::

    s_{i,j} = \frac{z_i^{\top}z_j}{\| z_i \| \| z_j \|}

:math:`N` 是 batch 的大小，:math:`\tau` 是温度缩放因子。


样本对挖掘
-------------------

Packaged Triplets
^^^^^^^^^^^^^^^^^^^^^^^^

已经预先采样好的三元组。


Triplet-Margin Miner
^^^^^^^^^^^^^^^^^^^^^^^^^^^

根据 anchor-positive 与 anchor-negative 距离差来挖掘样本。只选择最困难的样本对是不利于训练的。

- Hard：:math:`d_{an} < d_{ap}`

- Semi-Hard：:math:`d_{an} > d_{ap}`

Angular Miner
^^^^^^^^^^^^^^^^^

对应 Angular Loss，根据角度阈值构建三元组。


Batch-Hard Miner
^^^^^^^^^^^^^^^^^^^^^^^

`In Defense of the Triplet Loss for Person Re-Identification <https://arxiv.org/pdf/1703.07737.pdf>`_

在 batch 内选择最困难的正样本对和负样本对。

Distance-Weighted Miner
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`Sampling Matters in Deep Embedding Learning <https://arxiv.org/pdf/1706.07567.pdf>`_

根据距离分布均匀采样负样本，可以保证得到的样本分布在一个较大的距离范围，保证样本多样性。

.. math::

    p(d) \propto d^{n-2} \left( 1- \frac{1}{4} d^2 \right) ^{\frac{n-3}{2}}

:math:`d` 表示 anchor 与 negative 的距离，:math:`n` 表示 embedding 的维度。


HDC Miner
^^^^^^^^^^^^^^^^^^^

`Hard-Aware Deeply Cascaded Embedding <http://openaccess.thecvf.com/content_ICCV_2017/papers/Yuan_Hard-Aware_Deeply_Cascaded_ICCV_2017_paper.pdf>`_

让更复杂的模型处理更困难的样本。

在 batch 内，对正负样本对都按距离排序，将固定比例的困难样本输入更深层的网络进行提特征、计算损失。

推理阶段，将不同层级的网络输出进行级联。


Maximum-Loss Miner
^^^^^^^^^^^^^^^^^^^^^^^^^^

重复多次采样 batch 的子集，提取出损失最大的样本对。


Multi-Similarity Miner
^^^^^^^^^^^^^^^^^^^^^^^^^^^

- 选择负样本，满足 :math:`d_{an} > d_{ap}^{max} - \epsilon`

- 选择正样本，满足 :math:`d_{ap} < d_{an}^{min} + \epsilon`

Pair-Margin Miner
^^^^^^^^^^^^^^^^^^^^^^^^^^^

根据距离阈值挑选样本对。

- 选择负样本，满足 :math:`d_{an} < m_n`

- 选择正样本，满足 :math:`d_{ap} > m_p`


参考资料
-------------

1. A Metric Learning Reality Check

  https://arxiv.org/abs/2003.08505

  https://github.com/KevinMusgrave/pytorch-metric-learning

  https://kevinmusgrave.github.io/pytorch-metric-learning/

2. 深度度量学习中的损失函数

  https://mp.weixin.qq.com/s?__biz=MzU1NTMyOTI4Mw==&mid=2247494208&idx=1&sn=50a940f4ce6093cd6c75f84e6c8efd59&chksm=fbd7582ccca0d13a270878d4aeeda8de15cc4be694b86185a95a74fee4aa9ae90efe87fe1bad&scene=27#wechat_redirect

3. 『深度概念』度量学习中损失函数的学习与深入理解

  https://www.cnblogs.com/xiaosongshine/p/11059762.html

4. 图解SimCLR框架，用对比学习得到一个好的视觉预训练模型
  
  https://blog.csdn.net/u011984148/article/details/106233313/