pytorch: cuda
======================

使用指定GPU
------------

- **直接终端中设定（推荐）** ::

    CUDA_VISIBLE_DEVICES=1 python my_script.py

- **代码中设定** ::

    import os
    os.environ["CUDA_VISIBLE_DEVICES"] = "2"

- **使用函数 set_device**  ::

    import torch
    torch.cuda.set_device(1)

device切换
-------------

对于一个 ``tensor`` 对象， ``cuda()`` 返回该对象在CUDA内存中的拷贝::

  obj = obj.cuda()

对于一个 ``nn.Module`` 实例， ``cuda()`` 直接将该模型的参数和buffers转移到GPU::

  model.cuda()

另外，使用 ``to(*args, **kwargs)`` 可以更方便地管理设备。

.. code-block:: python
    :linenos:

    >>> import torch
    >>> obj = torch.ones((2,5), dtype=torch.float32)
    >>> device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
    >>> device
    device(type='cuda', index=0)
    >>> obj = obj.to(device, dtype=torch.float32)
    >>> obj.device
    device(type='cuda', index=0)

    >>> net = torch.nn.Linear(10,5,bias=True)
    >>> net.to(device)
    >>> net
    Linear(in_features=10, out_features=5, bias=True)
    >>> net.bias.device
    device(type='cuda', index=0)


参考资料
------------

1. PyTorch中使用指定的GPU

  https://www.cnblogs.com/darkknightzh/p/6836568.html

2. pytorch documentation

  https://pytorch.org/docs/0.3.1/tensors.html?highlight=cuda#torch.Tensor.cuda

  https://pytorch.org/docs/0.3.1/nn.html?highlight=cuda#torch.nn.Module.cuda

  https://pytorch.org/docs/1.2.0/tensors.html?highlight=#torch.Tensor.to

  https://pytorch.org/docs/1.2.0/cuda.html?highlight=device#torch.cuda.device
