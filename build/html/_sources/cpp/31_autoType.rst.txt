类型推导
==============

C++ 11 引入了 **auto** 和 **decltype** 关键字，使用它们可以在编译期就推导出变量或者表达式的类型，方便开发者编码也简化了代码。

auto
-----------

auto 让编译器通过初始值来进行类型推演，从而获得定义变量的类型，所以 auto 定义的变量必须有初始值。

auto 会忽略引用。当引用被用作初始值的时候，真正参与初始化的其实是引用对象的值，此时编译器以引用对象的类型作为 auto 的类型。

auto 一般会忽略掉顶层 const，但底层 const 会被保留下来。如果希望推断出的 auto 类型是一个顶层 const，需要显示声明。

.. code-block:: cpp
    :linenos:
    
    int i = 0;
    int& ri = i;
    const int ci = i;
    auto j = ri; // int
    auto pi = &ci; // const int* ，底层 const 
    const auto pc = &ci; // const int* const

decltype
--------------

有的时候我们希望从表达式中推断出要定义变量的类型，但却不想用表达式的值去初始化变量。decltype 的作用是选择并返回操作数的数据类型，在此过程中，编译器只是分析表达式并得到它的类型，却 **不实际计算表达式的值** 。

decltype 处理顶层 const 、引用的方式与 auto 有些许不同，如果 decltype 使用的表达式是一个变量，则 decltype 返回该变量的类型（包括顶层 const 和引用在内）。

.. code-block:: cpp
    :linenos:
    
    const int ci = 0;
    const int& ri = ci;
    decltype(ci) x = 0; // const int
    decltype(ri) y = x; // const int&
    decltype(ri) z; // 错误，引用必须初始化


有些表达式会使得 decltype 返回一个引用类型，当这种情况发生时，意味着该表达式的结果对象能作为一条赋值语句的左值。

.. code-block:: cpp
    :linenos:
    
    int i = 0;
    int* p = &i;
    decltype(i+4) j; // int 
    decltype(i=5) k = i; // int&，赋值语句返回引用类型，这里的赋值不会实际执行。
    decltype(*p) m = i; // int&
    cout << i << endl; // 0
    i = 6;
    cout << k << " " << m << endl; // 6 6 

如果表达式的内容是解引用操作，则 decltype 将得到引用类型。正如我们所熟悉的那样，解引用指针可以得到指针所指对象，而且还可以给这个对象赋值，因此 ``decltype(*p)`` 的结果类型就是 ``int&``  。

对于 decltype 所用的表达式来说，如果变量名加上一对括号，则得到的类型与不加上括号的时候可能不同。
如果 decltype 使用的是一个不加括号的变量，那么得到的结果就是这个变量的类型；但是如果给这个变量加上一层或多层括号，那么编译器会把这个变量当作一个表达式看待，变量是一个可以作为左值的特殊表达式，所以这样的 decltype 就会返回引用类型。

.. code-block:: cpp
    :linenos:
    
    int i = 0;
    decltype(i) j;
    decltype((i)) ri = i; // int&
    
利用 decltype 来推断类型还可以减少类的定义，下面两段代码是等价的：

.. code-block:: cpp
    :linenos:
    
    struct Comparator
    {
        bool operator()(int i, int j)
        {
            return i%10 > j%10;
        }
    };
    vector<int> vec{11,24,8,73,93,36};
    priority_queue<int, vector<int>, Comparator> pq(vec.begin(), vec.end()); // 11 73 93 24 36 8 
    
    
.. code-block:: cpp
    :linenos:
    
    vector<int> vec{11,24,8,73,93,36};
    auto comp = [](int i, int j){return i%10 > j%10;};
    priority_queue<int, vector<int>, decltype(comp)> pq(vec.begin(), vec.end(), comp); // 11 73 93 24 36 8 
    

后置返回类型
-------------------

在C++ 11中，函数声明 ``double foo(int i);`` 可以写成 ``auto foo(int i) -> double;`` 。

泛型编程场景中，返回值类型后置语法结合 decltype 用于自动推导返回值类型。

.. code-block:: cpp
    :linenos:
    
    template<typename T, typename U>
    auto add(T x, U y) -> decltype(x + y)
    {
        return x + y;
    }

参考资料
---------------

1. 《C++ Primer 第5版 中文版》 Page 61 – 63。

2. C++11：后置返回类型

  https://hijk.tech/cpp/cpp11/trailing_return_type/
