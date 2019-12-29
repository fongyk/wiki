pytorch：多GPU模式
=========================

**pytorch** 中可以通过 ``torch.nn.DataParallel`` 切换到多GPU（multi-GPU）模式，在 module 级别上实现数据并行。
此容器通过将 mini-batch 划分到不同的设备上来实现给定 module 的并行。
在 forward 过程中，module 会在每个设备上都复制一遍，每个副本都会处理部分输入。
在 backward 过程中，副本上的梯度会累加到原始module上。

batch 的大小应该大于所使用的 GPU 的数量，还应当是 GPU 个数的整数倍，这样划分出来的每一块 GPU 上都会有相同的样本数量。

有两种使用方式：网络外指定、网络内指定。

网络外指定
-----------

使用方法：

.. code-block:: python
    :linenos:

    # 在GPU上运行
    model.cuda()
    # 使用第0、1、2个GPU，注意设定batch_size大一些，否则数据不足以跑多GPU
    model = torch.nn.parallel.DataParallel(model, device_ids=[0, 1, 2])

**DataParallel** 只对  ``forward()`` 和 ``backward()`` 有效，直接调用model中自定义的  ``attribute`` 如 ``forward_1()`` 无效。

另外，在 **DataParallel** 模式下，引用model的  ``attribute`` 必须采用如下格式::

    # 相比于'model.attribute'多了'module'。
    model.module.attribute

比如，``model.module.classifier.parameters()`` 。


网络内指定
-----------

使用方法：

.. code-block:: python
    :linenos:

    # 定义网络结构
    self.layer1 = nn.Linear(227, 128)
    self.layer1 = nn.DataParallel(self.layer1, device_ids=[0, 1, 2])

在CPU模式下不需要更改代码。

参考资料
-------------

1. pytorch documentation

  https://pytorch.org/docs/stable/nn.html#torch.nn.DataParallel

2. 网络内指定

  https://ptorch.com/docs/3/parallelism_tutorial

3. 引用attribute

  https://discuss.pytorch.org/t/how-to-reach-model-attributes-wrapped-by-nn-dataparallel/1373

4. pytorch并行

  https://pytorch.org/docs/stable/nn.html#dataparallel-layers-multi-gpu-distributed

  https://pytorch.org/docs/stable/distributed.html

5. 中文文档

  https://pytorch.apachecn.org/

  https://www.pytorchtutorial.com/docs/

  https://pytorch-cn.readthedocs.io/zh/latest/
