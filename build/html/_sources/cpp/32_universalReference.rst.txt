通用引用和右值引用
==============================

``T&&`` 有两种不同的含义。一种是右值引用，这种引用的行为就如你想象的那样：它们只能绑定右值，它们主要的存在理由是识别可能被移动的对象。
另一种含义既不是右值引用，也不是左值引用。这种引用在源代码中（ ``T&&`` ）看起来像右值引用，但是它们可以表现左值引用（即 ``T&`` ）的行为。它们的双重性质允许它们绑定右值（就像右值引用那样）和左值（就像左值引用那样）。
而且，它们可以绑定 const 或者非 const 对象，可以绑定 volatile 和非 volatile 对象，还可以绑定 const 和 volatile 同时作用的对象。
它们实际上可以绑定任何东西。这种灵活的引用称为通用引用（Universal Referense）。

出现 ``&&`` 的时候，如何判断它是右值引用还是通用引用呢？通用引用有两个条件：

- 形式必须是精确的 ``T&&`` （ ``const T&&`` 一定是右值引用）。

- ``T`` 的类型需要推导。

通用引用
-----------------

通用引用在两种语境出现。最常见的就是模板函数参数，第二个语境是 auto 声明。这两种语境有个共同点，就是出现了类型推断。

::
    
    int lvalue = 3;
    const auto&& r = lvalue; // 错误：r 是右值引用，不能通过左值初始化
    
::

    template<typename T>
    void func(const T&& p);
    
    func(lvalue);            // 错误：p 是右值引用，不能通过左值初始化

::

    template <class T, class Allocator = allocator<T>>
    class vector
    {
    public:
        void push_back(T&& x); // 右值引用，类模板实例化的时候类型参数已经确定，不存在类型推导。 
    };
    
::

    template<typename S>
    void func(std::vector<S>&& p); // p 不是通用引用。虽然存在类型推导，但推导的是 std::vector 的类型参数，而不是 T&& 中的T。


::

    template <class T, class Allocator = allocator<T> >
    class vector
    {
    public:
        template <class... Args>
        void emplace_back(Args&&... args);  // args 中的每一个参数都是是通用引用
    };
    
::

    int i = 10;
    auto&& ai = i; // 通用引用，int&
    
    const int ci = 10;
    auto&& ac = ci; // 通用引用，const int&
    
右值引用变量
----------------------

::

    Foo&& foo = Foo{10};
    
一个类型为右值引用的变量，一旦被初始化之后，临时对象的生命将被扩展，会在其被创建的 scope 内始终有效。

因而，看似 foo 被定义的类型为右值引用，但这仅仅约束它的 *初始化* ：只能从一个右值进行初始化。一旦初始化完成，它就和一个左值引用再也没有任何差别：都是一个已存在对象的 *标识* 。

::

    void stupid(Foo&& foo) 
    {
       foo.a += 10;   // 在函数体内，foo的性质与一个左值引用毫无差别
       // blah ...
    }
    
    stupid(Foo{10});  // 在执行函数体之前，进行参数初始化: Foo&& foo = Foo{10}
    
而临时对象 Foo{10} 的生命周期，会比参数变量 foo 更长。所以将 foo 看作左值引用随意访问，是没有任何风险的。

.. note::

    - 对于任何类型为右值引用的变量（也包括函数参数），只能由右值来初始化.
    
    - 一旦初始化完成，右值引用类型的变量，其性质与一个左值引用再也没有任何差别。
    
    - 类型为右值引用的变量，是一个左值，因而不能赋值给其它类型为右值引用的变量，当然也不能匹配参数类型为右值引用的函数。

参考资料
------------

1. Effective Modern C++ 条款24 区分通用引用和右值引用

2. C++11中的通用引用

  https://www.yuanguohuo.com/2018/05/25/cpp11-universal-ref/
  
3. 右值引用

  https://modern-cpp.readthedocs.io/zh_CN/latest/rvalue-ref.html
  
4. C++ 右值引用使用总结

  https://murphypei.github.io/blog/2020/02/right-reference
