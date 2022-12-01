lambda 表达式
=====================

根据算法接受一元谓词（unary predicate）还是二元谓词（binary predicate），我们传递给算法的谓词必须严格接受一个或两个参数。
例如，``sort`` 接受二元谓词。

lambda 表达式可以在一定程度上解决这个问题。lambda 表达式表示一个可调用的代码单元。可以将其理解为一个未命名的内联函数。
lambda 表达式具有返回类型、参数列表、函数体。与普通函数不同的是，其参数列表不能有默认参数，且使用尾置返回 ``->`` 来指定返回类型。
lambda 可能定义在函数内部。

::

  [capture list] (parameter list) -> return type {function body}

可以忽略参数列表和返回类型，但是必须包括捕获列表和函数体。

  - 捕获列表是 lambda 所在的函数内部定义的局部变量，即 lambda 表达式需要使用的变量，通常为空。

  - 如果忽略返回类型，lambda 根据函数体中的代码推断出返回类型：

    - 如果函数体只有一个 return 语句，则返回类型从 return 表达式的类型推断。

    - 否则，返回 void。

.. code-block:: cpp

  auto f = [] {return 42;}; // 返回 int
  cout << f() << endl; // 打印 42

.. note::

    可调用对象
      对于一个对象或表达式，如果可以对其使用调用运算符 ``()`` ，则称其为可调用对象。

      可调用对象包括：函数、函数指针、重载了运算符 ``()`` 的类、lambda 表达式。


捕获列表
---------------

类似于参数传递，变量的捕获方式可以是值捕获或引用捕获。

捕获列表：

  - ``[]`` ：空捕获列表，lambda 不能使用所在函数中的变量。

  - ``[names]`` ：使用逗号分隔的名字列表，默认为值捕获（拷贝），名字前加 ``&`` 表示引用捕获。

  - ``[=]`` ：隐式值捕获，将拷贝 lambda 表达式所使用的来自所在函数中的变量。

  - ``[&]`` ：隐式引用捕获，将引用 lambda 表达式所使用的来自所在函数中的变量。

  - ``[=, identifier_list]`` ：identifier_list 声明的变量采用引用捕获，其他使用的变量采用值捕获。

  - ``[&, identifier_list]`` ：identifier_list 声明的变量采用值捕获，其他使用的变量采用引用捕获。


值捕获
^^^^^^^^^^^

捕获变量的值是在 lambda **创建时** 拷贝，而不是调用时拷贝。

.. code-block:: cpp
  :linenos:

  void fcn1()
  {
      size_t v1 = 42;
      auto f = [v1] {return v1;}; // 拷贝 v1
      v1 = 0;
      auto j = f(); // j = 42
  }

引用捕获
^^^^^^^^^^^^

.. code-block:: cpp
  :linenos:

  void fcn2()
  {
      size_t v1 = 42;
      auto f = [&v1] {return v1;}; // 引用 v1
      v1 = 0;
      auto j = f(); // j = 0
  }

例子
-----------

给定一个值 ref，将数组元素按照与 ref 的差值从小到大排序。

.. code-block:: cpp
  :linenos:

  void Sort_(vector<int>& vec, int ref)
  {
      sort(vec.begin(), vec.end(), [ref](int a, int b){return abs(a - ref) < abs(b - ref);});
  }


参考资料
------------

1.《C++ Primer 第5版 中文版》 Page 344 – 353。
