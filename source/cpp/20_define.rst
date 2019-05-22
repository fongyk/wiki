#define
============

.. highlight:: cpp

**原则**
  - **对于单纯常量，最好以 const 对象或 enum 替换 #define。**

  - **对于形似函数的宏（macros），最好改用 inline 函数替换 #define。**


const
----------

“宁可以编译器替换 **预编译器** ”。

::

  #define ASPECT_RATIO 1.653

  const double AspectRation = 1.653;

也许名称 ``ASPECT_RATIO`` 从未被编译器看见，也许在编译器开始处理源码之前它已经被预处理器移走了。于是，记号名称 ``ASPECT_RATIO``
可能没有进入记号表（symbol table）内。当运用此常量获得编译错误时，这个错误也许会提到  ``1.653`` 而不是 ``ASPECT_RATIO`` ，导致对其追踪
变得困难。

作为一个语言常量， ``AspectRation`` 一定会被编译器看到并记入记号表。

此外，对浮点常量而言，使用常量可能比使用 #define 导致较小的代码量，因为预处理器将宏名称 ``ASPECT_RATIO`` 替换为  ``1.653`` ，可能导致
目标码（object code）出现多份 ``1.653`` ，使用常量则不会。

还可以在类定义 static const 成员。

.. code-block:: cpp
  :linenos:

  class Player
  {
  private:
    static const int NumTurns = 5; // 常量声明（不是定义）
    int scores[NumTurns]; // 使用该常量
  }


enum
----------

如果编译器不允许static成员在声明式上获得初始值，一方面，可以在头文件定义类，在源文件中初始化它；另一方面，如果该类在编译期间
必须使用一个常量值，例如上例中数组 scores 的大小必须在编译期间知道，此时可以使用 enum。一个属于枚举类型的数值可以权当int被使用。


.. code-block:: cpp
  :linenos:

  class Player
  {
  private:
    enum {NumTurns = 5}; // NumTurns 成为数值 5 的一个记号。
    int scores[NumTurns]; // 使用该常量
  }

.. note::

  enum的行为类似于#define，取一个enum的地址或#define的地址通常不合法，而取一个const的地址是合法的。


inline
-------------

使用宏（macros）不会有函数调用带来的额外开销。宏中的所有实参必须添加括号，但是仍然可能出现问题。

此时，可以定义内联函数（inline），它与普通函数一样遵守作用域（scope）和访问规则。内联函数的特点：

  - 在调用处直接展开该函数的内容

  - 运行速度快，但占用更多内存

  - 适用于规模小、流程直接（无递归和众多判断）、频繁调用的函数


普通函数的调用：
  1. 执行到函数调用指令时，程序将立即存储该指令的内存地址，并将函数参数复制到栈（为此保留的内存块）；
  #. 跳到标记函数起点的内存单元，执行函数代码（也许还需将返回值放入寄存器中）；
  #. 然后跳回到地址被保存的指令处。


.. code-block:: cpp
  :linenos:

  #include <iostream>
  using namespace std;

  #define CALL_WITH_MAX(a, b) f((a)>(b)? (a):(b))

  #define MAX_COMP_1(a, b) (a)>(b)? (a):(b)

  #define MAX_COMP_2(a, b) ((a)>(b)? (a):(b)) // 有外层括号

  template<class T>
  void f(T elem)
  {
    cout << "max out: " <<  elem << endl;
  }

  template<class T>
  inline void CallWithMax(const T& a, const T& b) // 形参使用常量引用，因为不知道 T 的具体类型，比较安全
  {
    f(a > b ? a : b);
  }

  int main(int argc, char ** argv)
  {
    int a = 5, b = 0;
    CALL_WITH_MAX(++a, b); // a 自增2次，变为7（++a > b => ++a）
    cout << a << endl;
    CALL_WITH_MAX(++a, b+10); // a 自增1次，变为8（++a < b+10 => b）
    cout << a << endl;

    f(-10 + MAX_COMP_1(a, b)); // -10 + a > b ? a : b; 结果为 0
    f(-10 + MAX_COMP_2(a, b));// -10 + (a > b ? a : b); 结果为 -10 + 8 = -2

    CallWithMax(a, b); // 8

    return 0;
  }


附：C/C++ 编译过程（简）
-------------------------

编译过程

  **1.（分离式）编译** ：每个文件独立编译

    A. 预处理：处理伪指令（#开头）和特殊符号。

      - 宏定义：#define，#undef
      - 条件编译：#ifdef，#ifndef，#endif
      - 头文件包含：#include
      - 特殊符号：__LINE__，__FILE__

    B. 编译：词法分析、语法分析，确认所有指令符合语法规则，将其翻译成等价的中间代码表示或汇编代码。

    C. 汇编：把汇编代码翻译成目标机器指令，得到目标文件（obj）。


  **2. 链接** ：将相关的目标文件进行连接（头文件包含关系、符号引用等），使这些目标文件能够成为一个被执行的同一整体。



参考资料
------------

1. 《Effective C++》条款02。

2. 《C++ Primer 第5版 中文版》 Page 213--214。

3. C++内联函数详解

  https://www.cnblogs.com/shijingjing07/p/5523224.html
