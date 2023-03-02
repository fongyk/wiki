指针与引用
====================

不同点
------------

**1**. 指针是一个对象，有存储的 **值** 和 **地址** ，存储的数据类型是数据的地址；非常量指针可以被重新赋值，指向另一个对象。引用是对象的别名，必须初始化并总是指向（代表）最初绑定的那个对象，对对象及其引用进行取地址操作得到的结果相同。

.. code-block:: cpp
  :linenos:

  #include <iostream>
  using namespace std;

  int main(int argc, char ** argv)
  {
      int k = 1;
      int* pk = &k;
      int& rk = k;

      cout << "&k:" << &k << endl;   // 0029FC44
      cout << "k:" << k << endl;     // 1

      cout << "&pk:" << &pk << endl; // 0029FC68
      cout << "pk:" << pk << endl;   // 0029FC44 (pk = &k)
      cout << "*pk" << *pk << endl;  // 1

      cout << "&rk:" << &rk << endl; // 0029FC44 (&rk = &k)
      cout << "rk:" << rk << endl;   // 1

      return 0;
  }


**2**. 指针可以有多级，但是引用只能是一级（不存在 *引用的引用* ）。

**3**. 有 ``null pointer`` ，没有 ``null reference`` ，故使用前无需检查是非为空。

.. code-block:: cpp
    :linenos:

    void rValue(const int &x)
    {
        cout << x << endl;
    }

    void pValue(const int* p)
    {
        if(p) cout << *p << endl;
    }

一个例子：

.. code-block:: cpp
    :linenos:

    string s1("nancy");
    string s2("candy");
    string& rs = s1;
    string* ps = &s2;
    rs = s2; // rs仍指向s1，但是s1值变为"candy"。
    ps = &s2; // ps指向s2，s1无变化


函数返回对象
---------------

考虑一个有理数的类，内含一个函数用来计算两个有理数的乘积。

.. code-block:: cpp
  :linenos:

  class Rational
  {
  friend
  const Rational operator*(const Rational& lhs, const Rational& rhs);
  // const Rational& operator*(const Rational& lhs, const Rational& rhs);

  public:
      Rational(int _n = 0, int _d = 0): n(_n), d(_d){}
  private:
      int n, d;
  };

  inline const Rational operator*(const Rational& lhs, const Rational& rhs)
  {
      return Rational(lhs.n * rhs.n, lhs.d * rhs.d);
  }
  // 这样做需要承担返回值的构造成本和析构成本
  // 但行为是正确的


- **绝对不要返回指向一个 local stack 对象的 pointer 或 reference。** 局部变量会在函数返回后被销毁，因此被返回的引用就成为了“无所指”的引用，程序会进入未知状态。

  .. code-block:: cpp
    :linenos:

    const Rational& operator*(const Rational& lhs, const Rational& rhs)
    {
        Rational result(lhs.n * rhs.n, lhs.d * rhs.d); // result 是 local 对象
        return result;
    }

- **绝对不要返回指向一个 heap-allocated 对象（new）的 reference。** 虽然不存在局部变量的被动销毁问题，但是面临其它局面：被函数返回的引用只是作为一个临时变量出现，而没有被赋给一个实际的变量，那么无法获取该引用背后的指针，则该引用所指向的空间（由new分配）就无法释放，造成 memory leak。

  .. code-block:: cpp
    :linenos:

    const Rational& operator*(const Rational& lhs, const Rational& rhs)
    {
        Rational* result = new Rational(lhs.n * rhs.n, lhs.d * rhs.d); // result 是 heap-allocated 对象
        return *result;
    }

    int main()
    {
        Rational w, x, y, z;
        w = x * y * z; // 这里使用了两次 new
        return 0;
    }
    // 主函数结束时，已经执行了4 + 2次构造函数，4 次析构函数

- **绝对不要返回指向一个 local static 对象的 pointer 或 reference，因为有可能同时需要多个这样的对象。**



参考资料
------------

1. 《Effective C++》条款 21。

2. C++ 把引用作为返回值

  https://www.runoob.com/cplusplus/returning-values-by-reference.html

3. 在函数内new一个对象，如果作为引用返回，是不是就可以不用delete了？

  https://www.zhihu.com/question/33971459
