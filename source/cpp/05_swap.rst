交换函数
=======================

.. highlight:: cpp

**1**. 库函数，包含在头文件 ``<utility>`` 中。

.. code:: cpp

    #include <utility>
    using std::swap;
    swap(a, b);

.. code-block:: cpp
    :linenos:

    // swap algorithm example (C++11)
    #include <iostream>     // std::cout
    #include <utility>      // std::swap

    int main ()
    {
        int x = 10, y = 20;                  // x:10 y:20
        std::swap(x, y);                  // x:20 y:10

        int foo[4];                      // foo: ?  ?  ?  ?
        int bar[] = {10, 20, 30, 40};       // foo: ?  ?  ?  ?    bar: 10 20 30 40
        std::swap(foo, bar);              // foo: 10 20 30 40   bar: ?  ?  ?  ?

        std::cout << "foo contains:";
        for (int i: foo) std::cout << ' ' << i;
        std::cout << '\n';

        return 0;
    }

**2**. 指针。

.. code-block:: cpp
    :linenos:

    templtate<class T>
    void Swap(T *x, T *y)
    {
        T tmp = *x;
        *x = *y;
        *y = tmp;
    }

**3**. 引用。

.. code-block:: cpp
    :linenos:

    templtate<class T>
    void Swap(T &x, T &y)
    {
        T tmp = x;
        x = y;
        y = tmp;
    }

**4**. 异或。适用于整型/字符/枚举类型，浮点型不适用。 ``SWAP(a, a)`` 和 ``Swap(a, a)`` 会导致 ``a=0`` 或 ``a=''`` 。

.. code-block:: cpp
    :linenos:

    #define SWAP(a, b) a^=b^=a^=b;

    template<class T>
    void Swap(T& a, T& b)
    {
    	a = a ^ b;
    	b = a ^ b;
    	a = a ^ b;
    }


**4**. 赋值。受编译器影响，先执行 ``a+b`` 还是先执行 ``b=a`` 。

.. code:: cpp

    #define SWAP(a, b) a=a+b-(b=a);

**5**. 加减。无需申请额外空间。

.. code-block:: cpp
    :linenos:

    templtate<class T>
    void Swap(T &x, T &y)
    {
        x = x + y;
        y = x - y;
        x = x - y;
    }


.. note::

  如果存在类型特定的 swap 版本（即为某个类定制的swap），其匹配程度会优于 std 中定义的版本。

  ::

    using std::swap; // 声明

    void swap(Foo& a, Foo&b); // 声明

    Foo a, b;

    swap(a, b); // 此处匹配的是定制版本的 swap

参考资料
------------

1. C++ reference

  http://www.cplusplus.com/reference/utility/swap
