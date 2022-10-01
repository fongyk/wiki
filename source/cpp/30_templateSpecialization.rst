模板特化
============

模板特化（Template Specialization）是指模板参数在某种特定类型下的具体实现。模板特化有时也称为模板的具体化，分为函数模板特化和类模板特化。

模板偏特化（Template Partitial Specialization）主要分为两种：一种是对部分模板参数进行全特化；另一种是对模板参数特性进行特化，包括将模板参数特化为指针、引用或是另外一个模板类。

函数模板特化
-------------

使用普通函数重载和模板特化可以实现相同的函数功能，他们的不同之处在于： 

- 如果使用普通重载函数，那么不管是否发生实际的函数调用，编译过程中都会在目标文件中生成该函数的二进制代码。而如果使用模板的特化版本，除非发生函数调用，否则不会在目标文件中包含特化模板函数的二进制代码。这符合函数模板的“惰性实例化”准则。 

- 如果使用普通重载函数，那么在分离编译模式下，应该在各个源文件中包含重载函数的声明，否则在某些源文件中就会使用模板函数，而不是重载函数。

.. code-block:: cpp
    :linenos:

    template<class T>
    void foo(T a)
    {
        cout << "template" << endl;
    }

    template<>
    void foo(int a)
    {
        cout << "template specialization: int" << endl;
    }

    void foo(int a)
    {
        cout << "function" << endl;
    }


    int main()
    {
        foo(3.3);      // template
        foo<int>(5);   // template specialization: int (手动指定类型)
        foo<int>(3.3); // template specialization: int (手动指定类型)
        foo(3);        // function (优先匹配普通函数)
        return 0;
    }

类模板特化
-------------

类模板特化类似于函数模板的特化，即类模板参数在某种特定类型下的具体实现。

对主版本模板类、全特化类、偏特化类的调用优先级从高到低排序是：全特化类 > 偏特化类 > 主版本模板类。

.. code-block:: cpp
    :linenos:

    template<class T1, class T2>
    class Test
    {
    public:
        Test(T1 a, T2 b):_a(a),_b(b)
        {
            cout << "模板化" << endl;
        }
    private:
        T1 _a;
        T2 _b;
    };

    //模板全特化
    template<>
    class Test<int, int>
    {
    public:
        Test(int a, int b) :_a(a), _b(b)
        {
            cout << "模板全特化" << endl;
        }
    private:
        int _a;
        int _b;
    };

    //模板偏特化
    template<class T>
    class Test<int, T>
    {
    public:
        Test(int a, T b) :_a(a), _b(b)
        {
            cout << "模板偏特化" << endl;
        }
    private:
        int _a;
        T _b;
    };

    int main()
    {
        Test<double, double> t1(1.01, 1.01); // 模板化
        Test<int, int> t2(1, 1);             // 模板全特化
        Test<int, string> t3(1, "111");      // 模板偏特化
        return 0;
    }

**成员模板函数不能为虚函数** 。编译器在编译一个类的时候，需要确定这个类的虚函数表的大小。一般来说，如果一个类有N个虚函数，它的虚函数表的大小就是N（4N字节）。 
如果允许一个成员模板函数为虚函数的话，由于我们可以为该成员模板函数实例化出很多不同的版本，也就是可以实例化出很多不同版本的虚函数，那么编译器为了确定类的虚函数表的大小，就必须要知道我们一共为该成员模板函数实例化了多少个不同版本的虚函数。显然编译器需要查找所有的代码文件，才能够知道到底有几个虚函数，这对于多文件的项目来说，代价是非常高的，所以规定成员模板函数不能够为虚函数。

.. note::

    模板的声明和定义都放在头文件中。

参考资料
-------------

1. C++学习之模板特例化

  https://songlee24.github.io/2014/07/23/cpp-template-specialization/

2. C++模板特化与偏特化

  https://cloud.tencent.com/developer/article/1347877
