交换函数swap
=======================

.. highlight:: cpp

**1**. 库函数，包含在头文件 ``<algorithm>`` 中。

.. code:: cpp

    std:: swap(a, b);

**2**. 指针。

.. code-block:: cpp
    :linenos:

    templtate<class T>
    void swap(T *x, T *y)
    {
        T tmp = *x;
        *x = *y;
        *y = tmp;
    }

**3**. 引用。

.. code-block:: cpp
    :linenos:

    templtate<class T>
    void swap(T &x, T &y)
    {
        T tmp = x;
        x = y;
        y = tmp;
    }

**4**. 异或。适用于整型/字符/枚举类型，浮点型不适用。 ``swap(a, a)`` 会导致 ``a=0`` 。

.. code:: cpp

    #define swap(a, b) a^=b^=a^=b;

**4**. 赋值。受编译器影响，先执行 ``a+b`` 还是先执行 ``b=a`` 。

.. code:: cpp

    #define swap(a, b) a=a+b-(b=a);

**5**. 加减。无需申请额外空间。

.. code-block:: cpp
    :linenos:

    templtate<class T>
    void swap(T &x, T &y)
    {
        x = x + y;
        y = x - y;
        x = x - y;
    }
