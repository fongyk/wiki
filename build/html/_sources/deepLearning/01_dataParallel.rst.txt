pytorch：多 GPU 模式
=========================

DataParallel
-------------------

Pytorch 中可以通过 ``torch.nn.DataParallel`` 切换到多GPU（multi-GPU）模式，在 module 级别上实现数据并行。
此容器通过将 mini-batch 划分到不同的设备上来实现给定 module 的并行。
在 forward 过程中，module 会在每个设备上都复制一遍，每个副本都会处理部分输入。
在 backward 过程中，副本上的梯度会累加到原始 module 上，在一块 GPU 上更新参数，最后将参数广播（broadcast）给其他 GPU，完成一次迭代。

batch 的大小应该大于所使用的 GPU 的数量，还应当是 GPU 个数的整数倍，这样划分出来的每一块 GPU 上都会有相同的样本数量。

有两种使用方式：网络外指定、网络内指定。

网络外指定
^^^^^^^^^^^^^^^

使用方法：

.. code-block:: python

    # 在GPU上运行
    >>> model.cuda()
    # 使用第0、1、2个GPU，注意设定 batch_size 大一些，否则数据不足以跑多GPU
    >>> model = torch.nn.parallel.DataParallel(model, device_ids=[0, 1, 2])

在 **DataParallel** 模式下，引用 model 的属性必须采用如下格式::

    # 相比于'model.attribute'多了'module'。
    model.module.attribute

比如 ``model.module.classifier.parameters()`` 。


网络内指定
^^^^^^^^^^^^^^^

使用方法：

.. code-block:: python
    :linenos:

    # 定义网络结构
    >>> self.layer1 = nn.Linear(227, 128)
    >>> self.layer1 = nn.DataParallel(self.layer1, device_ids=[0, 1, 2])

在 CPU 模式下不需要更改代码。

distributed
---------------

``torch.distributed`` + ``torch.nn.parallel.DistributedDataParallel`` 比 ``torch.nn.DataParallel`` 更加高效：

  - 每个进程维护自己的优化器，并在每次迭代中执行完整的优化步骤。虽然这可能看起来是多余的，因为梯度已经收集在一起并跨进程平均，因此每个进程的梯度都是相同的，然而，这意味着不需要参数广播步骤，从而减少节点之间传输张量的时间。

  - 每个进程都包含一个独立的 Python 解释器，消除了额外的解释器开销。


初始化
^^^^^^^^^^^

::

  torch.distributed.init_process_group(backend, init_method=None, timeout=datetime.timedelta(0, 1800), world_size=-1, rank=-1, store=None, group_name='')

- ``backend`` 包括 ``mpi`` ，``gloo`` ，``nccl`` 。其中 ``nccl`` 比较适用于多 GPU 并行。

- ``init_method`` 指定了如何初始化互相通信的进程，默认为 ``env://`` ，进程会自动从本机的环境变量中读取如下数据：

  - MASTER_PORT: rank-0 机器的一个空闲端口
  - MASTER_ADDR: rank-0 机器的地址
  - WORLD_SIZE: 进程数，在 ``init_process_group`` 函数中可以指定
  - RANK: 本机的 rank，在 ``init_process_group`` 函数中可以指定

- ``torch.distributed.get_world_size()`` 获取进程数

- ``torch.distributed.get_rank()`` 获取进程编号


模型并行
^^^^^^^^^^^^^

::

  class torch.nn.parallel.DistributedDataParallel(module, device_ids=None, output_device=None, dim=0, broadcast_buffers=True, process_group=None, bucket_cap_mb=25, find_unused_parameters=False, check_reduction=False)

``broadcast_buffers`` 允许各 GPU 在 forward 开始前对 buffers 进行同步，这对 BN 层有影响。另外，``DistributedDataParallel`` 还支持 ``SyncBatchNorm`` 。如果未同步，尽管每个 GPU 上的模型参数和梯度是一致的，但是 BN 层的均值和方差是不同的。

.. code-block:: python
    :linenos:

    >>> torch.cuda.set_device(i)
    >>> torch.distributed.init_process_group(backend='nccl', world_size=4, init_method='...')
    >>> model = DistributedDataParallel(model, device_ids=[i], output_device=i)


sampler
^^^^^^^^^^^^^

可以利用 ``sampler`` 确保 dataloader 只会 load 到整个数据集的一个特定子集。 ``torch.utils.data.distributed.DistributedSampler`` 为每一个进程划分出一部分数据集，以避免不同进程之间数据重复。

.. code-block:: python
    :linenos:

    >>> batch_size = batch_size_per_proc
    >>> sampler = DistributedSampler(dataset)
    >>> dataloader = DataLoader(
                          dataset=dataset,
                          batch_size=batch_size,
                          sampler=sampler
                          )

为了让每个进程有机会获取其他的训练数据，需要在每个 epoch 都调用 ``sampler`` 的 ``set_epoch`` 方法，``DistributedSampler`` 是将 epoch 作为 ``seed`` 来随机打乱数据集的。

如果不使用 ``DistributedSampler`` ，每个进程都会 load 同一个数据集，这就导致：训练一个 epoch，实际使用的训练数据是::

  len(dataset) * num_proc


启动进程
^^^^^^^^^^^^

``torch.distributed`` 提供了一个辅助启动工具 ``torch.distributed.launch`` ，这个工具可以辅助在每个节点上启动多个进程，

.. code-block:: bash
    :linenos:

    export NGPUS=2
    python -m torch.distributed.launch --nproc_per_node=$NGPUS train.py [--arg1 --arg2 ...]
    unset NGPUS

在训练的 train.py 中必须要解析 ``--local_rank=LOCAL_PROCESS_RANK`` 这个命令行参数，

  .. code-block:: python
    :linenos:

    >>> parser.add_argument("--local_rank", type=int, default=0)
    >>> model = torch.nn.parallel.DistributedDataParallel(
                                                model,
                                                device_ids=[args.local_rank],
                                                output_device=args.local_rank
                                                )

这个命令行参数是由 ``torch.distributed.launch`` 提供的，指定了每个 GPU 在本地的 rank。

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

  https://pytorch.org/tutorials/intermediate/dist_tuto.html

  https://pytorch.org/docs/stable/nn.html#distributeddataparallel

  https://pytorch.org/docs/stable/data.html#torch.utils.data.distributed.DistributedSampler

  https://github.com/pytorch/examples/blob/5df464c46cf321ed1cc3df1e670358d7f5ae1887/imagenet/main.py#L42

  https://pytorch.org/docs/master/nn.html#torch.nn.SyncBatchNorm

5. 中文文档

  https://pytorch.apachecn.org/

  https://www.pytorchtutorial.com/docs/

  https://pytorch-cn.readthedocs.io/zh/latest/

6. pytorch 分布式训练 distributed parallel 笔记

  https://blog.csdn.net/m0_38008956/article/details/86559432

7. Pytorch多机多卡分布式训练

  https://zhuanlan.zhihu.com/p/68717029

8. pytorch 1.0 分布式

  https://zhuanlan.zhihu.com/p/52110617

9. torch.utils.data.distributed.DistributedSampler

  https://discuss.pytorch.org/t/question-about-the-behavior-of-torch-utils-data-distributed-distributedsampler/35942

  https://discuss.pytorch.org/t/distributeddataparallel-with-1-gpu-per-process/44628

10. nn.BatchNorm in distributed training

  https://discuss.pytorch.org/t/do-nn-batchnorm-in-distributed-training-default-to-be-synchronized/42140

  https://discuss.pytorch.org/t/save-model-for-distributeddataparallel/47129