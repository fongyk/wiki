const和constexpr
=======================

顶层const与底层const
--------------------------

由于指针本身是一个对象，它有可以指向另一个对象，因此，指针本身是不是常量以及指针所指对象是不是常量就是两个相互独立的问题。

**顶层const** （top-level const）表示 **对象本身** 是常量，**底层const** （low-level const）与指针或引用等复合类型的 **基本类型** 部分有关。
对指针而言，既可以是顶层const，也可以是底层const。

.. code-block:: cpp
  :linenos:

  int i = 0;
  int *const p1 = &i; // 顶层const，不能改变 p1 的值

  const int ci = 42; // 顶层const，不能改变 ci 的值
  const int *p2 = &ci;  // 底层const，可以改变 p2 的值，但不能通过 p2 改变 ci 的值。
  const int *const p3 = p2;  // 顶层const + 底层const

  const int &r = ci; // 用于声明引用的const都是底层const，r 不能改变 i

执行拷贝操作，被拷贝对象的顶层const属性不受影响。而对于底层const，要求拷入和拷出的对象具有相同的底层const属性，或在两个对象的数据类型能够转换。

.. code-block:: cpp
  :linenos:

  // 承接上例的定义

  i = ci; // 正确
  p2 = p3; // 正确

  int *p = p3; // 错误，p 没有底层const，防止通过 p 间接改变 p3 所指对象。
  p2 = &i; // 正确，int* 能转换为 const int*

  int &r1 = ci; // 错误，r1 没有底层const
  const int &r2 = i; // 正确，const int& 可以绑定到普通 int

总结：可以使用 **非常量对象** 初始化一个 **底层const对象** ，但是不能使用 **底层const对象** 初始化一个 **非常量对象** 。同时，一个普通的引用
必须使用同类型的对象初始化。同样的初始化规则可以应用到函数的 **参数传递** 上。

const形参和实参
---------------------

使用实参初始化形参时，会 **忽略掉顶层const** ，换句话说，形参的顶层const被忽略了。因此，当形参有顶层const时，传给它常量对象或非常量对象都是可以的 。

.. code-block:: cpp

  void fcn(const int i) {/* */}
  void fcn(int i) {/* */} // 重复定义了 fcn

上例中其实重复定义了fcn，而不是重载。调用fcn时，既可以传入const int对象，也可以传入int对象。
反之，如果参数类型是int，也可传入const int对象（传值调用，函数拷贝了实参）。


const成员函数
---------------

默认情况下，``this`` 指针的类型是指向 **类类型非常量版本的常量指针** ，即 ``ClassName *const`` 。尽管 ``this`` 是隐式的，但它仍然需要遵守初始化规则。
意味着在默认情况下，我们不能把 ``this`` 绑定到一个常量对象上。这一情况也使得我们不能在一个常量对象上调用普通的成员函数。通过把关键字 const 放在成员函数参数列表后面，
定义该成员函数为 **常量成员函数** 。

.. highlight:: cpp

::

  class Sale
  {
      double avg_price() const;
  };


此时，``this`` 成为指向常量的指针，所以常量成员函数 **不能改变调用它的对象的内容** 。

.. note::

  常量对象、常量对象的引用和指针都只能调用常量成员函数。

constexpr
--------------

constexpr 用于指示常量表达式，在编译阶段就能对该表达式求值。const 变量的值可以在编译时确定，也可以在运行时确定，但 constexpr 变量的值必须在编译时就能确定。

定义 constexpr 变量的时候，变量的类型只能是基本数据类型、指针和引用，而不能是其它标准库类型；对于自定义类型，constexpr 构造函数的函数体必须为空，所有成员变量的初始化都放到初始化列表中。

constexpr 函数的参数和返回值必须是字面值类型。
要是 constexpr 函数所使用的变量其值只能在运行时确定，那么 constexpr 函数就和一般的函数没区别。

constexpr 声明的指针仅表示指针本身是常量，因此不能直接指向常量对象，需要增加 const 声明。
同样地，constexpr const 声明的引用才能绑定常量对象；只用 constexpr 声明的引用绑定非常量对象，是可以对该对象进行修改的。

.. code-block:: cpp
  :linenos:

  class Circle
  {
  public:
      constexpr Circle(int _x, int _y, int _radius): x(_x), y(_y), radius(_radius){}
      constexpr double getArea()
      {
          return 3.14 * radius * radius;
      }
  private:
      int x; 
      int y;
      int radius;
  };

  const Circle circle_unit = Circle(0, 0, 1.0);
  const double area_unit = circle_unit.getArea();

.. code-block:: cpp
  :linenos:

  constexpr int sum(int a, int b)
  {
      return a + b;
  }
  const int N = 10;
  int arr[sum(N, 2*N)];

  int var = 5;
  const int cv = 10;
  constexpr int ce = 8;

  int main()
  {
      // 可以用 const 指针指向 constexpr 对象
      const int* p = &ce;
      
      // 去掉 const 关键字则编译出错
      constexpr const int* pcv = &cv;
      constexpr const int* pce = &ce;
      constexpr const int& rcv = cv;
      constexpr const int& rce = ce;
      cout << *p << ends << *pcv << ends << *pce << ends << rcv << ends << rce << endl;
      
      constexpr int &r = var;
      r = -5;
      cout << var << endl; // -5
      
      int a, b;
      cin >> a >> b;
      cout << sum(a, b) << endl; // 运行时计算

      return 0;
  }

参考资料
----------------

1.《C++ Primer 第5版 中文版》 Page 57 -- 58， Page 190 -- 191，Page 231 -- 232。
