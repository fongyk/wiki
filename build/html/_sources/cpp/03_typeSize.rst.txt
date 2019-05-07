数据类型
======================

常用内置数据类型的大小
-------------------------

以下结果若非特别指出，均在Windows系统下由编译器Visual Studio测试得到。

.. table::

    =============   =====================  ========================
     类型             size/32位编译器           size/64位编译器
    =============   =====================  ========================
     char                    1                       1
     char*                   4                       8
     int                     4                       4
     int*                    4                       8
     short                   2                       2
     long                    4                       4 (8/linux)
     long*                   4                       8
     long long               8                       8
     float                   4                       4
     double                  8                       8
     size_t                  4                       8
     size_type               4                       8
     bool                    1                       1
     string                  28                      40
    =============   =====================  ========================

sizeof与strlen
--------------------

1. sizeof

    ``sizeof()`` 是 **运算符** ，计算的是分配的内存空间大小(单位为字节)，编译时就会计算，不受里面存储内容的影响。

    ``sizeof()`` 可以用数据类型、数组、字符串等做参数。

2. strlen

    ``strlen()`` 是 **函数** ，计算的是字符串的实际长度(字符的个数)，以 ``'\0'`` 结束但长度 **不包括** ``'\0'`` ，程序执行时才计算结果。
    ``strlen()`` 只能用 ``char*`` 类型做参数。

3. 实例

    定义以下变量：

    .. code-block:: cpp
        :linenos:

        char *strA = "abcdef";
        char strB[] = "abcdef";
        char strC[5] = {'a'};
        char strD[3] = {'a', 'b', 'c'};
        char strE[] = {'a', 'b', 'c'};
        char strF[] = {'a', 'b', 'c', '\0'};
        int y[] = {1,2,3};

    结果如下::

      sizeof(strA) = 4 : 指针的大小
      sizeof(strB) = 7 : 该字符数组用字符串初始化，因此strB就是一个字符串，字符串以'\0'结尾，则大小为6+1=7
      sizeof(strC) = 5 : 字符数组所占内存为5字节
      sizeof(strD) = 3 : 字符数组所占内存为3字节
      sizeof(strE) = 3 : 字符数组中有3个字符
      sizeof(strF) = 4 : 字符数组中有4个字符，包括'\0'
      sizeof(y) = 12 : 4 * 3 = 12 字节

      strlen(strA) = 6 : 字符串长度为6，不包括'\0'
      strlen(strB) = 6 : 字符串长度为6，不包括'\0'
      strlen(strC) = 1 : 字符数组中只有1个字符
      strlen(strD)不定，因为数组strD末尾没有人为补'\0'，因此strD是一个普通的字符数组，而不是字符串
      strlen(strE)不定，因为数组strE末尾没有人为补'\0'，因此strD是一个普通的字符数组，而不是字符串
      strlen(strF) = 3 : 字符串长度为3，不包括'\0'

    .. warning::

      如果字符数组以字符常量进行初始化且字符个数大于1，如上例中的 ``strD`` 和 ``strE`` ，
      如果不在末尾人为添加 ``'\0'`` ，则该字符数组不是字符串，
      使用函数 ``strlen`` 求得的大小不定，且该字符数组的内容也是未知的。
      虽然 ``strD`` 只有3个字节空间且刚好包含3个字符，但是 ``cout<<strD`` 的结果也是不定的。
      正确的定义应该是 ``strF`` 。


参考资料
--------------

1. 数据类型的数值范围

  https://blog.csdn.net/qianbitou000/article/details/51939055/

2. 关于strlen与sizeof的区别

  https://blog.csdn.net/zhengqijun\_/article/details/51815081
