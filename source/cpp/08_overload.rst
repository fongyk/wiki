重载、覆盖、隐藏
=====================

重载（Overloading）
-------------------
同一可访问区内被声明的几个具有不同参数列表（参数个数，参数类型，参数顺序）的同名函数。不关心函数返回类型。

.. note::

  函数参数可以有默认值。有默认值的参数必须放在形参表列中的最右端（类似于 python 的键值对参数）。默认值可以是全局变量、全局常量，甚至是函数调用。

  在使用带有默认参数的函数时有两点要注意：

  - 如果函数的定义在函数调用之前，则应在函数定义中给出默认值；如果函数的定义在函数调用之后，则在函数调用之前需要有函数声明，此时必须在函数声明中给出默认值，在函数定义中不给出默认值。

  - 一个函数不能既作为重载函数，又作为有默认参数的函数。因为当调用函数时如果少写一个参数，系统无法判定是调用重载函数还是调用有默认参数的函数，出现二义性。

覆盖（Overriding）
----------------------
基类中被重写的函数，用 ``virtual`` 修饰。派生类重写的函数与被重写的函数保持同样的 **函数名、参数列表、返回类型** 。

使用 ``virtual`` 的同时，配合使用 ``override`` 关键字来说明派生类中的虚函数。这么做的好处是使得程序员的意图更加清晰（即：希望覆盖基类中的虚函数），同时让编译器发现错误。
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
  我们把具有继承关系的多个类型称为多态类型，因为我们能够使用这些类型的“多种形式”而无须在意它们的差异。引用或指针的静态类型与动态类型
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
    Base& rb = b; // 基类引用
    rb.f(); // base

    return 0;
  }


抽象基类与纯虚函数
  - 纯虚函数无须定义（非要定义的话，必须发生在类外部），在该函数的声明语句中（分号之前）加入 ``= 0`` 就可以将一个虚函数声明为纯虚函数。

  - 含有纯虚函数的类是抽象基类。抽象基类负责声明接口，派生类负责覆盖该接口。如果派生类不给出对应基类中纯虚函数的定义，该派生类也是一个抽象基类。

  - 不能直接创建抽象基类的对象。


.. note::

  基类中的虚函数在派生类中隐含地也是一个虚函数。当派生类覆盖了某个虚函数时，该函数在基类中的形参必须与派生类中的形参严格匹配。

  我们可以将 **基类的指针或引用** 绑定到派生类的对象上。因此，当我们使用基类指针或引用时，实际上并不清楚该指针或引用所绑定的对象的真实类型。

.. note::

  构造函数 **不能声明** 为虚函数：一方面，创建一个对象时总要明确指定对象的类型。另一方面，虚函数对应一个指向虚函数表的指针（vptr），在创建对象之前，
  vptr不存在，不可能完成动态绑定。

  析构函数 **可以声明** 为虚函数：当基类指针指向派生类，使用基类指针删除对象时，如果析构函数不定义成虚函数，派生类中派生的部分无法完成析构。

  构造函数 **不要调用** 虚函数。在基类构造的时候，虚函数是非虚，不会走到派生类中，即采用的静态绑定。显然，当我们构造一个子类的对象时，先调用基类的构造函数去构造子类中基类部分，此时子类部分还没有构造、初始化。
  如果在构造中调用虚函数，可能会调用一个还没有被初始化的对象，这是很危险的。

  析构函数 **不要调用** 虚函数。析构的时候，首先调用子类的析构函数，析构掉对象的子类部分，然后调用基类的析构函数析构基类部分。
  如果在基类的析构函数里面调用虚函数，会导致其调用已经析构了的子类对象里面的函数，这是非常危险的。

  总而言之：在运行构造函数或者析构函数时，对象都是不完整的，这种情况下的虚函数调用不会调用到外层派生类的虚函数。

.. warning::

  error C2243: 'type cast' : conversion from 'Derived \*' to 'Base \*' exists, but is inaccessible.

  基类的指针和引用不能指向继承方式为 ``protected`` 与 ``private`` 的派生类对象，只能通过 ``public`` 继承。


隐藏（Hiding）
---------------------

派生类中的函数屏蔽了基类中的同名函数。
当参数列表不同时，无论基类中的函数是否被 ``virtual`` 修饰，基类函数都是被隐藏，而不是被覆盖；
当参数列表相同，而基类中的函数没有被 ``virtual`` 修饰，则基类函数也被隐藏。

通过基类指针调用非虚函数，调用的是基类版本（若基类中没有定义该函数则编译报错）；
通过派生类指针调用非虚函数，调用的是派生类版本（若派生类中没有定义该函数，则调用的是基类版本）。
因此，调用非虚函数只与指针类型有关。
如果基类/派生类调用的非虚函数内部又调用了虚函数，则该虚函数的调用会发生动态绑定。


.. note::

  C++ 三大特性：
    - **封装（Encapsulation）** ：类是支持数据封装的工具，对象是数据封装的实现。在封装中，还提供一种对数据访问的控制机制，使得一些数据被隐藏在封装体内，因此具有隐藏性；封装体与外界进行信息交换是通过操作接口进行的。这种访问控制机制体现在类的成员可以有公有成员（public），私有成员（private），保护成员（protected）。

    - **继承（Inheritance）** ：一个类可以根据需要生成它的派生类，派生类还可以再生成派生类。派生类继承基类的成员，还可以定义自己的成员。继承是实现抽象和共享的一种机制。

    - **多态（Polymorphism）** ：一个接口，多种实现。多态性表现在：函数重载、虚函数。


例子
-----------

虚析构函数
^^^^^^^^^^^^^^

删除一个指向派生类对象的基类指针时，需要虚析构函数。

.. code-block:: cpp
  :linenos:

  #include <iostream>
  using namespace std;

  class A
  {
  public:
    ~A();
  // virtual ~A();
  };
  A::~A()
  {
    cout << "delete A ";
  }

  class B : public A
  {
  public:
    ~B();
  };
  B::~B()
  {
    cout << "delete B ";
  }

基类析构函数未加virtual：

.. code-block:: cpp
  :linenos:

  A *pa = new B();
  delete pa;
  // 输出： delete A

  B *pb = new B();
  delete pb;
  // 输出： delete B delete A

基类析构函数加virtual：

.. code-block:: cpp
  :linenos:

  A *pa = new B();
  delete pa;
  // 输出： delete B delete A

  B *pb = new B();
  delete pb;
  // 输出： delete B delete A


析构顺序
^^^^^^^^^^^^^^^

.. code-block:: cpp
  :linenos:

  #include <iostream>
  using namespace std;

  class A
  {
  public:
    A() {  cout << "create A" << endl;  }

    A(A &obj) {  cout << "copy-construct A" << endl;  }

    ~A() {  cout << "~A" << endl;  }
  };

  class B: public A
  {
  public:
    B(A &a): _a(a) {  cout << "create B" << endl;  }

    ~B() {  cout << "~B" << endl;  }
  private:
    A _a;
  };

  int main(void)
  {
    A a;

    B b(a);

    cout << "-----------" << endl;

    return 0;
  }

运行结果::

  create A
  create A
  copy-construct A
  create B
  -----------
  ~B
  ~A
  ~A
  ~A

创建派生类对象时，调用构造函数的顺序如下:

  - 先是父类的构造函数；（create A）
  - 然后如果类成员变量中有某类（可能是父类，也可能不是）的对象，调用其相应的构造函数；（create A）
  - 最后调用派生类自身的构造函数。（copy-construct A, create B）

析构函数的调用顺序正好相反。

.. code-block:: cpp
  :linenos:

  #include <iostream>
  using namespace std;
  class A
  {
  public:
    A()  {  cout<<"create A"<<endl;   }

    A(const A& other) { cout<<"copy A"<<endl;} // 拷贝构造函数

    ~A() {  cout<<"~A"<<endl;   }
  };
  class C
  {
  public:
    C()  {  cout<<"create C"<<endl;   }

    C(const A& other) { cout<<"copy C"<<endl;} // 拷贝构造函数

    ~C() {  cout<<"~C"<<endl;   }
  };
  class B:public A
  {
  public:
    B() {  cout<<"create B"<<endl;  }

    ~B() {  cout<<"~B"<<endl;  }
  private:
    C _c;
  };

  int main(void)
  {
    B b;
    cout<<"-----------"<<endl;
    return 0;
  }

运行结果::

  create A
  create C
  create B
  -----------
  ~B
  ~C
  ~A

对象数组的析构
^^^^^^^^^^^^^^^

数组的多态会导致未定义的行为，不管析构函数是否声明为虚函数。所以在对数组元素执行析构时，还是要用 **派生类的指针** 来 delete 。

参考：https://www.nowcoder.com/profile/3704231/myFollowings/detail/8528425。

.. code-block:: cpp
  :linenos:

  #include <iostream>
  using namespace std;

  class A
  {
  public:
    A() { cout << "A" << ends; }
    ~A() { cout << "~A" << ends; }
  };
  class B:public A
  {
  public:
    B() { cout << "B" << ends; }
    ~B() { cout << "~B" << ends; }
  };

  int main(void)
  {
    A *arrA = new B[2];
    delete [] arrA;
    // 输出： A B A B ~A ~A

    B *arrB = new B[2];
    delete [] arrB;
    // 输出： A B A B ~B ~A ~B ~A

    return 0;
  }


.. note::

  直接定义类的指针（不使用 new）和引用并不会调用构造函数。


参考资料
------------

1. C++中重载、重写（覆盖）和隐藏的区别

  https://blog.csdn.net/zx3517288/article/details/48976097

2. 《C++ Primer 第5版 中文版》 Page 538 -- 540。
