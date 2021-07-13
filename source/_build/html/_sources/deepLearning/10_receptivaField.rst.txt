特征图与感受野
================

特征图：feature map。

感受野：receptive field。


特征图
-----------

输入：:math:`C_{in} \times H_{in} \times W_{in}`

卷积核：:math:`size = k \times k,\ padding = p,\ stride = s`

输出：:math:`C_{out} \times H_{out} \times W_{out}`

计算量：:math:`C_{out} \times H_{out} \times W_{out} \times k \times k \times C_{in}`

- **卷积**

  .. math::

       H_{out} = \lfloor \frac{H_{in} - k + 2p}{s} \rfloor + 1 \\
       W_{out} = \lfloor \frac{W_{in} - k + 2p}{s} \rfloor + 1

- **反卷积**

  .. math::

       H_{out} = (H_{in} - 1) \times s + k \\
       W_{out} = (W_{in} - 1) \times s + k


感受野
------------

感受野，用来表示网络内部的不同位置的神经元对 **原图像** 的感知范围的大小。

.. image:: ./10_receptiveField.png
  :align: center
  :width: 600 px

- **从前往后推**

  设 :math:`R_n` 表示第 :math:`n` 层卷积层的感受野（ :math:`R_n \times R_n` ）的大小，卷积核：:math:`size = k_n \times k_n,\ stride = s_n` 。

  .. math::

      R_n &=&\ R_{n-1} + (k_n - 1) \prod_{i=1}^{n-1} s_i \\
      R_1 &=&\ k_1

- **从后往前推**

  设 :math:`r_n` 表示输出层（ :math:`N` ）在第 :math:`n` 层输入特征图的感知范围（ :math:`r_n \times r_n` ）的大小，第 :math:`n` 层卷积核：:math:`size = k_n \times k_n,\ stride = s_n` 。

  最后一层在原图的感受野为 :math:`r_1` 。

  .. math::

      r_n &=&\ (r_{n+1} - 1) \times s_n + k_n \\
      r_N &=&\ k_N

参考资料
-------------

1. feature map大小计算方法

  https://blog.csdn.net/qq_28424679/article/details/78665273

2. 卷积神经网络CNN（1）——图像卷积与反卷积（后卷积，转置卷积）

  https://blog.csdn.net/fate_fjh/article/details/52882134

3. 深度神经网络中的感受野(Receptive Field)

  https://zhuanlan.zhihu.com/p/28492837

4. 卷积神经网络中感受野的详细介绍

  https://blog.csdn.net/program_developer/article/details/80958716
