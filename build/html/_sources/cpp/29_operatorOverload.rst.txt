运算符重载
=================

重载规则
---------------

- 不能重载的运算符：成员运算符 ``.`` ，条件运算符 ``? :`` ，长度运算 ``sizeof`` ，成员指针访问运算符 ``.*`` ，域解析运算符 ``::`` 。主要是出于对安全的考虑：如果这些运算符也可以被重载的话，将会造成危害或破坏安全机制，使得事情变得困难或混淆现有的习惯。比如，如果成员运算符 ``.`` 被重载，就不能用普通的方法访问成员，只能通过指针和 ``->`` 访问。

- 必须以成员函数的形式重载的运算符：箭头运算符 ``->`` ，下标运算符 ``[]`` ，函数调用运算符 ``()`` （用于定义函数对象类），赋值运算符 ``=`` 。

- 重载不能改变运算符的优先级和结合性。

- 运算符重载函数不能有默认的参数，否则就改变了运算符操作数的个数。

- 以全局函数的形式重载，是为了保证该运算符的操作数能够被 **对称的处理** 。比如， ``a + b`` 和 ``b + a`` 的行为应该是一样的，如果定义成类成员函数：``A operator+(const B b)`` ，``a + b`` 被转换成 ``a.operator+(b)`` ，而 ``b + a`` 被转换成 ``b.operator+(a)`` ，它们的行为是不一样的。

- 如果需要访问非public成员，全局函数需要在类内声明为友元（friend）。

运算符重载函数的参数个数取决于：

- 运算符是一元运算符还是二元运算符。

- 运算符重载函数是全局函数还是成员函数。对于全局函数，一元运算符有一个参数，二元运算符有两个参数；对于成员函数，一元运算符没有参数，二元运算符有一个参数，类的 ``this`` 指针会被绑定到运算符的 **左侧** 运算对象，成员运算符函数的显式参数一般少一个。new/delete 例外，两种重载形式下参数个数是一样的。

.. code-block:: cpp
  :linenos:

  // 复数类
  class Complex
  {
  public:  //构造函数
      Complex(double real=0.0, double imag=0.0): m_real(real), m_imag(imag){}
  public:  //运算符重载
      //以全局函数的形式重载
      friend Complex operator+(const Complex &c1, const Complex &c2);
      friend Complex operator-(const Complex &c1, const Complex &c2);
      friend Complex operator*(const Complex &c1, const Complex &c2);
      friend Complex operator/(const Complex &c1, const Complex &c2);
      friend bool operator==(const Complex &c1, const Complex &c2);
      friend bool operator!=(const Complex &c1, const Complex &c2);
      friend istream & operator>>(istream &in, complex &A);
      friend ostream & operator<<(ostream &out, complex &A);
      //以成员函数的形式重载
      Complex & operator+=(const Complex &c);
      Complex & operator-=(const Complex &c);
      Complex & operator*=(const Complex &c);
      Complex & operator/=(const Complex &c);
  public:
      double real() const{ return m_real; }
      double imag() const{ return m_imag; }
  private:
      double m_real;  //实部
      double m_imag;  //虚部
  };

下标运算符 []
------------------

为了适应 const 对象，需要重载下面两种函数 ::

    返回值类型& operator[] (参数); // 参数一般为无符号整型
    const 返回值类型& operator[] (参数) const;
    
因为 const 对象只能调用 const 成员函数。

通过下标访问数组中的元素并不具有检查边界溢出功能，我们可以通过重载实现该功能（抛出异常）。

自增和自减
------------------

::

    ClassName& operator++(); // 前缀++，返回的是引用
    const ClassName operator++(int); // 后缀++，返回的是临时变量
    ClassName& operator--(); // 前缀--
    const ClassName operator--(int); // 后缀--

后缀形式有一个 int 类型参数，当函数被调用时，编译器传递一个 0 作为 int 参数的值给该函数，实际上后缀操作符并没有使用它的参数，只是用来区分前缀与后缀函数调用。

后缀操作符最好返回一个 const 对象，用于杜绝产生以下形式的代码 :: 

    i++++; // same as i.operator++(0).operator++(0);

.. code-block:: cpp
  :linenos:

  class A
  {
  public:
      A(int _m=10): m(_m){}
      
      A& operator++();
      const A operator++(int);
      A& operator--();
      const A operator--(int);
      
      int m;
  };

  A& A::operator++()
  {
      m++;
      return *this;
  }
  A& A::operator--()
  {
      m--;
      return *this;
  }
  const A A::operator++(int)
  {
      A _a = *this;
      this->m ++;
      return _a;
  }
  const A A::operator--(int)
  {
      A _a = *this;
      this->m --;
      return _a;
  }

  int main()
  {
      A a;
      A b = ++a;
      A c = a++;
      cout << a.m << " " << b.m << " " << c.m << endl; // 12 11 11
      a = c--;
      c = --b;
      cout << a.m << " " << b.m << " " << c.m << endl; // 11 10 10
      return 0;
  }

>> 和 <<
-----------------------

C++ 的 I/O stream 对象不可拷贝，形参和返回值都是引用。流对象形参不能声明为 const，因为流的缓冲成员（buffer）需要改变。
返回引用有个好处是可以连续输入/输出（ ``cout << a << b;`` ）。 

由于 ``>>`` 和 ``<<`` 左侧对象是流对象（cin、cout等），而不是自定义的类对象本身，因此只能重载为全局函数。

.. code-block:: cpp
  :linenos:

  istream& operator>>(istream &in, complex &A)
  {
      in >> A.m_real >> A.m_imag;
      return in;
  }

  ostream& operator<<(ostream &out, complex &A)
  {
      out << A.m_real <<" + "<< A.m_imag <<" i ";
      return out;
  }

new 和 delete
--------------------

内存管理运算符 new、new[]、delete 和 delete[] 也可以进行重载，其重载形式既可以是类的成员函数，也可以是全局函数。一般情况下，内建的内存管理运算符就够用了，只有在需要自己管理内存时才会重载。
 
new 表达式实际完成了三件事：

- 调用 operator new 或 operator new[]，作用是分配一块足够大的内存空间以便存储特定类型的对象。

- 执行构造函数，在这块内存上构造对象。

- 返回一个带类型的指针，指向这块内存。

delete 表达式完成了两件事：

- 调用指针所指对象的析构函数。

- 调用 operator delete 或 operator delete[] 释放内存。

在重载 new 或 new[] 时，无论是作为成员函数还是作为全局函数，它的第一个参数必须是 size_t 类型，表示的是要分配空间的大小；对于 new[] 的重载函数而言，表示所需要分配空间的总和。这个参数由编译器产生并传递给我们。

注意，new 的返回值是类型 ``void*`` ，而不是指向任何特定类型的指针。该操作符本身做的是分配内存，而不是完成一个对象构造。

为一个类重载 new 和 delete 的时候，尽管不必显式使用 ``static`` ，但是实际上仍是在创建 ``static`` 成员函数。

如果类中没有定义 new 和 delete 的重载函数，那么会自动调用内建的 new 和 delete 运算符。

.. code-block:: cpp
  :linenos:

  class A
  {
  public:
      A(){cout << "+A" << endl;}
      ~A(){cout << "~A" << endl;}
      
      void* operator new(size_t sz)
      {
          cout << "A::new " << sz << " bytes" << endl;
          void* m = malloc(sz);
          if(!m) cout << "out of memory" << endl;
          return m;
      }
      void operator delete(void* m)
      {
          cout << "A::delete" << endl;
          free(m);
      }
      void* operator new[](size_t sz)
      {
          cout << "A::new[] " << sz << " bytes" << endl;
          void* m = malloc(sz);
          if(!m) cout << "out of memory" << endl;
          return m;
      }
      void operator delete[](void* m)
      {
          cout << "A::delete[]" << endl;
          free(m);
      }
  private:
      int a[10];
  };
  int main()
  {
      A* a = new A();
      delete a;
      
      A* arr = new A[3];
      delete[] arr;

      return 0;
  }

输出 ::

  A::new 40 bytes
  +A
  ~A
  A::delete
  A::new[] 128 bytes
  +A
  +A
  +A
  ~A
  ~A
  ~A
  A::delete[]


参考资料
--------------

1. C++运算符重载

  http://c.biancheng.net/cpp/biancheng/cpp/rumen_10/

2. 重载new和delete运算符

  https://www.cnblogs.com/xiangtingshen/p/10970903.html
