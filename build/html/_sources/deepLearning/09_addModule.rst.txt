pytorch：Module
=========================

container
---------------

``nn.Module`` 是 Pytorch 中提供的一个类，是所有神经网络模块的基类。自定义的模块要继承这个基类。

下面介绍三个容器，它们都继承自 ``nn.Module`` ：

  - **Sequential**

  - **ModuleList**

  - **ModuleDict**

Sequential
^^^^^^^^^^^^^^^^^

::

    class torch.nn.Sequential(*args)

当模型的前向计算为简单 **串联** 各个层的计算时，``Sequential`` 类可以通过更加简单的方式定义模型。这正是 ``Sequential`` 类的目的：它可以接收一个子模块的有序字典（OrderedDict）或者一系列子模块作为参数来逐一添加 ``nn.Module`` 的实例，而模型的前向计算就是将这些实例 **按添加的顺序** 逐一计算。

.. code-block:: python
  :linenos:

  # Example of using Sequential
  model = nn.Sequential(
            nn.Conv2d(1,20,5),
            nn.ReLU(),
            nn.Conv2d(20,64,5),
            nn.ReLU()
          )

  # Example of using Sequential with OrderedDict
  model = nn.Sequential(OrderedDict([
            ('conv1', nn.Conv2d(1,20,5)),
            ('relu1', nn.ReLU()),
            ('conv2', nn.Conv2d(20,64,5)),
            ('relu2', nn.ReLU())
          ]))

ModuleList
^^^^^^^^^^^^^^^^^

::

    class torch.nn.ModuleList(modules=None)


``ModuleList`` 接收一个子模块的列表作为输入，但 ``ModuleList`` 仅仅是一个储存各种模块的列表，这些模块之间没有联系也没有顺序（所以不用保证相邻层的输入输出维度匹配），需要在 ``forward`` 中定义前向计算的顺序。

``ModuleList`` 不同于一般的 Python list，加入到 ``ModuleList`` 里面的所有模块的参数会被自动添加（注册）到整个网络中。

.. code-block:: python
  :linenos:

  class MyModule(nn.Module):
      def __init__(self):
          super(MyModule, self).__init__()
          self.linears = nn.ModuleList([nn.Linear(10, 10) for i in range(10)])

      def forward(self, x):
          # ModuleList can act as an iterable, or be indexed using ints
          for i, l in enumerate(self.linears):
              x = self.linears[i // 2](x) + l(x)
          return x

方法：

- ``append(module)``

- ``extend(modules)``

- ``insert(index, module)``

参数中的 ``module`` 可以使 Pytorch 内建模块，也可以是自定义的继承自 ``nn.Module`` 的模块。


ModuleDict
^^^^^^^^^^^^^^^^^

::

    class torch.nn.ModuleDict(modules=None)


``ModuleDict`` 接收一个子模块的字典作为输入。和 ``ModuleList`` 一样，``ModuleDict`` 实例仅仅是存放了一些模块的字典，并没有定义 ``forward`` 函数需要自己定义。同样，``ModuleDict`` 也与 Python dict 有所不同， ``ModuleDict`` 里的所有模块的参数会被自动添加到整个网络中。

.. code-block:: python
  :linenos:

  class MyModule(nn.Module):
      def __init__(self):
          super(MyModule, self).__init__()
          self.choices = nn.ModuleDict({
                  'conv': nn.Conv2d(10, 10, 3),
                  'pool': nn.MaxPool2d(3)
          })
          self.activations = nn.ModuleDict([
                  ['lrelu', nn.LeakyReLU()],
                  ['prelu', nn.PReLU()]
          ])

      def forward(self, x, choice, act):
          x = self.choices[choice](x)
          x = self.activations[act](x)
          return x


.. code-block:: python
  :linenos:

  class CombinedROIHeads(nn.ModuleDict):
      """
      Combines a set of individual heads (for box prediction or masks) into a single head.
      -- from maskrcnn_benchmark
      """

      def __init__(self, heads):
          super(CombinedROIHeads, self).__init__(heads)

      def forward(self):
          pass

  >>> heads = []
  >>> heads.append(("box", nn.Conv2d(256, 512, kernel_size=3, stride=2)))
  >>> heads.append(("mask", nn.Conv2d(256, 512, kernel_size=3, stride=1)))
  >>> heads.append(("keypoint", nn.Linear(256, 512, bias=True)))
  >>> roi_heads = CombinedROIHeads(heads)
  >>> roi_heads
  CombinedROIHeads(
    (box): Conv2d(256, 512, kernel_size=(3, 3), stride=(2, 2))
    (mask): Conv2d(256, 512, kernel_size=(3, 3), stride=(1, 1))
    (keypoint): Linear(in_features=256, out_features=512, bias=True)
  )
          

方法：

- ``clear()``

- ``items()``

- ``keys()``

- ``values()``

- ``pop(key)``

- ``update(modules)`` ``modules (iterable)`` 是值为 ``nn.Module`` 的字典类型或包含 ``(string, nn.Module)`` 对的可迭代类型。


add_module
--------------------

如果有一个元素是 ``nn.Module`` 的列表，直接赋值给一个模型的属性（attribute），并不会让列表内的 Modules 立即注册（register）为模型的模块。

.. code-block:: python
  :linenos:

  import torch
  import torch.nn as nn

  class A(nn.Module):
      def __init__(self):
          super(A, self).__init__()

          self.layerList = [nn.Linear(5, 1, bias=False), nn.Linear(2,1, bias=False)]

.. code-block:: python
  :linenos:

  >>> a = A()
  >>> print a
  A(
  )

使用 ``add_module`` 可以自由地将列表的元素变成模型的模块。 ``add_module`` 建立了对 ``nn.Module`` 的引用，并不是添加了新的对象。
因此，对引用的修改会直接修改列表内的 ``nn.Module`` 。

加入之后，可以通过模型的名字来进行访问：``_modules[name]`` 。``_modules`` 是一个顺序字典（OrderedDict）。

.. code-block:: python
  :linenos:

  import torch
  import torch.nn as nn

  class A(nn.Module):
      def __init__(self):
          super(A, self).__init__()
          self.layerList = [nn.Linear(5, 1, bias=False), nn.Linear(2,1, bias=False)]
          self.add_module("layer_0", self.layerList[0])
          self.add_module("layer_1", self.layerList[1])

          print self.layerList[0].weight
          print self._modules['layer_0'].weight
          self._modules['layer_0'].weight.data = self._modules['layer_0'].weight.data + 2 * torch.ones_like(self._modules['layer_0'].weight.data)

      def forward(self):
          print self.layerList[0].weight
          print self._modules['layer_0'].weight

.. code-block:: python
  :linenos:

  >>> a = A() ## init
  Parameter containing:
   0.0244 -0.0521 -0.4013 -0.1229  0.0343
  [torch.FloatTensor of size 1x5]

  Parameter containing:
   0.0244 -0.0521 -0.4013 -0.1229  0.0343
  [torch.FloatTensor of size 1x5]

  >>> print a
  A(
    (layer_0): Linear(in_features=5, out_features=1, bias=False)
    (layer_1): Linear(in_features=2, out_features=1, bias=False)
  )

  >>> a() ## forward
  Parameter containing:
   2.0244  1.9479  1.5987  1.8771  2.0343
  [torch.FloatTensor of size 1x5]

  Parameter containing:
   2.0244  1.9479  1.5987  1.8771  2.0343
  [torch.FloatTensor of size 1x5]
  ## 可以看到，上面的参数是同步更新的


attribute 索引
-----------------

除了使用 ``_modules[name]`` 访问模块，还可以将 name 转换成属性（attribute）的索引，通过下标的形式访问。

.. code-block:: python
  :linenos:

  import torch
  import torch.nn as nn

  class AttrProxy(object):
      """Translates index lookups into attribute lookups."""
      def __init__(self, module, prefix):
          self.module = module
          self.prefix = prefix
      def __getitem__(self, index):
          return getattr(self.module, self.prefix + str(index))

  class A(nn.Module):
      def __init__(self):
          super(A, self).__init__()
          self.layerList = [nn.Linear(5, 1, bias=False), nn.Linear(2,1, bias=False)]
          self.add_module("layer_0", self.layerList[0])
          self.add_module("layer_1", self.layerList[1])

          self.layer = AttrProxy(self, "layer_")

          print self.layerList[0].weight
          print self.layer[0].weight
          self.layer[0].weight.data = self.layer[0].weight.data + 2 * torch.ones_like(self.layer[0].weight.data)

      def forward(self):
          print self.layerList[0].weight
          print self.layer[0].weight
          print self.layer[1].weight


.. code-block:: python
  :linenos:

  >>> a = A() ## init
  Parameter containing:
  -0.2655  0.1539 -0.2107  0.0740  0.1922
  [torch.FloatTensor of size 1x5]

  Parameter containing:
  -0.2655  0.1539 -0.2107  0.0740  0.1922
  [torch.FloatTensor of size 1x5]

  >>> a() ## forward
  Parameter containing:
   1.7345  2.1539  1.7893  2.0740  2.1922
  [torch.FloatTensor of size 1x5]

  Parameter containing:
   1.7345  2.1539  1.7893  2.0740  2.1922
  [torch.FloatTensor of size 1x5]

  Parameter containing:
   0.0068 -0.1787
  [torch.FloatTensor of size 1x2]

附：Module 部分实例方法
---------------------------------

- ``add_module(name, module)`` 向当前模块中加入新的子模块。

- ``apply(fn)`` 循环地向每个子模块（ ``.children()`` ）及其自身施加 ``fn`` 函数，典型的用法包括初始化模型参数。

- ``buffers(recurse=True)`` 返回模块缓存的迭代器，如 BatchNorm 需要缓存 running_mean 和 running_var。

- ``named_buffers(prefix='', recurse=True)`` 返回模块缓存的迭代器，迭代器会同时产生缓存的名字和缓存的数据。

- ``children()`` 返回直接子模块的迭代器。

- ``named_children()`` 返回直接子模块的迭代器，迭代器会同时产生模块的名字和模块自身。

- ``modules()`` 返回所有子模块的迭代器。

- ``named_modules(memo=None, prefix='')`` 返回所有子模块的迭代器，迭代器会同时产生模块的名字和模块自身。

- ``cpu()`` 将所有的模型参数和缓冲移到 CPU。

- ``cuda(device=None)`` 将所有的模型参数和缓冲移到 GPU，必须在构造优化器之前调用。

- ``double()`` 将所有的浮点型参数和缓存强制转换为 double 类型。

- ``float()`` 将所有的参数和缓存强制转换为浮点类型。

- ``half()`` 将所有的参数和缓存强制转换为半浮点类型。

- ``train(mode=True)`` 将模块设置为训练模式。

- ``eval()`` 与 ``train(False)`` 等效。

- ``forward(*input)`` 定义前向传播的计算过程。

- ``state_dict(destination=None, prefix='', keep_vars=False)`` 返回包含模块完整状态的字典，字典中同时包含参数和持续性缓存。

- ``load_state_dict(state_dict, strict=True)`` 从状态字典中将参数和缓存复制到该模块及其子模块中；如果 ``strict=True`` , 那么 ``state_dict`` 的键必须和该模块的 ``state_dict()`` 函数返回的键一致。

- ``parameters(recurse=True)`` 返回模块参数的迭代器，通常传递给优化器。

- ``named_parameters(prefix='', recurse=True)`` 返回模块参数的迭代器，迭代器将同时产生参数的名称和参数自身。

- ``register_parameter(name, param)`` 向模块中加入参数。

- ``to(*args, **kwargs)`` 移动或强制转换参数和缓存。

- ``type(dst_type)`` 将所有的参数和缓存强制转换为 ``dst_type`` （python:type or string） 类型。

- ``zero_grad()`` 将所有模型参数的梯度设置为0。


参考资料
-------------

1. pytorch documentation

  https://pytorch.org/docs/0.3.1/nn.html?highlight=add_module#torch.nn.Module.add_module

2. List of nn.Module in a nn.Module

  https://discuss.pytorch.org/t/list-of-nn-module-in-a-nn-module/219

3. 模型构造

  https://www.cnblogs.com/sdu20112013/p/12132786.html

4. TORCH.NN

  https://pytorch.org/docs/stable/nn.html

5. 看pytorch文档学深度学习——Containers

  https://zhuanlan.zhihu.com/p/98760838