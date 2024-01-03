评价指标
============

常用指标
-------------

当评估机器学习模型或信息检索系统的性能时，常用的评价指标包括：

- AUC（Area Under the Curve）
    分类器把一个随机抽取的正例排在一个随机抽取的负例之前的概率。

- GAUC（Group Area Under the Curve）
    以 User 为 Group，计算每个 User 样本的 AUC，然后根据用户的样本量做加权平均（需要剔除只有正样本/负样本的用户）。
  
  .. math::

    \mathrm{GAUC} = \frac{\sum_{k=1}^{K} n_k \times \mathrm{AUC}_k}{\sum_{k=1}^{K} n_k}

- MRR（Mean Reciprocal Rank）
    衡量相关 Item 的倒数排名。

  .. math::

    \mathrm{MRR} = \frac{1}{N} \sum_{i=1}^{N} \frac{1}{rank_i}

- `MAP（Mean Average Precision） <https://en.wikipedia.org/wiki/Evaluation_measures_(information_retrieval)#Mean_average_precision>`_
    平均精度均值，针对每个 User/Query 计算 AP 再求均值。

  .. math::

    \mathrm{MAP} = \frac{1}{U} \sum_{u=1}^{U} \frac{ \sum_{i=1} P(u,i) \times rel_{u,i} }{R_u}

- `NDCG（Normalized Discounted Cumulative Gain） <https://en.wikipedia.org/wiki/Discounted_cumulative_gain>`_
    归一化折损累计增益，思想：高相关性的结果比一般相关性的结果更影响最终的指标得分；有高相关性的结果出现在更靠前的位置的时候，指标会越高。

  .. math::

    \mathrm{DCG}_p & = \sum_{i=1}^{p} \frac{2^{rel_i} - 1}{\log_2(rank_i + 1)} \\
    \mathrm{IDCG}_p & = \sum_{i=1}^{\left\Vert REL_p \right\Vert} \frac{2^{rel_i} - 1}{\log_2(rank_i + 1)} \\
    \mathrm{NDCG}_p & = \frac{\mathrm{DCG}_p}{\mathrm{IDCG}_p}


此外，还会计算 Q 值来评价预估的高低估情况：

.. math::

    Q_{ctr} = \frac{\sum_i \mathrm{pCTR}_i}{\sum_i \mathrm{isClick}_i}


离线评估的目的在于快速定位问题，快速排除不可行的思路，为线上评估找到靠谱的候选者。

在分析线上效果时，可能需要分场景、类目等计算细分指标。


AUC 离在线不一致问题
--------------------------

特征维度
+++++++++++

- 特征出现穿越
    一般是使用了和 Label 强相关的特征，或者序列特征使用了“未来”的数据（请求时间之后）。

- 离在线不一致
    特征处理不一致（比如线上有做量化、半精度），或者数据来源没对齐。

    对于一些强 Bias 特征，离在线的使用方式也是特别重要的，如果使用不当往往离线收益很大而线上纹丝不动或者反向。
    比如 Position Bias，在推荐领域一般放到 Wide & Deep 模型的 Wide 侧，离线训练时按实际曝光位置来训练；线上 Serving 时统一置为 0，这对于只追求序关系正确的推荐场景是没有问题的。但是放到广告 CTR 模型中就存在问题，因为广告场景中还需要依赖 pCTR 做出价计算去收取广告主的钱。

    可参考 `Youtube Shallow Tower <https://daiwk.github.io/assets/youtube-multitask.pdf>`_ 对 Bias 的处理。

训练维度
+++++++++++

- 训练集与测试集是否存在重叠部分。
- 训练集是否出现了过拟合。

线上结果置信度
+++++++++++++++++

- 线上指标统计时间窗口：不同指标达到可置信水平的统计窗口有较大区别，这跟业务和指标稳定性有很大关系。
- 实验平台分桶是否足够随机（对比线上 AUC 的时候需要注意，不同模型的 AUC 是在不同流量下计算的，不一定具有可比性）。
- 实验模型 Serving 状态：模型请求是否超时、模型更新时效性。

数据分布
+++++++++++++

实验模型线下评估时拟合的是 Base 模型跑出来的数据分布，到上线后训练样本里既有 Base 模型跑出来样本也有实验模型跑出来的样本，且占比在不断变化，相当于数据分布在变。

有效的经验：

- 对无偏数据进行上采样，比如随机流量/探索流量产生的样本，或者新模型产生的样本。
- Base 模型和新模型融合：模型预估分数 :math:`p_{new}` 和 Base 模型预估分数 :math:`p_{base}` 直接在线上做线性融合；刚上线的时候 :math:`\alpha` 选取比较小的值，随着迭代 :math:`\alpha` 慢慢放大。

  .. math::

    p = \alpha \cdot p_{new} + (1 - \alpha) \cdot p_{base}

流量抢夺，链路纠缠
+++++++++++++++++++++

关注系统链路上下游的变化，收益可能被其他模块拿走了。


特殊时间点的漂移
++++++++++++++++++++

大促/活动时间节点的数据分布会发生较大变化。


参考资料
-----------

1. “AUC提升了效果指标下降了”之原因分析

  https://www.deeplearn.me/4237.html

2. 推荐系统，离线 AUC 涨了，线上 CTR 等效果没涨，可能有哪些原因？

  https://www.zhihu.com/question/517418281/answer/2355367968

3. KDD'23 | 转化率预估新思路：基于历史数据复用的大促转化率精准预估

  https://zhuanlan.zhihu.com/p/640387297

4. Youtube 排序系统：Recommending What Video to Watch Next

  https://zhuanlan.zhihu.com/p/82584437