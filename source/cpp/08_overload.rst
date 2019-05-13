重载、覆盖、隐藏
=====================

重载（Overloading）
-------------------
同一可访问区内被声明的几个具有不同参数列表（参数个数，参数类型，参数顺序）的同名函数。不关心函数返回类型。

覆盖（Overriding）
----------------------
基类中被重写的函数，用 ``virtual`` 修饰。派生类重写的函数与被重写的函数保持同样的函数名、参数列表、返回类型。

使用 ``virtual`` 的同时，配合使用 ``override`` 关键字来说明派生类中的虚函数。这么做的好处是是的程序员的意图更加清晰（即：希望覆盖基类中的虚函数），同时让编译器发现错误。
因为只有虚函数才能被覆盖。编译器会检查两个对应函数的声明是否匹配。

通过把某个函数指定为 ``final`` ，拒绝对该函数进行覆盖。也在类名后面接 ``final`` ，以禁止该类被继承。

.. code-block:: cpp
  :linenos:

  class Base
  {
    virtual void f(int) const final;
    virtual void f1(int) const;
    virtual void f2();
    void f3();
  };

  class Derived: Base
  {
    void f(int) const; // 错误：f 禁止覆盖
    void f1(int) const override; // 正确
    void f2(int) override; // 错误：基类中没有形如 f2(int) 的函数
    void f3() override; // 错误：f3 不是虚函数
    void f4() override; // 错误：基类中没有名为 f4 的函数
  };

  class NoDerived final { /* */ }; // NoDerived 不能作为基类

多态性
  我们把具有继承关系的多个类型成为多态类型，因为我们能够使用这些类型的“多种形式”而无须在意它们的差异。引用或指针的静态类型与动态类型
  不同，这正是C++支持多态性的根本所在。

  对非虚函数的调用在 **编译时** 进行绑定。类似地，通过 **对象** 本身进行的函数（虚函数或非虚函数）调用也在 **编译时** 绑定。
  因为 **对象** 的类型是确定不变的，通过对象进行的函数调用将在编译时绑定到该对象所属类中的函数版本。

  当且仅当通过 **指针或引用** 调用虚函数时，才在 **运行时** 解析该调用，也只有在这种情况下对象的动态类型才有可能与静态类型不同（ **动态绑定** ）。

.. code-block:: cpp
  :linenos:

  #include <iostream>
  using namespace std;

  class Base
  {
  public:
    virtual void f(){ cout << "base" << endl; }
  };

  class Derived : public Base // 注意：这里必须为 public 继承
  {
  public:
    void f(){ cout << "derived" << endl; }
  };

  int main(int argc, char ** argv)
  {
    Derived d = Derived(); // 派生类对象
    Base* pb = &d; // 基类指针
    pb->f(); // derived

    Base b = Base(); // 基类对象
    Base& rb = b; // 基类指针
    rb.f(); // base

    return 0;
  }

.. note::

  基类中的虚函数在派生类中隐含地也是一个虚函数。当派生类覆盖了某个虚函数时，该函数在基类中的形参必须与派生类中的形参严格匹配。

  我们可以将 **基类的指针或引用** 绑定到派生类的对象上。因此，当我们使用基类指针或引用时，实际上并不清楚该指针或引用所绑定的对象的真实类型。

.. warning::

  error C2243: 'type cast' : conversion from 'Derived \*' to 'Base \*' exists, but is inaccessible.

  基类的指针和引用不能指向继承方式为 ``protected`` 与 ``private`` 的派生类对象，只能通过 ``public`` 继承。


隐藏（Hiding）
---------------------
派生类中的函数屏蔽了基类中的同名函数，不管参数列表是否相同。当参数不同时，无论基类中的函数是否被 ``virtual`` 修饰，基类函数都是被隐藏，而不是被覆盖。


参考资料
------------

1. C++中重载、重写（覆盖）和隐藏的区别

  https://blog.csdn.net/zx3517288/article/details/48976097

2. 《C++ Primer 第5版 中文版》 Page 538 -- 539。
