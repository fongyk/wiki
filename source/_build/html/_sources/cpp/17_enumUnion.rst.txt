枚举类型与共用体
===================

枚举类型
-------------

枚举类型（enumeration）使我们可以将一组 **整型常量** 组织在一起。格式 ::

  enum <类型名> {<枚举成员>};

枚举成员不能是数值，即不能是类似于{1,2,3}。可以定义 **无类型名** 的枚举类型。

初始化
^^^^^^^^^^^^^^^

.. highlight:: cpp

默认情况下，每个枚举变量的值就是其序号，从0开始，依次加1。 ::

  enum Week {Sun, Mon, Tue, Wed, Thu, Fri, Sat};
  //Sun=0, Mon=1, Tue=2, Wed=3, Thu=4, Fri=5, Sat=6

显式提供初始值。 ::

  enum Week {Sun=1, Mon, Tue, Wed, Thu, Fri=100, Sat};
  //Sun=1, Mon=2, Tue=3, Wed=4, Thu=5, Fri=100, Sat=101

枚举变量
^^^^^^^^^^^^^^^
定义枚举类型之后，就可以定义该枚举类型的变量，或者与枚举类型同时定义。枚举变量的值只能取枚举常量表中所列的值。

.. code-block:: cpp
  :linenos:

  enum Week {Sun=1, Mon, Tue, Wed, Thu, Fri=100, Sat} day_1;
  // 全局变量 day_1 默认初始化为 0。

  void ff(int num)
  {
    cout << -10 * num << endl;
  }
  void ff(Week day)
  {
    cout << static_cast<float>(10 * day) << endl;
  }

  int main(int argc, char** argv)
  {
    Week day_2, day_3;

    day_1 = Sun; // 或者 day_1 = Week::Sun （不限定作用域的枚举类型）
    day_2 = day_1;
    int i = day_1; // i = 1
    int j = Mon; // j = 2

    Week day_4(Week(100)); // day_4 = Fri
    bool equal = (day_4 == Fri); // true

    Week day_5(Week(-1)); // 越界，但是不报错，day_5 = -1 （VS 2013）

    ff(1); // 匹配 ff(int)，输出 -10
    ff(day_1); // 匹配 ff(Week)，输出 10
    ff(Fri); // 匹配 ff(Week)，输出 1000

    return 0;
  }


共用体
-------------

共用体（union）及其变量的定义形式与结构体类似。共用体成员访问方式也是使用运算符 ``.`` 或 ``->``。

::

  union ifcd
  {
    int i;
    float f;
    char c;
    double d;
  } x1, x2[5], *pu;
  // 同结构体一样，分号不能丢

与结构体的异同：

  - 存储分配方式

    - 结构体每个成员各自占有自己的存储单元、各自的地址，结构体占有的内存空间大小是所有成员所占存储单元的总和。

    - 共用体各个成员占用共同的存储单元，具有 **相同的首地址** ，占用存储单元最多的成员的长度就是共用体的长度。一个共用体
      可以包含多个不同类型的成员，但是每一时刻只有 **一个成员有效** ，即最后一次存放的数据成员起作用。虽然仍然可以访问无效的成员，但是结果是未知的。

        ::

          x1.i = 256;
          x1.c = 'A';
          x1.f = 1.23;
          // 三步操作之后，只有 x1.f 有效。

  - 初始化

    - 结构变量或数组可以为所有成员初始化。

    - 共用体变量或数组在初始化时，只能初始化它的 **第一个成员** ，对多个成员初始化是不允许的。

        ::

          union ifcd x3 = {256}, x4[3] = {256, 256, 256}; // 对成员 i 初始化

  - 结构体和共用体可以相互出现在对方的类型定义中。



参考资料
------------

1.《C++ Primer 第5版 中文版》 Page 736 -- 739。

2. C++ 枚举类型详解

  http://www.runoob.com/w3cnote/cpp-enum-intro.html

3. C++枚举（enum）的优雅用法

  https://blog.csdn.net/daizhiyan1/article/details/82428023
