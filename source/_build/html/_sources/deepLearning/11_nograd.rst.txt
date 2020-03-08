pytorch：no_grad()
=====================

model.eval() 和 with torch.no_grad()
--------------------------------------------

**model.eval()**

    - 会保留所有网络层的计算数据。
    
    - autograd 机制也在工作，执行 ``loss.backward()`` 仍然计算变量的梯度。

    - 其作用是使 Dropout 层失活（p=1.0），同时改变 BatchNorm 的行为，采用全局的均值和方差。

**with torch.no_grad()**

    - autograd 机制不工作，无法进行梯度计算。

    - 可以加速前向推理，节约内存。

提特征时两者配合使用。

参考资料
------------

1. ‘model.eval()’ vs ‘with torch.no_grad()’

  https://discuss.pytorch.org/t/model-eval-vs-with-torch-no-grad/19615