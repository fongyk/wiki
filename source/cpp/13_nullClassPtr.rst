空类指针
=============

类的成员函数并不与特定对象绑定，所有成员函数共用一份成员函数体，当程序编译后，成员函数的地址即已经确定。
那为什么同一个类的不同对象调用对应成员函数可以出现不同的结果呢？答案就是 ``this`` 指针。
共有的成员函数体之所以能够把不同对象的数据区分开来，靠的是隐式传递给成员函数的 ``this`` 指针，
成员函数中对成员变量的访问都是转化成 **“this->数据成员”** 的方式。
因此，从这一角度说，成员函数与普通函数一样，只是多了一个隐式参数，即指向对象的 ``this`` 指针。

空类指针调用成员函数
-----------------------

.. code-block:: cpp
  :linenos:

  class TestNullPtr
  {
  public:
    void print()
    {
      cout << "print" << endl;
    }

    void getA()
    {
      cout << a << endl;
    }

    void setA(int x)
    {
      a = x;
    }

    virtual test()
    {
      cout << "test" << endl;
    }

  private:
    int a = 100;
  };

  TestNullPtr* ptr = nullptr;
  ptr->print(); // 运行成功
  ptr->getA(); // 编译成功，运行失败
  ptr->setA(); // 编译成功，运行失败
  ptr->test(); // 编译成功，运行失败

上例中， ``ptr->getA()`` 和 ``ptr->setA()`` 都试图访问成员变量，然而 ``this`` 指针为空，导致运行失败。
另外，虚函数的特性是动态绑定，运行时根据指针或引用绑定的对象是基类对象还是派生类对象调用相关函数，空指针显然会导致错误。

参考资料
-------------

1. C++空指针调用成员函数

  https://www.jianshu.com/p/45cf10150e6b
