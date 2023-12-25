Pytorch：模型保存与读取
=========================

简单
------------

::

  import torch
  ## save
  torch.save(model, 'model.pkl')
  ## load
  model = torch.load('model.pkl')

这种方法存储的模型包括了模型框架及模型参数等，存取的 pkl 文件较大。


详细
------------

模型除了本身的框架、参数信息，还应包括训练的信息，比如训练迭代次数、优化器参数等。

.. code-block:: python
  :linenos:

  import torch
  import shutil

  ## save
  def save_checkpoint(state, is_best, save_path, filename):
    filename = os.path.join(save_path, filename)
    torch.save(state, filename)
    if is_best:
      bestname = os.path.join(save_path, 'model_best.pth.tar')
      shutil.copyfile(filename, bestname)

  save_checkpoint({
          'epoch': cur_epoch,
          'state_dict': model.state_dict(),
          'best_prec': best_prec,
          'loss_train': loss_train,
          'optimizer': optimizer.state_dict(),
        }, is_best, save_path, 'epoch-{}_checkpoint.pth.tar'.format(cur_epoch))

  ## load
  def load_checkpoint(checkpoint, model, optimizer):
    """ loads state into model and optimizer and returns:
        epoch, best_precision, loss_train[]
        e.g., model = alexnet(pretrained=False)
    """
    if os.path.isfile(load_path):
        print("=> loading checkpoint '{}'".format(load_path))
        checkpoint = torch.load(load_path)
        epoch = checkpoint['epoch']
        best_prec = checkpoint['best_prec']
        loss_train = checkpoint['loss_train']
        model.load_state_dict(checkpoint['state_dict'])
        optimizer.load_state_dict(checkpoint['optimizer'])
        print("=> loaded checkpoint '{}' (epoch {})"
              .format(epoch, checkpoint['epoch']))
        return epoch, best_prec, loss_train
    else:
        print("=> no checkpoint found at '{}'".format(load_path))
        # epoch, best_precision, loss_train
        return 1, 0, []

导入部分参数
---------------

当我们只需要从 ``state_dict()`` 导入部分模型参数时，可以采用如下方法：

.. code-block:: python
  :linenos:

  # args has the model name, num classes and other irrelevant stuff
  >>> pretrained_state = model_zoo.load_url(model_names[args.arch])
  >>> model_state = my_model.state_dict()
  >>> pretrained_state = { k:v for k,v in pretrained_state.iteritems() if k in model_state and v.size() == model_state[k].size() }
  >>> model_state.update(pretrained_state)
  >>> my_model.load_state_dict(model_state)


.. note::

    ``state_dict()`` 的参数是包含设备信息的，如果 ``torch.save`` 保存的是 GPU 上的模型的状态，则其参数是在 GPU 上的；相应地， ``torch.load`` 会默认地将这些参数加载到 GPU 上。为了避免 GPU 显存耗尽，可以使用 ``torch.load(checkpoint, map_location='cpu')`` 先将这些参数加载到 CPU 上，然后再进行 ``load_state_dict`` 。 


参考资料
-------------

1. Saving and loading a model in Pytorch?

  https://discuss.pytorch.org/t/saving-and-loading-a-model-in-pytorch/2610

2. How to load part of pre trained model?

  https://discuss.pytorch.org/t/how-to-load-part-of-pre-trained-model/1113/8

3. Serialization

  https://pytorch.org/docs/stable/torch.html#serialization