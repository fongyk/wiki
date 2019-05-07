枚举类型
==============

枚举类型（enumeration）使我们可以将一组 **整型常量** 组织在一起。格式 ::

  enum <类型名> {<枚举成员>};

枚举成员不能是数值，即不能是类似于{1,2,3}。

初始化
----------

.. highlight:: cpp

默认情况下，每个枚举变量的值就是其序号，从0开始，依次加1。 ::

  enum Week {Sun, Mon, Tue, Wed, Thu, Fri, Sat};
  //Sun=0, Mon=1, Tue=2, Wed=3, Thu=4, Fri=5, Sat=6

显式提供初始值。 ::

  enum Week {Sun=1, Mon, Tue, Wed, Thu, Fri=100, Sat};
  //Sun=1, Mon=2, Tue=3, Wed=4, Thu=5, Fri=100, Sat=101

枚举变量
-------------
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


参考资料
------------

1.《C++ Primer 第5版 中文版》 Page 736 -- 739。

2. C++ 枚举类型详解

  http://www.runoob.com/w3cnote/cpp-enum-intro.html

3. C++枚举（enum）的优雅用法

  https://blog.csdn.net/daizhiyan1/article/details/82428023
