类的static const成员
=======================

const
----------
const数据成员的初始化只能在类的构造函数的初始化列表中进行。声明const变量是不能初始化。

.. note::

  必须使用初始化列表的情形

  - **常量成员** ，因为常量只能初始化不能赋值，所以必须放在初始化列表里面。

  - **引用类型** ，引用必须在定义的时候初始化，并且不能重新赋值，所以也要写在初始化列表里面。

  - 没有默认构造函数的 **类类型** ，因为使用初始化列表不调用默认构造函数来初始化，而是直接调用拷贝构造函数初始化。

.. warning::

	成员是按照他们在类中 **声明** 的顺序进行初始化的，而不是按照他们在初始化列表出现的顺序初始化的。

static
-----------
不能在定义对象时对变量进行 **定义和初始化** ，即不能用构造函数进行初始化。
初始化在类体外进行，前面不加static修饰符。

.. note::

  const全局变量和类static成员变量都可以在 **定义类的头文件** 中初始化。不会因为头文件重复包含而导致变量重复定义的编译错误。

  但是在定义指针时要注意， ``const char* p = "name"`` 定义的指针不是const，可能导致错误；而 ``char* const p = "name"`` 不会。

static const
-----------------
静态常量成员，可以直接初始化（static cosnt 和 const static 含义相同）。

.. code-block:: cpp
  :linenos:

  // header.h
  class Solution {
  public:
  	static void print()
  	{
  		cout << var << endl; // 100
  		cout << (mapping.begin()->second)[0] << endl; // 'a'
  	}

  private:
  	static const map<char, vector<char> > mapping; // 常量声明式
  	static const int var = 100; // 常量声明式（直接初始化）
  };

  // source.cpp
  const map<char, vector<char> > Solution:: mapping = {{'2', {'a', 'b', 'c'}},
                                                      {'3', {'d', 'e', 'f'}},
                                                      {'4', {'g', 'h', 'i'}}}; // mapping 的定义

  /* 注：const map只能通过迭代器 const_iterator 访问元素（it->first, it->second）
   ，不能通过下标[]的方式访问。*/

  // 对应类的 static const int/char/bool 成员常量，如果不取他们的地址，则可以直接声明并使用，而无需提供以下的定义式。
  const int Solution:: var; // var 的定义。由于 常量var 在类内声明时已经获得了初始值，因此定义时不可以再设初始值。


参考资料
-------------

1. C++ static、const和static const类型成员变量声明以及初始化

  https://www.cnblogs.com/hustfeiji/articles/5168529.html

2. 头文件中定义 const 全局变量应注意的问题

  https://blog.csdn.net/mafuli007/article/details/8499585

3. C++ 初始化列表

  https://www.cnblogs.com/graphics/archive/2010/07/04/1770900.html

4. C++的一大误区——深入解释直接初始化与复制初始化的区别

  https://blog.csdn.net/ljianhui/article/details/9245661

5. C++构造函数初始化列表与赋值

  https://www.cnblogs.com/sz-leez/p/7082865.html

  http://www.cnblogs.com/BlueTzar/articles/1223169.html
