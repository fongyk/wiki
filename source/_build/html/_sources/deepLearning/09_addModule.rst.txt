pytorch：add_module
=========================

add_module
--------------------

如果有一个元素是 ``Module`` 的列表，直接赋值给一个模型的属性（attribute），并不会让给列表内的 Modules 立即成为模型的模块。

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

简单地，可以使用 ``nn.Sequential(*module_list)`` 将列表转换成 **串联** 的模块。一方面，这样会使得模块的名字被默认地用数字命名；
另一方面，如果需要的不是串联结构，这样的做法行不通。

使用 ``add_module`` 可以自由地将列表的元素变成模型的模块。 ``add_module`` 建立了对 ``Module`` 的引用，并不是添加了新的对象。
因此，对引用的修改会直接修改列表内的 ``Module`` 。

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



参考资料
-------------

1. pytorch documentation

  https://pytorch.org/docs/0.3.1/nn.html?highlight=add_module#torch.nn.Module.add_module

2. List of nn.Module in a nn.Module

  https://discuss.pytorch.org/t/list-of-nn-module-in-a-nn-module/219
