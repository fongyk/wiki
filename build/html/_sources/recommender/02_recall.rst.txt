召回
============

召回针对的是索引库中的全部 Item，主要作用是实行炮火覆盖、全面打击，将 User 的兴趣一网打尽，
因此很多时候召回往往不是一路召回而是多路召回，每一路召回都从不同的用户兴趣出发点去捞取一定量的 Item，
然后再将每一路召回的 Item 融合去重再送入粗排。

- 统计
    热度，LBS

- 协同过滤
    UserCF，ItemCF

- U2T2I
    基于 User Tag 召回
  
- I2I
    `Swing <https://arxiv.org/pdf/2010.05525.pdf>`_ ，Embedding（Word2Vec、FastText），Graph Embedding（Node2Vec、DeepWalk、EGES）

- U2I
    `DSSM 双塔 <https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/cikm2013_DSSM_fullversion.pdf>`_ ， `Youtube DNN <https://static.googleusercontent.com/media/research.google.com/zh-CN//pubs/archive/45530.pdf>`_ ，Sentence Bert

召回处于整体推荐链条的前端，其结果经过粗排、精排两次筛选，作用于最终业务指标时，影响力就大大减弱了。
受限于巨大的候选集和实时性要求，召回模型的复杂度受限，不能上太复杂的模型。


`Swing <https://arxiv.org/pdf/2010.05525.pdf>`_
------------------------------------------------------------

出发点：如果大量用户同时喜欢两个物品，且这些用户之间的相关性低，那么这两个物品一定是强关联。

.. math::

     s(i, j)=\sum_{u \in U_{i} \cap U_{j}} \sum_{v \in U_{i} \cap U_{j}} \frac{1}{\alpha+\left|I_{u} \cap I_{v}\right|}

:math:`U_{i}` 是喜欢物品 :math:`i` 的用户集合；:math:`I_{u}` 是用户 :math:`u` 喜欢的物品集合。

向量化召回
--------------

.. image:: ./02_twoTower.png
    :width: 400px
    :align: center

双塔是召回+粗排的绝对主力模型。

**训练**：

- User 侧特征输入一个 DNN，得到一个 User Embedding。
- Item 侧特征输入一个 DNN，得到一个 Item Embedding。
- 两个 Embedding 做内积运算得到 Logit，进入损失函数。

**离线向量化**：

- 所有 Item Embedding 离线推断好。
- 构建好 ANN 向量索引（比如 `FAISS <https://github.com/facebookresearch/faiss>`_ ）。

**线上部署**：

- 实时 User 特征输入 User Tower 得到 User Embedding。
- 用 User Embedding 在 ANN 索引中查找最近邻，得到召回结果。

User 侧信息与 Item 侧信息只有唯一一次交叉机会，就是在双塔生成各自的 Embedding 之后的那次点积，
但是这时参与交叉的 User/Item Embedding 已经是高度浓缩的了，一些细节信息已经损失，永远失去了与对侧信息交叉的机会。

负样本
^^^^^^^^^^^

如果说排序是特征的艺术，那么召回就是样本的艺术，特别是负样本的艺术。
**要破除“召回照搬排序”的迷信，不能（只）拿“曝光未点击”做负样本**。

离线训练数据的分布，应该与线上实际应用的数据保持一致。从线上日志获得的训练样本，已经是上一版本的召回、粗排、精排替用户筛选过的，即已经是对用户“比较靠谱”的样本了。拿这样的样本训练出来的模型做召回，一叶障目，只见树木，不见森林。

基本思想：拿点击样本做正样本，拿随机采样做负样本。

- 全局随机负采样
    随机从全场景曝光过 Item 采样，使用 Listwise 存储负样本，能够最大程度保证数据分布一致，但随机采样的负样本有可能跟正样本差异大。

- In Batch 负采样
    Batch 内负采样是有损的，但实验对比在可接受范围内，而且负样本都是其他正样本，因此具有一定热度打压的作用。

- Popularity 负采样
    基于随机负采样，加入热度 Item 作为负样本。因为热门 Item 没有作为正样本，那么极有可能该 Item 是不相关或者用户不感兴趣。

- Hard 负采样
    模型在训练/Serving时，总有部分 Item 逃过模型的法眼，透传到粗排甚至精排当中。因此可以通过线上日志中找出有召回但粗排过滤的，有召回但没有曝光；又或者在训练过程当中，从 Item 库中检索相似度高于某一个阈值的 Item 并随机选取。此举可以提高模型的精度，过滤无关的 Item。

当热门 Item 做正样本时，要降采样，减少对正样本集的绑架，避免所有人的召回结果都集中于少数热门 Item。

当热门 Item 做负样本时，要适当过采样，抵销热门 Item 对正样本集的绑架；同时，也要保证冷门 Item 在负样本集中有出现的机会。

Loss
------------


`Youtube DNN <https://static.googleusercontent.com/media/research.google.com/zh-CN//pubs/archive/45530.pdf>`_ 模型选择了 Sampled Softmax Loss 作为损失函数。
对于二分类而言，BCE Loss 只是比较正负样本的差距，而且每次 Loss 的计算中，都是判断一个样本是正还是负，并没有纵向的对比。
对于 Softmax Loss 而言，其是一次性进行多个 Item 之间的比较，而且在每一次的 Loss 计算中，都会将正样本和多个负样本进行比较，并且告诉模型正样本是和这一批负样本很不同的。Softmax Loss 训练出来的 Embedding 的区分性更好。
直观上，这种 Loss 的优化目标和向量化召回是更一致的。

`EBF <https://arxiv.org/pdf/2006.11632.pdf>`_ 采用的是 Triplet Loss。


参考资料
-------------

1. 推荐系统[四]：精排-详解排序算法LTR (Learning to Rank)

  https://www.cnblogs.com/ting1/p/17166976.html

2. 负样本为王：评Facebook的向量化召回算法

  https://zhuanlan.zhihu.com/p/165064102

3. Embedding-based Retrieval in Facebook Search

  https://arxiv.org/pdf/2006.11632.pdf

4. 久别重逢话双塔

  https://zhuanlan.zhihu.com/p/428396126

5. 推荐算法召回-粗排-精排链路总结

  https://zhuanlan.zhihu.com/p/463021052

6. 一文说尽推荐系统的召回模型

  https://zhuanlan.zhihu.com/p/585495313