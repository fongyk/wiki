可变参数函数  
==================

可变参数函数：参数数量可变，参数类型可变。比如 C 语言中的 ``printf`` ，参数数量是可变的，类型也是可变的。

C 语言的方式
------------------

C 语言是通过一个类型（va_list）和三个宏（va_start、va_arg、va_end）来实现可变参数的。

.. code-block:: cpp
  :linenos:

  #include <iostream>
  #include <cstdarg>
  using namespace std;

  void cPrint(int narg, ...)
  {
      va_list args;
      va_start(args, narg);
      while(narg--)
      {
          cout << va_arg(args, int) << " ";
      }
      va_end(args);
      cout << endl;
  }

  // 调用：cPrint(3, 5, 6, 23);

上例中 ``va_arg(args, int)`` 限定了解析的参数类型必须是整型，因而没有实现参数类型可变。 ``printf`` 是通过 ``%`` 来确定参数个数和类型的。


C++ 的方式
--------------------

C++ 的可变参数模板得益于：

- 函数重载，依靠参数的 pattern 去匹配对应的函数；

- 函数模板，依靠调用时传递的参数自动推导出模板参数的类型；

- 类模板，基于偏特化（partial specialization）来选择不同的实现。


.. code-block:: cpp
  :linenos:

  #include <iostream>
  #include <cstdarg>
  using namespace std;

  // 递归出口
  // 当两个参数模板都适用某种情况时，优先使用没有 template parameter pack 的版本
  template<typename T>
  void cppPrint(T arg)
  {
      cout << arg << endl;
  }

  template<typename T, typename... Ts> // template parameter pack，表明这里有多种 type
  void cppPrint(T arg1, Ts... args_left) // function parameter pack，表明这里有多个参数
  {
      cout << arg1 << " ";
      // 递归
      cppPrint(args_left...); // pack expansion，将参数名字展开为逗号分割的参数列表
  }

  // 调用：cppPrint(5, 6.6, "foo");

C++ 通过重载 ``operator<<`` 来定制不同类型的输出。

.. note::

    模板特化（template specialization）与偏特化（partial template specialization）：
    指定或限定全部/部分模板参数。


参考资料
-------------------

1. 两种变长参数函数比较

  https://elloop.github.io/c++/2015-11-28/never-proficient-cpp-vaargs


2. C++的可变参数模板

  https://zhuanlan.zhihu.com/p/104450480

3. 模板特化与偏特化

  https://en.cppreference.com/w/cpp/language/template_specialization

  https://en.cppreference.com/w/cpp/language/partial_specialization

  https://en.wikipedia.org/wiki/Partial_template_specialization
