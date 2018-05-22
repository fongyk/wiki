main函数
==========

返回值
------------

C++ main函数的返回值必须是 ``int`` ，即整型类型。在大多数系统中，main 的返回值被用来指示状态，返回值 ``0`` 表示执行成功，非0的返回值含义由系统定义，通常用来指出错误类型。

Windows系统下运行可执行文件(如launch.exe)可以直接忽略其扩展名 ``.exe`` ：

.. code::

    launch

Unix系统下需要使用全文件名，包括扩展名：

.. code-block:: bash

    ./a.out

访问main函数返回之后的方法依赖于系统。在Windows和Unix系统中，执行完一个程序之后，都可以通过 ``echo`` 命令来获取返回值。

Windows:

.. code-block:: bash

    echo %ERRORLEVEL%

Unix:

.. code-block:: bash

    echo $?

处理命令行选项
-------------------

main函数的形参列表有两种形式：

.. code-block:: cpp

    int main(int argc, char *argv[]){ ... }

    int main(int argc, char **argv){ ... }

第一种形参 ``*argv[]`` 中，``argv`` 是一个数组，它的元素是指向C风格的字符串的指针；
第二种形参 ``**argv`` 中，``argv`` 指向 ``char*`` 。
参数 ``argc`` 表示数组中字符串的数量。

当实参传给main函数之后，``argv`` 的第一个元素指向程序的名字或者一个空字符串，接下来的元素依次传递命令行提供的实参。最后一个指针之后的元素值保证为0。
例如，执行：

.. code::

  launch -d -o ofile data

``launch`` 是可执行文件。那么， ``argc=5`` ，``argv`` 包含如下的C风格字符串：

.. code-block:: cpp
    :linenos:

    argv[0] = "launch";
    argv[1] = "-d";
    argv[2] = "-o";
    argv[3] = "ofile";
    argv[4] = "data";
    argv[5] = "0";

.. note::

      当使用 ``argv`` 中的实参时，实参是从 ``argv[1]`` 开始的； ``argv[0]`` 保存的是程序名，而非用户输入。


参考资料
-----------------

《C++ Primer 第5版 中文版》 Page 2, Page 197。
