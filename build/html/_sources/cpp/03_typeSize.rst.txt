数据类型
======================

常用内置数据类型的大小
-------------------------

以下结果若非特别指出，均在Windows系统下由编译器Visual Studio测试得到。

.. table:: 类型大小
    :align: center

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


float和double
---------------------

单精度浮点型 **float** 的精度为 **6 -- 7** 位有效数字，双精度浮点型 **double** 的精度为 **15 -- 16** 位有效数字。

.. code-block:: cpp
  :linenos:
  :emphasize-lines: 17 - 20, 22

  #include <iostream>
  #include <iomanip> // std::setprecision
  using namespace std;

  int main(int argc, char ** argv)
  {
    int i = 200000003 / 100000002; // 1.9999999900000003

    float f_i = 200000003 / (float)100000002; // 浮点型常数默认为 const double，或用 200000003.0f 指定为 float。
    float f_f = (float)200000003.0 / (float)100000002.0; // 若不进行强制类型转换，会有 warning: truncation from 'double' to 'float'
    float f_d = (float)200000003.0 / (double)100000002;// warning: truncation from 'double' to 'float'
    double d_d = 200000003 / (double)100000002;

    cout.setf(ios::fixed); // 浮点数定点输出
    cout.setf(ios::showpoint); // 显示小数位
    cout.precision(10); // 固定为10位精度（四舍五入）
    cout << i << endl; // 1
    cout << f_i << ends << static_cast<int>(f_i) << endl; // 2.0000000000 2
    cout << f_f << ends << static_cast<int>(f_f) << endl; // 2.0000000000 2
    cout << f_d << ends << static_cast<int>(f_d) << endl; // 2.0000000000 2
    cout << d_d << ends << static_cast<int>(d_d) << endl; // 1.9999999900 1
    cout.precision(2);
    cout << d_d << ends << static_cast<int>(d_d) << endl; // 2.00 1

    cout << boolalpha; // 设置布尔型输出格式
    cout << (i == static_cast<int>(f_f)) << endl; // false
    cout << (i == static_cast<int>(f_d)) << endl; // false
    cout << (i == static_cast<int>(d_d)) << endl; // true （只有double转换到int的结果与 i 一致）

    float f_a = 0.1000001;
    float f_a2 = f_a * f_a; // 0.1000001^2 = 0.01000002000001
    cout << setprecision(7) << f_a2 << endl; // 0.01000002
    cout << setprecision(15) << f_a2 << endl; // 0.0100000193342566
    
    double d_a = 0.1000001;
    double d_a2 = d_a * d_a; // 0.1000001^2 = 0.01000002000001
    cout << setprecision(7) << d_a2 << endl; // 0.01000002
    cout << setprecision(15) << d_a2 << endl; // 0.01000002000001

    return 0;
  }



参考资料
--------------

1. 数据类型的数值范围

  https://blog.csdn.net/qianbitou000/article/details/51939055/

2. 关于strlen与sizeof的区别

  https://blog.csdn.net/zhengqijun\_/article/details/51815081

3. C++ 中的 cout.setf() 函数

  https://blog.csdn.net/baishuiniyaonulia/article/details/79144033
