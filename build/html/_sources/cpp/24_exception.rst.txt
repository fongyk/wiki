异常
===========

异常处理（exception handling）使得我们能够将问题的 **检测** 和 **解决** 过程分离开；程序的一部分负责检测问题的出现，然后解决该问题
的任务传递给程序的另一部分；检测环节无须知道问题处理模块的所有细节，反之亦然。

以下基于 C++ 11 标准。

异常类层次
-------------

标准库异常类的继承体系如下：

.. image:: ./24_exception.jpg
  :align: center
  :width: 600px

头文件
  - ``<exception>`` ：定义了最通用的异常类 exception，它只报告异常的发生，不提供任何额外信息。包括拷贝构造函数、拷贝赋值函数、虚析构函数、what 虚函数。
    what 负责返回一个 const char* 指针，指向一个字符数组，包含了用于初始化异常对象的信息。

    .. code-block:: cpp
      :linenos:

      class exception
      {
      public:
        exception () noexcept;
        exception (const exception&) noexcept;
        exception& operator= (const exception&) noexcept;
        virtual ~exception();
        virtual const char* what() const noexcept;
      }


  - ``<stdexcept>`` ：定义了 runtime_error 和 logic_error 及其派生类。

    - runtime_error：运行时错误，只有在程序运行时才能检测到的错误。

    - logic_error：逻辑错误，在程序代码中发现的错误。

  - ``<new>`` ：定义了 bad_alloc 异常类型。

  - ``<type_info>`` ：定义了 bad_cast 异常类型。

- exception、bad_cast、bad_alloc 定义了默认构造函数。

- runtime_error 和 logic_error 没有默认构造函数，可以接受 C 风格字符串或 string 类型实参的构造函数。初始值蕴含了错误相关的信息。


try 语句块
------------

.. code-block:: cpp
  :linenos:

  try
  {
    // program-statements
    // throw 抛出异常（异常对象拷贝初始化）
  }
  catch (exception-declaration) // 捕捉异常
  {
    // handle-statements
  }
  catch (exception-declaration)
  {
    // handle-statements
  }
  // ...

一个例子：

.. code-block:: cpp
  :linenos:

  #include <iostream>
  #include <stdexcept>
  using namespace std;

  void StringAtI(string str, int i)
  {
    try
    {
      if (str.size() == 0) throw runtime_error("empty string");
      cout << str.at(i) << endl;
    }
    catch (runtime_error &re)
    {
      cout << re.what() << endl; // empty string
    }
    catch (out_of_range &oe)
    {
      cout << oe.what() << endl; // invalid string position
    }
  }


抛出异常
----------

当执行 ``throw`` 之后，跟在 ``throw`` 后面的语句不再执行（类似于 ``return`` 的作用），程序的控制权从 ``throw`` 转移到与之匹配的 ``catch`` 模块。

栈展开
^^^^^^^^^^^^^

栈展开（stack unwinding）过程演着嵌套函数的调用链不断查找，直到找到了与异常匹配的 ``catch`` 子句为止。

当 ``throw`` 出现在一个 ``try`` 语句块，检测与该块关联的 ``catch`` 子句。如果找到匹配的 ``throw`` ，就是用该 ``throw`` 处理异常。
如果没找到且该 ``try`` 语句嵌套在其他 ``try`` 块中，则继续检查与外层 ``try`` 匹配的 ``catch`` 子句。如果还是找不到，则退出当前函数，在调用当前函数的外层函数中继续寻找。

当找不到匹配的 ``catch`` ，程序将调用标准库函数 ``terminate`` 以中止程序的执行过程。

析构函数与异常
^^^^^^^^^^^^^^^^^^

**析构函数不应该抛出不能被它自身处理的异常** 。换句话说，如果析构函数需要执行某个可能抛出异常的操作，则该操作应该被放置在一个 ``try`` 语句块当中，
并且在析构函数内部得到处理。

析构函数常常仅仅是为了释放资源，因此不太可能抛出异常。

异常对象
^^^^^^^^^^^^^

编译器使用异常抛出表达式对异常对象进行拷贝初始化。

当我们抛出一条表达式时，该表达式的静态编译时类型决定了异常对象的类型。如果 ``throw`` 表达式解引用（ ``*`` ）一个基类指针，而该指针实际指向的是
派生类对象，则抛出的对象只保留了基类部分。

捕获异常
---------------

查找匹配的处理代码
^^^^^^^^^^^^^^^^^^^^^^^^^^

 ``catch`` 中的异常声明的类型决定了处理代码能捕获的异常类型。它可以是左值引用，不能是右值引用。

 通常情况下，如果 ``catch`` 接受的异常与某个继承体系有关，最好将 ``catch`` 的参数定义为引用类型。此时改变了形参，也就改变了异常对象。

 如果多个 ``catch`` 语句的类型之间存在继承关系，应该把继承链最底端的类放在最前面，最顶端的类放在最后面。

重新抛出
^^^^^^^^^^^^^^^

 ``catch`` 语句可以重新抛出异常（rethrowing），将异常传递给另外一个 ``catch`` 语句。重新抛出语句不包含额外的表达式，

 .. code:: cpp

    throw;

空的 ``throw`` 语句只能出现在 ``catch`` 语句或 ``catch`` 直接/间接调用的函数之内，否则编译器将调用 ``terminate`` 。

捕获所有异常
^^^^^^^^^^^^^^

一条捕获所有异常的语句可以和任意类型的异常匹配。通常与重新抛出语句一起使用。

.. code-block:: cpp
  :linenos:

  catch(...)
  {
    // 处理异常
    throw;
  }


noexcept 异常说明
----------------------

通过关键字 ``noexcept`` 指定某个函数不会抛出异常。 ``noexcept`` 紧跟在函数参数列表的后面。

尽管函数声明了不会抛出异常，但是仍然可以抛出异常。一旦 ``noexcept`` 函数抛出了异常，程序就会调用 ``terminate`` 以中止程序。

参考资料
--------------

1.《C++ Primer 第5版 中文版》 Page 173 -- 176, Page 684 -- 695。

2. C++ reference

  http://www.cplusplus.com/reference/exception/exception

  http://www.cplusplus.com/reference/stdexcept

3. C++ 异常

  https://www.cnblogs.com/nzbbody/p/3418989.html

4. C++ 异常处理

  https://www.runoob.com/cplusplus/cpp-exceptions-handling.html
