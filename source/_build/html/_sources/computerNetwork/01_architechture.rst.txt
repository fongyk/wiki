计算机网络体系结构
=======================

不同的体系结构
---------------------

.. image:: ./01_arch.png
    :width: 500px
    :align: center


七层网络体系
-------------------

**OSI** （Open System Interconnect Reference Model）：开放式系统互联参考模型。

- 物理层（pysical layer）
    把电脑连接起来的物理手段，如光缆、电缆、双绞线、无线电波。它规定了网路的一些电气属性，作用是负责传输0和1比特的电信号。

- 数据链路层（data link layer）
    物理寻址，并将比特组装成帧和点到点的传递。

- 网络层（network layer）
    负责数据包从源到宿的传递和网际互连，控制子网的运行，逻辑编址、分组传输、路由选择。

- 传输层（transport layer）
    提供端到端的可靠报文传递和错误恢复。

- 会话层（session layer）
    负责建立、管理和断开通信连接，以及数据的分割等数据传输相关的管理。

- 表示层（presentation layer）
    设备固有的数据格式与网络标准数据格式之间的转换（接受不同格式的信息，如文字流、图像、声音等）。

- 应用层（application layer）
    针对特定应用的协议，如电子邮件协议、SSH、FTP、HTTP。

.. image:: ./01_osi.gif
    :width: 700px
    :align: center


参考资料
----------------

1. 七层网络结构

  https://blog.csdn.net/u010359398/article/details/82142449
