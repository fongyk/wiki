重命名
============

.. highlight:: bash

**场景** ：需要把某个目录下的文件进行重命名。

首先生成一批后缀为 jpg 的文件::

    touch ustc-{1..6}.jpg

mv
----------

.. code-block:: bash
    :linenos:

    for f in /data6/fong/shell/*.jpg
    do
        echo $f
        mv $f ${f}-new
    done

或者写成一行::

    for f in /data6/fong/shell/*.jpg; do mv $f ${f}-new; done

``mv $f ${f}-new`` 在文件名后面加了 ``-new`` 。

awk
----------

::

    ls *.jpg | awk -F "jpg" '{print "mv " $0,$1"JPG"}' | bash

``awk -F "jpg"`` 将文件名进行切分，分隔符是 ``jpg`` ；``$0`` 表示原字符串，``$1`` 是分割后的第一段字符串。

::

    fong@GK40:/data6/fong/shell$ ls *.jpg | awk -F "jpg" '{print $0,$1"JPG"}'
    ustc-1.jpg ustc-1.JPG
    ustc-2.jpg ustc-2.JPG
    ustc-3.jpg ustc-3.JPG
    ustc-4.jpg ustc-4.JPG
    ustc-5.jpg ustc-5.JPG
    ustc-6.jpg ustc-6.JPG

rename
------------

``man rename`` 可以查看使用手册，这里使用 perl 版本的正则表达式。

::

   rename [ -v ] [ -n ] [ -f ] perlexpr [ files ]

参数：

    -v    显示修改成功的文件名；

    -n    不执行任何操作，用来测试 rename 过程，并不直接运行，可以查看测试效果后，然后再运行；

    -f    强制修改，会覆盖存在的文件。

小写转换成大写::

    fong@GK40:/data6/fong/shell$ rename -n 'y/a-z/A-Z/' *.jpg
    rename(ustc-1.jpg, USTC-1.JPG)
    rename(ustc-2.jpg, USTC-2.JPG)
    rename(ustc-3.jpg, USTC-3.JPG)
    rename(ustc-4.jpg, USTC-4.JPG)
    rename(ustc-5.jpg, USTC-5.JPG)
    rename(ustc-6.jpg, USTC-6.JPG)

后缀从 .jpg 改成 .JPG::

    fong@GK40:/data6/fong/shell$ rename -n 's/\.jpg/.JPG/g' *.jpg
    rename(ustc-1.jpg, ustc-1.JPG)
    rename(ustc-2.jpg, ustc-2.JPG)
    rename(ustc-3.jpg, ustc-3.JPG)
    rename(ustc-4.jpg, ustc-4.JPG)
    rename(ustc-5.jpg, ustc-5.JPG)
    rename(ustc-6.jpg, ustc-6.JPG)

``s`` 表示替换，``g`` 表示替换行内所有匹配到的字符串，去掉 ``g`` 则只替换匹配到的第一个字符串。

注意：``\.`` 是对 ``.`` 的转义，``.`` 在正则中会匹配任意一个字符。

错误的结果::

    fong@GK40:/data6/fong/shell$ rename -n 's/.jpg/.JPG/' ustcjpg.jpg
    rename(ustcjpg.jpg, ust.JPG.jpg)
    fong@GK40:/data6/fong/shell$ rename -n 's/.jpg/.JPG/g' ustcjpg.jpg
    rename(ustcjpg.jpg, ust.JPG.JPG)
