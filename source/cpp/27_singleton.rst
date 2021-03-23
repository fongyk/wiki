单例模式
=============

单例是一种创建型设计模式，保证一个类只有一个实例（对象），并提供一个访问该实例的全局节点。

基础单例
----------

.. code-block:: cpp
  :linenos:
  
  // from the header file
  class Singleton
  {
  public:
    static Singleton* instance();
    // something else ...
  private:
    static Singleton* pInstance;
  };
  
  // from the implementation file
  Singleton* Singleton::pInstance = 0; // nullptr
  
  Singleton* Singleton::instance()
  {
    if(pInstance == 0)
    {
      pInstance = new Singleton;
    }
    return pInstance;
  }

这种实现方法不是线程安全的（Thread-safe)，多个线程同时调用 ``instance()`` 可能会构造出多个对象。


全加锁
--------------

.. code-block:: cpp
  :linenos:

  Singleton* Singleton::instance()
  {
    Lock lock; // acquire lock (params omitted for simplicity)
    if(pInstance == 0)
    {
      pInstance = new Singleton;
    }
    return pInstance;
  } // release lock (via Lock destructor)

所有线程调用 ``instance()`` 都会先加锁，如果加锁不成功，则该线程会阻塞直到加锁成功。因此，可以保证只有一个实例。

缺点是：每一次调用 ``instance()`` 都需要加锁，开销很大，尽管实际上只有在第一次调用的时候有加锁的必要。


DCLP
-------------

DCLP（Double-Checked Locking Pattern）避免了重复加锁，只需要在第一次调用的时候加锁。

.. code-block:: cpp
  :linenos:

  Singleton* Singleton::instance()
  {
    if(pInstance == 0)  // 1st test
    {
      Lock lock;
      if(pInstance == 0)  // 2nd test
      {
        pInstance = new Singleton;
      }
    }
    return pInstance;
  }

执行顺序
^^^^^^^^^^^^^

``pInstance = new Singleton`` 需要完成三件事情：

- step-1：分配内存给即将构造的实例。

- step-2：在分配的内存上构造 Singleton 实例。

- step-3：指针 pInstance 指向分配的内存。

事实上，由于编译器的优化，这三个步骤并不一定是按照上述顺序完成的，也许 step-3 会在 step-2 之前完成，
这就导致指针 pInstance 在 **实例构造之前** 已经是非空指针了，另一个线程判断非空之后，可能会去解引用/访问该实例，会导致出错。因此，这不是线程安全的。

volatile
^^^^^^^^^^^^^^

可以尝试使用关键字 ``volatile`` ::

  static volatile Singleton* volatile instance();
  static Singleton* volatile pInstance;

C/C++中的 volatile 和 const 对应，用来修饰变量，通常用于建立语言级别的 memory barrier。

::

  The C++ Programming Language: A volatile specifier is a hint to a compiler that an object may change its value in ways not specified by the language so that aggressive optimizations must be avoided.

``volatile`` 提醒编译器它后面所定义的变量随时都有可能改变，因此编译后的程序每次需要存储或读取这个变量的时候，都会直接从变量地址中读取数据，从而可以提供对特殊地址的稳定访问。如果没有 ``volatile`` 关键字，则编译器可能优化读取和存储，可能暂时使用寄存器中的值，如果这个变量由别的程序更新了的话，将出现不一致的现象。 ``volatile`` 可以保证指令执行的顺序。

但是使用 ``volatile`` 仍然面临两个问题 ::

- 可以保证单线程内读写数据的顺序，但是不能保证跨线程的读写顺序。

- 一个实例只有当构造完成、退出构造函数时才会赋予 ``volatile`` 属性，因而分配内存和实例初始化的顺序不能保证。

缓存一致性
^^^^^^^^^^^^^^^

在多处理器的机器上，DCLP 还面临缓存一致性问题（Cache Coherency Problem）：一个处理器上的线程正在创建实例，而另一个处理器上的线程可能会访问到未初始化的实例。

如果一个 CPU 缓存了某块内存，那么在其他 CPU 修改这块内存的时候，希望得到通知。拥有多组缓存的时候，需要它们保持同步，但是，系统的内存在各个 CPU 之间无法做到与生俱来的同步。

结论
^^^^^^^^^^^

推荐使用全加锁方式。为了避免多线程重复加锁，可以缓存指向该实例的指针，即用::

  Singleton* const instance = Singleton::instance(); // cache instance pointer
  instance->transmogrify();
  instance->metamorphose();
  instance->transmute();

代替::

  Singleton::instance()->transmogrify();
  Singleton::instance()->metamorphose();
  Singleton::instance()->transmute();

另一种实现
------------

.. code-block:: cpp
  :linenos:

  class S
  {
    public:
        static S& getInstance()
        {
            static S    instance; // Guaranteed to be destroyed.
                                  // Instantiated on first use.
            return instance;
        }
    private:
        S() {}                    // Constructor? (the {} brackets) are needed here.

        // C++ 03
        // ========
        // Don't forget to declare these two. You want to make sure they
        // are inaccessible(especially from outside), otherwise, you may accidentally get copies of
        // your singleton appearing.
        S(S const&);              // Don't Implement
        void operator=(S const&); // Don't implement

        // C++ 11
        // =======
        // We can use the better technique of deleting the methods
        // we don't want.
    public:
        S(S const&)               = delete;
        void operator=(S const&)  = delete;

        // Note: Scott Meyers mentions in his Effective Modern
        //       C++ book, that deleted functions should generally
        //       be public as it results in better error messages
        //       due to the compilers behavior to check accessibility
        //       before deleted status
  };

.. note::

  拷贝构造函数和拷贝赋值运算符需要声明为不可调用。

参考资料
-----------

1. C++ and the Perils of Double-Checked Locking

  https://www.aristeia.com/Papers/DDJ_Jul_Aug_2004_revised.pdf

2. C++ Singleton design pattern

  https://stackoverflow.com/questions/1008019/c-singleton-design-pattern

3. C++ 单例模式讲解和代码示例

  https://refactoringguru.cn/design-patterns/singleton/cpp/example
