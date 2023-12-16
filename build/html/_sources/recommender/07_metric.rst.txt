评价指标
============

当评估机器学习模型或信息检索系统的性能时，常用的评价指标包括：

- AUC（Area Under the Curve）
    分类器把一个随机抽取的正例排在一个随机抽取的负例之前的概率

- GAUC（Group Area Under the Curve）
    以 User 为 Group，计算每个 User 样本的 AUC，然后根据用户的样本量做加权平均（需要剔除只有正样本/负样本的用户）。
  
  .. math::

    \mathrm{GAUC} = \frac{\sum_{k=1}^{K} n_k \times \mathrm{AUC}_k}{\sum_{k=1}^{K} n_k}

- MRR（Mean Reciprocal Rank）
    衡量相关 Item 的倒数排名。

  .. math::

    \mathrm{MRR} = \frac{1}{N} \sum_{i=1}^{N} \frac{1}{rank_i}

- `MAP（Mean Average Precision） <https://en.wikipedia.org/wiki/Evaluation_measures_(information_retrieval)#Mean_average_precision>`_
    平均精度均值，针对每个 User 计算 AP 再求均值。

  .. math::

    \mathrm{MAP} = \frac{1}{U} \sum_{u=1}^{U} \frac{ \sum_{i=1}^{R_u} P(u,i) \times rel_{u,i} }{R_u}

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