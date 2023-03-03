强制类型转换
================

static_cast<type> (expr)
---------------------------------

**1**. ``static_cast`` 作用和 C 语言风格强制转换的效果基本一样，由于没有运行时类型检查来保证转换的安全性，所以这类型的强制转换和 C 语言风格的强制转换都有安全隐患。

**2**. 用于基本数据类型之间的转换，如把 ``int`` 转换成 ``char`` ，把 ``int`` 转换成 ``enum`` 。这种转换的安全性需要开发者来维护。

**3**. C++ 的任何的隐式转换都是使用 ``static_cast`` 来实现。

**4**. 基类和子类之间转换：其中子类指针转换成父类指针是安全的；但父类指针转换成子类指针是不安全的。（基类和子类之间的动态类型转换建议用 ``dynamic_cast`` ）

**5**. 把空指针转换成目标类型的空指针。

**6**. 把任何类型的表达式转换成 ``void`` 类型。

dynamic_cast<type> (expr)
---------------------------------

type 可以是指针、引用、右值引用。

有条件转换，动态类型转换，运行时类型安全检查（对于指针，转换失败返回 ``NULL`` ；对于引用，抛出 ``std:bad_cast`` 异常）。

**1**. 安全的基类和子类之间转换。

**2**. 必须要有虚函数；必须是公有继承（public）。

**3**. 相同基类不同子类之间的交叉转换，结果是 ``NULL`` 或抛出 ``std:bad_cast`` 异常。

.. code-block:: cpp
  :linenos:

  // dynamic_cast
  #include <iostream>
  #include <exception>
  using namespace std;

  class Base { virtual void dummy() {} };
  class Derived: public Base { int a; };

  int main ()
  {
    try
    {
      Base* pba = new Derived;
      Base* pbb = new Base;
      Derived* pd;

      pd = dynamic_cast<Derived*>(pba);
      if (pd==0) cout << "Null pointer on first type-cast.\n";

      pd = dynamic_cast<Derived*>(pbb);
      if (pd==0) cout << "Null pointer on second type-cast.\n";

    } catch (exception& e) {cout << "Exception: " << e.what();}
    return 0;
  }

  // 输出结果：Null pointer on second type-cast.


const_cast<type> (expr)
--------------------------------

**1**. 去掉类型的 ``const`` 、 ``volitale`` 属性（对象本身的属性没有改变）;

**2**. 常量指针被转化成非常量的指针，并且仍然指向原来的对象；

**3**. 常量引用被转换成非常量的引用，并且仍然指向原来的对象；

**4**. ``const_cast`` 一般用于修改指针。如 ``const char* p`` 形式。
如果有一个函数，它的形参是 non-const 类型变量，而且函数不会对实参的值进行改动，这时我们可以使用类型为 ``const`` 的变量来调用函数，此时 const_cast 就派上用场了。

.. code-block:: cpp
  :linenos:

  // const_cast
  #include <iostream>
  using namespace std;

  void print (char* str)
  {
    cout << str << '\n';
  }

  int main ()
  {
    const char* c = "sample text";
    print ( const_cast<char *> (c) );
    return 0;
  }

  // 输出结果：sample text


reinterpret_cast<type> (expr)
-------------------------------------

**1**. ``reinterpret_cast`` 是从底层对数据进行重新解释，依赖具体的平台，可移植性差。

**2**. ``reinterpret_cast`` 可以将整型转换为指针，也可以把指针转换为数组。

**3**. ``reinterpret_cast`` 可以在指针和引用里进行肆无忌惮的转换。


使用stringstream转换类型
------------------------------

.. highlight:: cpp

::

  #include <sstream>

**sstream** 头文件定义了三个类型来支持内存IO：istringstream，ostringstream，stringstream。这些类型可以向 **string** 写入数据，或从 **string** 读取数据。

**stringstream** 的一些操作：

  - ``stringstream strm`` ：strm 是一个未绑定的 stringstream 对象

  - ``stringstream strm(s)`` ：strm 是一个 stringstream 对象，保存字符串 s 的一个拷贝

  - ``s = strm.str()`` ：返回 strm 保存的内容的拷贝
  
  - ``strm.str(s)`` ：把 strm 保存的内容修改为 s，丢弃之前的内容。


强制类型转换
^^^^^^^^^^^^^^^^^

.. code-block:: cpp
  :linenos:

  #include <iostream>
  #include <sstream>
  using namespace std;

  template <class output_type, class input_type>
  output_type Convert(const input_type &input)
  {
    stringstream strm;
    strm << input;
    output_type result;
    strm >> result;
    strm.clear();
    return result;
  }


  int main(int argc, char ** argv)
  {
    string strNum = "-22.22";
    float f = Convert<float>(strNum);
    cout << f << endl; // -22.22

    float n = 22.22;
    string str = Convert<string>(n);
    cout << str << endl; // 22.22

    return 0;
  }

.. note::

  strm调用 **成对的** ``<<`` 和 ``>>`` 之后，状态为 ``end-of-file`` ，必须进行 ``clear`` 才能进行下一次 ``<<`` 操作。

  ``strm.clear()`` 重置了strm的状态标识，并没有清空数据。如果没有调用 ``<<`` 之后没有使用 ``>>`` ，可以使用  ``strm.str("")`` 清空数据。


参考资料
---------------

1. C++中四种强制类型转换区别详解

  https://www.cnblogs.com/cauchy007/p/4968707.html

2. c++ 四种强制类型转换介绍

  https://blog.csdn.net/ydar95/article/details/69822540

3. C++中使用stringstream简化类型转换

  https://www.cnblogs.com/Mr-Zhong/p/5312478.html

4. c++ reference

  http://www.cplusplus.com/reference/sstream/stringstream

  http://www.cplusplus.com/doc/tutorial/typecasting/

5. C++强制类型转换操作符 const_cast

  https://www.cnblogs.com/QG-whz/p/4513136.html
