拷贝控制
==============

.. highlight:: cpp

拷贝控制（copy control）
  - 拷贝构造函数（copy constructor）
  - 拷贝赋值运算符（copy-assignment operator）
  - 移动构造函数（move constructor）
  - 移动赋值运算符（move-assignment operator）
  - 析构函数（destructor）


拷贝构造函数
--------------

**拷贝构造函数的第一个参数必须是引用类型** 。

在函数调用中，具有非引用类型的参数要进行拷贝初始化。类似地，当一个函数具有非引用类型的返回类型时，返回值会被用来初始化调用方的结果。

拷贝构造函数被用来初始化 **非引用类类型** （被初始化的是类的非引用对象）参数，如果拷贝构造函数的参数不是引用类型，为了调用拷贝构造函数，
我们必须拷贝它的实参，然而拷贝实参又需要调用拷贝构造函数，如此无限循环。


如果我们没有为类定义拷贝控制函数，编译器会为我们定义一个。与合成默认构造函数不同（如果定义了其他构造函数，则需要我们再显式定义默认构造函数），
即使我们定义了其他构造函数，编译器也会为我们合成一个拷贝构造函数。


default 和 delete
---------------------

使用 ``=default``
  将拷贝控制成员定义为 ``=default`` ，显式要求编译器生成合成的版本。

    - 类内使用 ``=default`` 修饰成员的声明，则合成的函数隐式地声明为内联函数（注：定义在类内的函数自动为内联函数）。

    - 类外使用 ``=default`` 修饰成员的定义，则合成的成员不是内联函数。

    - 只能对默认构造函数或拷贝控制成员使用 ``=default`` 。

使用 ``=delete``
  在函数参数列表之后加上 ``=delete`` 定义为 **删除的函数** ：虽然有声明，但是不能以任何形式使用它们。

  将拷贝构造函数和拷贝赋值运算符定义为删除的函数，从而阻止拷贝操作。


直接初始化和拷贝初始化
-------------------------

直接初始化直接调用与实参匹配的构造函数，拷贝初始化总是调用拷贝构造函数。

::

  string dots(10, '.');         // 直接初始化
  string s(dots);               // 直接初始化

  string s2 = dots;             // 拷贝初始化
  string s3 = "999-9999";       // 拷贝初始化
  string s4 = string(100, '9'); // 拷贝初始化


.. code-block:: cpp
  :linenos:

  class ClassTest
  {
  public:
    ClassTest()
    {
      c[0] = '\0';
      cout << "ClassTest()" << endl;
    }

    ClassTest& operator=(const ClassTest &ct)
    {
      strcpy(c, ct.c);
      cout << "ClassTest& operator=(const ClassTest &ct)" << endl;
      return *this;
    }

    ClassTest(const char *pc)
    {
      strcpy(c, pc);
      cout << "ClassTest (const char *pc)" << endl;
    }

  // private:
    ClassTest(const ClassTest& ct)
    {
      strcpy(c, ct.c);
      cout << "ClassTest(const ClassTest& ct)" << endl;
    }
  private:
    char c[256];
  };


调用::

  ClassTest ct1("ab");          // 直接初始化
  // 输出： ClassTest (const char *pc)

  ClassTest ct2 = "ab";         // 拷贝初始化
  // 输出： ClassTest (const char *pc)
  // 首先调用构造函数 ClassTest(const char *pc) 函数创建一个临时对象；然后调用拷贝构造函数，把这个临时对象作为参数，构造对象ct2
  // 然而结果并没有输出 ClassTest(const ClassTest& ct)。有说法是编译器优化之后，直接匹配了 ClassTest(const char *pc)，不再调用拷贝构造函数

  ClassTest ct3 = ct1;          // 拷贝初始化
  // 输出： ClassTest(const ClassTest& ct)
  // ct1 已经存在，直接调用拷贝构造函数

  ClassTest ct4(ct1);           // 直接初始化
  // 输出： ClassTest(const ClassTest& ct)
  // ct1 已经存在，直接调用拷贝构造函数

  ClassTest ct5 = ClassTest();  // 拷贝初始化
  // 输出： ClassTest()
  // 首先调用默认构造函数产生一个临时对象；然后调用拷贝构造函数，把这个临时对象作为参数，构造对象ct5

  ct3 = ct2;                    // 赋值
  // 输出： ClassTest& operator=(const ClassTest &ct)

当把拷贝构造函数设置为 ``private`` ，ct3、ct4、ct5的初始化都无法完成。


push 和 emplace
---------------------------

在18章提到了 push 和 emplace 的区别，这里用一个例子解释。

.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Example}`

  .. code-block:: cpp
    :linenos:

    #include <iostream>
    #include <utility>  // std::move

    class Foo
    {
    public:
      Foo(std::string str) : name(str)
      {
        std::cout << "constructor" << std::endl;
      }

      Foo(const Foo& f) : name(f.name)
      {
        std::cout << "copy constructor" << std::endl;
      }

      Foo(Foo&& f) : name(std::move(f.name))
      {
        std::cout << "move constructor" << std::endl;
      }

    private:
      std::string name;
    };

    int main(int argc, char ** argv)
    {
      std::vector<Foo> v;
      int count = 10000000;
      v.reserve(count);

      {
        Foo temp("test");
        // constructor
        v.push_back(temp);// push_back(const T&)，参数是左值引用
        // copy constructor
      }

      v.clear();
      {
        Foo temp("test");
        // constructor
        v.push_back(std::move(temp));// push_back(T &&), 参数是右值引用
        // move constructor
      }

      v.clear();
      {
        v.push_back(Foo("test"));// push_back(T &&), 参数是右值引用
        // constructor
        // move constructor
      }

      v.clear();
      {
        std::string temp = "test";
        v.push_back(temp);// 构造临时对象，push_back(T &&), 参数是右值引用
        // constructor
        // move constructor
      }

      v.clear();
      {
        std::string temp = "test";
        v.emplace_back(temp);// 只有一次构造函数，不调用拷贝构造函数，速度最快
        // constructor
      }

      return 0;
    }

|

.. note::

  我们可以销毁一个移动之后的源对象（moved-from），也可以赋予它新值，但是不能使用一个移后源对象的值。

  如：上例中的 temp 被移动后，就不能再取它的值来使用。


参考资料
-------------

1.《C++ Primer 第5版 中文版》 Page 440 -- 442，449，470 -- 475。

2. C++的一大误区——深入解释直接初始化与复制初始化的区别

  https://blog.csdn.net/ljianhui/article/details/9245661

3. C++11使用emplace_back代替push_back

  https://blog.csdn.net/yockie/article/details/52674366
