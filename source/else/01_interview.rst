复习
=========

汇总
----------

1. github

  - https://github.com/imhuay/Algorithm_Interview_Notes-Chinese

  - https://github.com/jwasham/coding-interview-university/blob/master/translations/README-cn.md

2. 2018校招算法岗面试题汇总

  https://zhuanlan.zhihu.com/p/36801851


C++
------------

1. 虚函数

  https://blog.csdn.net/fighting_coder/article/details/77187151

2. C++构造函数和析构函数能否声明为虚函数？(转载)

  https://www.cnblogs.com/hxb316/p/3853544.html

3. 重载、重写（覆盖）和隐藏的区别

  https://blog.csdn.net/zx3517288/article/details/48976097

4. C++ STL中vector内存用尽后，为啥每次是两倍的增长，而不是3倍或其他数值？Hint：:math:`1 + 2 + 1 + 4 + 1 + 1 + 1 + 8 + \cdots + n = \mathcal{O}(n)` ，每一次 push_back 操作的摊还代价为 :math:`\mathcal{O}(1)` 。

  https://www.zhihu.com/question/36538542

5. 常见C++笔试面试题整理

  https://zhuanlan.zhihu.com/p/69999591

Python
-----------

1. 基本数据类型

  https://www.cnblogs.com/littlefivebolg/p/8982889.html

2. Python中的None

  https://www.cnblogs.com/changbaishan/p/8084863.html

3. 使用lambda高效操作列表的教程

  https://www.cnblogs.com/mxp-neu/articles/5316557.html

4. 经典7大Python面试题

  https://blog.csdn.net/qq_41597912/article/details/81459804

5. 迭代器和生成器

  https://www.cnblogs.com/chongdongxiaoyu/p/9054847.html

机器学习/深度学习
---------------------------

1. 激活函数

  https://fongyq.github.io/docs/deepLearning/02_activationFunction.html

2. Batch Normalization

  https://fongyq.github.io/docs/deepLearning/03_batchnorm.html

3. 过拟合

  https://fongyq.github.io/docs/deepLearning/03_batchnorm.html

4. 正则化项L1和L2的区别

  https://www.cnblogs.com/lyr2015/p/8718104.html

5. KMeans秘籍之如何确定K值

  https://blog.csdn.net/alicelmx/article/details/80991870

6. 决策树

  - ID3、C4.5

      https://www.cnblogs.com/coder2012/p/4508602.html

  - 预剪枝与后剪枝

      https://blog.csdn.net/zfan520/article/details/82454814

  - CART分类与回归树

      https://www.jianshu.com/p/b90a9ce05b28

7. Logistic Regression

  https://fongyq.github.io/docs/machineLearning/01_lr.html

8. Support Vector Machine

  https://fongyq.github.io/docs/machineLearning/02_svm.html

9. PCA

  https://fongyq.github.io/docs/machineLearning/03_pca.html


论文相关
-----------------

1. AlexNet/VGG/GoogleNet

  https://blog.csdn.net/gdymind/article/details/83042729

2. CNN卷积神经网络\_ GoogLeNet 之 Inception(V1-V4)

  https://blog.csdn.net/diamonjoy_zone/article/details/70576775

3. ResNet

  - Deep Residual Learning for Image Recognition

      https://arxiv.org/pdf/1512.03385.pdf

  - torchvision.models.resnet
  
      https://pytorch.org/docs/stable/_modules/torchvision/models/resnet.html#resnet101

  - ResNet-50 结构

      https://www.jianshu.com/p/993c03c22d52

4. ResNeXt

  - ResNeXt

      https://www.cnblogs.com/bonelee/p/9031639.html

  - ResNeXt算法详解

      https://blog.csdn.net/u014380165/article/details/71667916

5. R-CNN系列

  - RCNN（三）：Fast R-CNN

      https://blog.csdn.net/u011587569/article/details/52151871

  - 一文读懂Faster RCNN

      https://zhuanlan.zhihu.com/p/31426458

  - 【RCNN系列】【超详细解析】

      https://blog.csdn.net/amor_tila/article/details/78809791

  - 实例分割模型Mask R-CNN详解：从R-CNN，Fast R-CNN，Faster R-CNN再到Mask R-CNN

      https://blog.csdn.net/jiongnima/article/details/79094159

  - (Mask RCNN)——论文详解(真的很详细)

      https://blog.csdn.net/wangdongwei0/article/details/83110305

  - 实例分割--Mask RCNN详解（ROI Align / Loss Fun）

      https://blog.csdn.net/qinghuaci666/article/details/80900882

  - ROI-Align 原理理解

      https://blog.csdn.net/gusui7202/article/details/84799535

  - 为什么RCNN用SVM做分类而不直接用CNN全连接之后softmax输出？

      https://www.zhihu.com/question/54117650


6. Focal Loss（样本不均衡：正/负样本数量不均衡（ :math:`\alpha` ），简单/困难样本数量不均衡（ :math:`\gamma` ））

  .. math::

      CE &=\ -y \log y_t - (1 - y) \log (1 - y_t) & &\ [\text{Cross Entropy Loss}] \\
      FL &=\ -y \alpha (1 - y_t)^\gamma \log y_t - (1 - y) (1 - \alpha) y_t^\gamma \log (1 - y_t) & &\ [\text{Focal Loss}]

  即

  .. math::
      :nowrap:

      $$
      CE =
      \begin{cases}
      - \log y_t, & &\ y=1\\
      - \log (1 - y_t), & &\ y=0
      \end{cases}
      $$

      $$
      FL =
      \begin{cases}
      - \alpha (1 - y_t)^\gamma \log y_t, & &\ y=1\\
      - (1 - \alpha) y_t^\gamma \log (1 - y_t), & &\ y=0
      \end{cases}
      $$


  - 损失函数改进方法之Focal Loss

      https://blog.csdn.net/sinat_24143931/article/details/79033538

  - RetinaNet论文理解

      https://blog.csdn.net/wwwhp/article/details/83317738

  - Focal Loss理解

      https://www.cnblogs.com/king-lps/p/9497836.html


7. FCN（Fully Convolutional Networks）

  - FCN学习:Semantic Segmentation

      https://zhuanlan.zhihu.com/p/22976342?utm_source=tuicool&utm_medium=referral

  - FCN于反卷积(Deconvolution)、上采样(UpSampling)

      https://blog.csdn.net/nijiayan123/article/details/79416764

8. FPN（Feature Pyramid Networks for Object Detection）

  https://www.cnblogs.com/fangpengchengbupter/p/7681683.html

9. CapsuleNet解读

  https://blog.csdn.net/u013010889/article/details/78722140/


10. 轻量级网络--MobileNet论文解读

  https://blog.csdn.net/u011974639/article/details/79199306

11. 一文读懂卷积神经网络中的1x1卷积核。Hint：升维、降维、跨通道信息交互。

  https://zhuanlan.zhihu.com/p/40050371

12. Image Classification Architectures

  - 模型，FLOP（浮点计算量），性能，参数量（表格中的参数量单位是字节，按 4 字节/浮点型数计算，需要除以 4 才得到参数个数）

      https://github.com/albanie/convnet-burden#convnet-burden

  - torchvision.models

      https://pytorch.org/docs/stable/torchvision/models.html

其他
--------------

1. 理解数据库的事务，ACID，CAP和一致性

  https://www.jianshu.com/p/2c30d1fe5c4e
