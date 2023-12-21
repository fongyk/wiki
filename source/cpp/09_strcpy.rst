strcpy 函数
===============

函数定义
---------------

.. code-block:: cpp
    :linenos:

    char* strcpy(char* dst, const char* src)
    {
        char* cp = dst; 
        while(*cp++ = *src++);  /* Copy src over dst */ 
        return dst;
    }

    char src[10] = "abcd";
    char dst[10];
    char* copy = strcpy(dst, src);

形参 src
+++++++++++++

形参 ``src`` 定义为  ``const`` ，防止函数对其进行修改。

额外指针 cp
++++++++++++++++++++++++++

``cp++`` 导致复制结束时， ``cp`` 指向的是 ``dst`` 绑定的字符串的尾部，因此不能直接返回 ``cp`` 。


返回值
++++++++++++++++++++++++++

为了实现链式操作，将目的地址返回。

.. code:: cpp

    int length = strlen(strcpy(str, "Hello World") ); 


参考资料
-----------

1. 标准的strcpy函数

  https://www.cnblogs.com/elisha-blogs/p/4125799.html