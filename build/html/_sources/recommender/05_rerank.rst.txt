重排
============


重排的主要作用是为了提升用户的多样性体验，扶持业务产品，弥补精排的个性化不足和实现多目标的最优解。
主要的策略为调权、强插、过滤、打散、多目标打分融合和模型重排。

多样性算法
----------------------

多样性（Diversity）和相关性（Relevance）是衡量推荐系统的常用的指标，这两个指标同时影响着推荐系统的商业目标和用户体验。

相关性很好理解，就是推荐给用户的商品必须符合用户的兴趣，满足用户的购物需求。用户会用点击行为来表达兴趣，用下单行为来满足购物需求。

多样性衡量单个推荐列表中物品之间的差异程度，通过计算同一个推荐列表中两两 Item 之间的相似度的平均值来衡量。


`MMR <https://www.cs.cmu.edu/~jgc/publication/The_Use_MMR_Diversity_Based_LTMIR_1998.pdf>`_
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

MMR 全称为最大边缘相关模型（Maximal Marginal Relevance），它通过计算每个 Item 与 Query 的相关性以及与已选择 Item 的差异性来确定最终的排序。
优化目标如下：

.. math::

    \operatorname{argmax}_{d \in D \setminus R} \left( \lambda \cdot \mathrm{Sim}(d,q) - (1-\lambda) \cdot \max_{d' \in R} \mathrm{Sim}(d,d') \right)

:math:`\lambda` 是用于平衡相关性和多样性的参数。

`DPP <https://proceedings.neurips.cc/paper_files/paper/2018/file/dbbf603ff0e99629dda5d75b6f75f966-Paper.pdf>`_
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

DPP（Determinantal Point Process）行列式点过程，是一种性能较高的概率模型，其将复杂的概率计算转换成简单的行列式计算，通过核矩阵的行列式计算每一个子集的概率。



矩阵的行列式的物理意义为矩阵中的各个向量张成的平行多面体体积的平方。这些向量彼此之间越不相似，向量间的夹角就会越大，张成的平行多面体的体积也就越大，矩阵的行列式也就越大，对应的商品集合的多样性也就越高。当这些向量彼此正交的时候，多样性达到最高。
而核矩阵（Kernel Matrix）的行列式可以同时度量商品集合的多样性和相关性。

.. math::

    L = \operatorname{Diag}\left(r_{u}\right) \cdot S \cdot \operatorname{Diag}\left(r_{u}\right) 

其中，:math:`S` 是 Item 之间的相似性矩阵，:math:`r_u` 是 User 与 Item 的相关性度量向量（可以用 pCTCVR 来刻画）。  

DPP 通过最大后验概率（MAP）估计，找到商品集中相关性和多样性最大的子集，从而作为推荐给用户的商品集。

相比于 MMR 每次只考虑当前内容与前序已选内容中最相似 Item 的相似度，DPP 会综合考虑所有已选内容的相互影响。


Listwise 重排
----------------

因为重排序模块往往是放在精排模块之后，而精排已经对推荐物品做了比较准确的打分，所以往往重排模块的输入是精排模块的 Top 得分输出结果，而且是有序的。
而精排模块的打分或者排序对于重排模块来说，是非常重要的参考信息。于是，这个排序模块的输出顺序就比较重要，而能够考虑到输入的序列性的模型，自然就是重排模型的首选。
我们知道，最常见的考虑时序性的模型是 RNN 和 Transformer，所以经常把这两类模型用在重排模块，这是很自然的事情。
一般的做法是：排序 Top 结果的物品有序，作为 RNN 或者 Transformer 的输入，RNN 或者 Transformer 明显可以融合当前上下文（也就是排序列表中其它物品的特征），来整体评估效果。
RNN 或者 Transformer 每个输入对应位置经过特征融合，再次输出预测得分，按照新预测的得分重新对物品排序。

- `DLCM <https://arxiv.org/pdf/1804.05936.pdf>`_
- `Global Rerank <https://arxiv.org/pdf/1805.08524.pdf>`_
- `PRM <https://arxiv.org/pdf/1904.06813.pdf>`_

参考资料
-------------

1. 重排
   
  https://chmx0929.gitbook.io/machine-learning/sou-suo-tui-jian-guang-gao/sou-suo-tui-jian-guang-gao/tui-jian/zhong-pai#map-mean-average-precision

2. 基于行列式点过程的推荐多样性提升算法的直观理解

  https://yangxudong.github.io/fast-dpp-map/