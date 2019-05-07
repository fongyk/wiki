激活函数(Activation Function)
================================

神经网络引入激活函数主要是为了增强网络的非线性，提升网络的拟合能力和学习能力。激活函数有以下几个性质：

    - 非线性
    - 可微性
    - 单调性：保证单层网络是凸函数

下面介绍 **sigmoid** 、**tanh** 以及 **ReLU** 。

sigmoid
-----------

**sigmoid** 函数的数学表达式如下：

.. math::

    \sigma(z) = \frac{1}{1 + e^{-z}}.

其导数具有如下性质：

.. math::

    \sigma^\prime(z) = \sigma(z)(1-\sigma(z)).

**sigmoid** 函数能够把输入的连续值压缩到(0, 1)范围内，其函数曲线如下：

.. image:: ./02_sigmoid.jpeg
    :width: 500px
    :align: center

优点：

 - 单调连续，输出范围有限，优化稳定
 - 求导容易

缺点：

  - 容易饱和。当输入很大、很小时(saturation, 饱和)，神经元的梯度接近0，出现“梯度消失”(gradient vanishing)，导致无法完成深层网络的训练。
  - 输出不是零均值的(not zero-centered)。假设某个神经元的输入一直是正的，即 :math:`x>0` . 对于 :math:`f(x)=w^Tx+b` ，则 :math:`w` 获得的梯度将是恒正或者恒负
    （取决于 :math:`f` 得到的梯度的符号），导致 :math:`w` 的更新非常“曲折”(zig-zagging)。
    当然，如果是按batch训练，最终梯度是各个样本下梯度的和，而每个样本下的梯度可能是符号各异的，因此在一定程度上可以缓解这个问题。


tanh
-----------

**tanh** 函数的数学表达式如下：

.. math::

    tanh(z) = \frac{e^z-e^{-z}}{e^z+e^{-z}},

    tanh(z) = 2\sigma(2z)-1.

其函数曲线如下：

.. image:: ./02_tanh.jpeg
    :width: 500px
    :align: center

与 **sigmoid** 一样， **tanh** 也会产生饱和现象，但是 **tanh** 的输出是零均值的(zero-centered)。


ReLU
----------

**ReLU** 函数的数学表达式如下：

.. math::

    relu(z) = max(0,z).

其函数曲线如下：

.. image:: ./02_relu.jpeg
    :width: 500px
    :align: center

优点：

 - 计算简单。 **sigmoid** 和 **tanh** 都需要计算指数。
 - 收敛速度快。 `Krizhevsky et al. 论文 <http://www.cs.toronto.edu/~fritz/absps/imagenet.pdf>`_ 指出 **ReLU** 收敛速度比 **tanh** 快6倍。

    .. image:: ./02_alexplot.jpeg
        :width: 500px
        :align: center

缺点:

 - 容易产生死亡节点(dead ReLU)。一个非常大的梯度流过一个 **ReLU** 神经元，更新过参数之后，这个神经元对很多输入数据都输出0，则梯度一直为0。
   当然 **ReLU** 的输出依靠 :math:`w` 和 :math:`x` 的共同作用，死亡节点可能会被重新激活。

**LeakyReLU** 可以有效应对上述缺点。


参考资料
-------------

1. CS231n

  http://cs231n.github.io/neural-networks-1/#actfun

2. 神经网络之激活函数(Activation Function)

  https://blog.csdn.net/memray/article/details/51442059

3. What is the "dying ReLU" problem in neural networks?

  https://www.quora.com/What-is-the-dying-ReLU-problem-in-neural-networks