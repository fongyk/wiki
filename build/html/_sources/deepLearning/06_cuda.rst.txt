pytorch: cuda()
======================

使用指定GPU
------------

- **直接终端中设定** ::

    CUDA_VISIBLE_DEVICES=1 python my_script.py

- **代码中设定** ::

    import os
    os.environ["CUDA_VISIBLE_DEVICES"] = "2"

- **使用函数 set_device**  ::

    import torch
    torch.cuda.set_device(1)

cuda()
-----------

对于一个 ``tensor`` 对象，cuda()返回该对象在CUDA内存中的拷贝 ::

  obj = obj.cuda()

对于一个 ``nn.Module`` 实例，cuda()直接将该模型的参数和buffers转移到GPU。 ::

  model.cuda()


参考资料
------------

1. PyTorch中使用指定的GPU

  https://www.cnblogs.com/darkknightzh/p/6836568.html

2. pytorch documentation

  https://pytorch.org/docs/0.3.1/tensors.html?highlight=cuda#torch.Tensor.cuda

  https://pytorch.org/docs/0.3.1/nn.html?highlight=cuda#torch.nn.Module.cuda
