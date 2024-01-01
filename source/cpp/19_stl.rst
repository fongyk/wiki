常用 STL 容器
==================

**STL: Standard Template Library** ，标准模板库。

容器
  A container is a holder object that stores a collection of other objects (its elements). 
  They are implemented as class templates, which allows a great flexibility in the types supported as elements.

以下基于 C++11 标准。

顺序容器
  - array
  - vector
  - list
  - forward_list
  - deque

关联容器
  - set
  - map
  - multiset
  - multimap
  - unordered_set
  - unordered_map
  - unordered_multiset
  - unordered_multimap

容器适配器
  - stack
  - queue
  - priority_queue

一个容器适配器接受一种已有的容器类型，使其行为看起来像一种不同的类型。默认情况下，stack 和 queue 基于 deque 实现，priority_queue 基于 vector 实现。


.. highlight:: cpp


迭代器
-------------

迭代器和 C++ 的指针非常类似，它可以是需要的任意类型，通过迭代器可以指向容器中的某个元素，还可以对该元素进行读/写操作。

功能分类
^^^^^^^^^^^^^

常用的迭代器按功能强弱分为五种：输入迭代器（input iterator）、输出迭代器（output iterator）、前向迭代器（forward iterator）、双向迭代器（bidirectional iterator）、随机访问迭代器（random access iterator）。

随机访问迭代器支持的运算符（a、b表示迭代器）：

- 双向迭代器支持的运算符

  - 前向迭代器支持的运算符

    - 输入迭代器支持的运算符

      - 自增 ``++a`` ``a++``

      - 比较 ``a == b`` ``a != b``

      - 右值解引用 ``*a`` ``*a->m``

    - 输出迭代器支持的运算符

      - 自增 ``++a`` ``a++``

      - 左值解引用 ``*a = t`` ``*a++ = t``
  
  - 自减 ``--a`` ``a--`` ``*a--``

- 算术运算 ``a + n`` ``n + a`` ``a - n`` ``a - b``

- 比较 ``a > b`` ``a < b`` ``a >= b`` ``a <= b``

- 复合赋值 ``a += n`` ``a -= n``

- 下标解引用 ``a[n]``

不同容器能够使用的容器类型不同：

- 随机访问迭代器：array、vector、deque。

- 双向迭代器：list、set/multiset、map/multimap。

- 前向迭代器：forward_list、unordered_set/unordered_multiset、unordered_map/unordered_multimap。


定义方式
^^^^^^^^^^^^^

迭代器按照定义方式分成以下四种：

- 正向迭代器 ``容器类名::iterator  迭代器名;``

- 常量正向迭代器 ``容器类名::const_iterator  迭代器名;``

- 反向迭代器 ``容器类名::reverse_iterator  迭代器名;``

- 常量反向迭代器 ``容器类名::const_reverse_iterator  迭代器名;``


辅助函数
^^^^^^^^^^^^^

::

  #include <algorithm>

STL 中有用于操作迭代器的三个函数模板:

- advance(p, n)：使迭代器 p 向前或向后（n 为负数）移动 n 个元素。

- distance(p, q)：计算两个迭代器之间的距离，对于随机访问迭代器，直接使用 ``p - q`` ，结果可能是负数；对于其他迭代器，循环调用 ``++`` 自增，如果调用时 p 已经指向 q 的后面，则陷入死循环。

- iter_swap(p, q)：用于交换两个迭代器指向的值，两个迭代器必须是非常量迭代器。


.. note::

    迭代器
      不能通过 ``const_iterator`` 修改容器元素，但是 ``const_iterator`` 本身可以进行自增（++）操作，类似于指向常量的指针；
      如果 ``const_iterator`` 本身被设置为常量： ``const const_iterator`` ，则不能进行自增操作。 ``const_iterator`` 一般用于访问常量容器。

vector
------------
::

  #include<vector>

**底层实现：顺序表（数组，连续的内存空间）。**

- 元素个数：size()，empty()
- 逐元素比较：==，!=，<，<=，>，>=
- 内存空间：capcity()
- 随机访问：[pos]，at(pos)
- 头部元素：front()，返回的是引用
- 尾部元素：back()，返回的是引用
- 尾部插入：push_back(x)，emplace_back(x)
- 尾部弹出：pop_back()
- 迭代器插入：在 position **之前** 插入元素。

  ::

    iterator insert (iterator position, const value_type& val);

    template <class... Args>
    iterator emplace (const_iterator position, Args&&... args);

- 申请空间：至少能容纳 n 个元素（capcity() 为 n）。

  ::

    void reserve (size_type n)

- 改变大小：将元素个数变为 n。如果指定 val 且 n 大于原来的 size，则使用 val 填充新元素，原来的元素不变；如果 n 小于原来的 size，则丢弃尾部元素。

  ::

    void resize (size_type n);
    void resize (size_type n, const value_type& val);

- 赋值

  - 数组或其他向量区间 [first, last) 内的值赋给当前向量。

    ::

      template <class InputIterator>
      void assign (InputIterator first, InputIterator last)


  - 赋予 n 个 val 元素给当前向量。

    ::

      void assign (size_type n, const value_type& val)

- 直接赋值（返回的是引用类型）

  ::

    // copy (1)
    vector& operator= (const vector& x);
    // move (2)
    vector& operator= (vector&& x);
    // initializer list (3)
    vector& operator= (initializer_list<value_type> il);

- 删除：删除一个元素之后，此位置之后所有元素往前移动。虽然当前迭代器没有 +1，但是由于后续元素的前移，相当于迭代器自动指向了下一个元素。故删除了一个元素之后如果要访问下一个元素，不必执行 ``it++``。

  ::

    iterator erase (const_iterator position);
    iterator erase (const_iterator first, const_iterator last); // 区间 [first, last)

- 清除：

  - ``vector< value_type >().swap(myVec)``
  - ``myVec.clear()`` 让 myVec.size() 为0，但是 myVec.capcity() 不为0，调用 ``myVec.clear()`` 之后再调用 ``myVec.shrink_to_fit()`` 。 ``shrink_to_fit()`` 的作用是减小 capcity() 以匹配 size()。


.. note::

  类模板用于产生类，比如 ::

    template <typename T>
    class Vector
    {
      // ...
    };

  Vector 是 **类模板** ，Vector<int>、Vector<char> 是生成的 **模板类** 。


list
---------
::

  #include<list>

**底层实现：双向循环链表。**

- 元素个数：size()，empty()
- 表首元素：front()
- 表尾元素：back()
- 插入：push_front()，push_back()，emplace_front()，emplace_back()
- 删除：pop_front()，pop_back()
- 迭代器插入：在 position **之前** 插入元素。

  ::

    iterator insert (iterator position, const value_type& val)


deque
---------
::

  #include<deque>

**底层实现：指针数组 + 多个连续内存空间。**

- 元素个数：size()，empty()
- 随机访问：[pos]，at(pos)
- 队首元素：front()
- 队尾元素：back()
- 插入：push_front(x)，push_back(x)，emplace_front(x)，emplace_back(x)
- 删除：pop_front()，pop_back()
- 迭代器插入：在 position **之前** 插入元素。

  ::

    iterator insert (iterator position, const value_type& val);

    template <class... Args>
    iterator emplace (const_iterator position, Args&&... args);


.. note::

  顺序容器构造函数
    - ``C c;`` // 默认构造函数，空容器
    - ``C c1(c2);`` // 拷贝构造函数
    - ``C c(it_begin, it_end);`` // 迭代器指定的范围 [it_begin, it_end) 内的元素赋值给c（array不支持）
    - ``C c{a, b, c,...};`` // 列表初始化


set
-----------------

::

  #include<set>

**底层实现：红黑树。**

- 元素个数：size()，empty()

- 查找：找不到 key 则返回 ``set::end`` 。

  ::

    const_iterator find (const value_type& val) const;
    iterator       find (const value_type& val);


- 插入：如果 key 已经存在，则插入无效；insert/emplace。

  ::

    // single element (1)
    pair<iterator,bool> insert (const value_type& val);
    pair<iterator,bool> insert (value_type&& val);
    // with hint (2)
    iterator insert (const_iterator position, const value_type& val);
    iterator insert (const_iterator position, value_type&& val);
    // range (3)
    template <class InputIterator>
    void insert (InputIterator first, InputIterator last);
    // initializer list (4)
    void insert (initializer_list<value_type> il);

    // emplace
    template <class... Args>
    pair<iterator,bool> emplace (Args&&... args);


- 删除：返回删除元素后的下一个元素的迭代器，当前迭代器失效。

  ::

    // (1)
    iterator  erase (const_iterator position);
    // (2)
    size_type erase (const value_type& val); // 返回删除元素的个数：0 或 1
    // (3)
    iterator  erase (const_iterator first, const_iterator last);

- 直接赋值（返回的是引用类型）

  ::

    // copy (1)
    set& operator= (const set& x);
    // move (2)
    set& operator= (set&& x);
    // initializer list (3)
    set& operator= (initializer_list<value_type> il);


pair
---------
::

  #include<utility>

- 构造

  ::

    template <class T1, class T2>
    pair<T1,T2> make_pair (T1 x, T2 y);

- 访问：成员 ``first`` 访问第一个元素，成员 ``second`` 访问第二个元素。

- 关系运算：支持 ==，!=，<，<=，>，>=，从而可以直接排序

  ::

    // 如果 first 相等，则比较 second
    template <class T1, class T2>
    bool operator<  (const pair<T1,T2>& lhs, const pair<T1,T2>& rhs)
    { return lhs.first<rhs.first || (!(rhs.first<lhs.first) && lhs.second<rhs.second); }

    template <class T1, class T2>
    bool operator>  (const pair<T1,T2>& lhs, const pair<T1,T2>& rhs)
    { return rhs<lhs; }

map
--------
::

  #include<map>

**底层实现：红黑树。**

``map<K，T>`` 容器，保存的是 ``pair<const K，T>`` 类型的元素。

  - ``map<K，T>::key_type`` ：键类型

  - ``map<K，T>::mapped_type`` ：值类型

  - ``map<K，T>::value_type`` ：pair类型， ``<map<K，T>::key_type, map<K，T>::mapped_type>``

- 访问：[key]，at(key)

  - [key]，key 不存在，会创建新的键值对。

  - at(key)，key 不存在，抛出 ``out_of_range`` 异常。

- 直接赋值（返回的是引用类型）

  ::

    // copy (1)
    map& operator= (const map& x);
    // move (2)
    map& operator= (map&& x);
    // initializer list (3)
    map& operator= (initializer_list<value_type> il);

- 查找：找不到 key 则返回 ``map::end`` 。

  ::

    iterator find (const key_type& k);
    const_iterator find (const key_type& k) const;

- 插入：如果 key 已经存在，则插入无效。map 的元素自动按照 key 升序排序，不能人为对 map 进行排序；insert/emplace。

  ::

    pair<iterator,bool> insert (const value_type& val);

    template <class... Args>
    pair<iterator,bool> emplace (Args&&... args);


- 删除：返回删除元素后的下一个元素的迭代器，当前迭代器失效。

  ::

    iterator  erase (const_iterator position);
    size_type erase (const key_type& k); // 返回删除元素的个数：0 或 1
    iterator  erase (const_iterator first, const_iterator last);

  ``it = myMap.erase(it)`` 等效为 ``myMap.erase(it++)`` 。


例子：

.. code-block:: cpp
  :linenos:

  #include <iostream>
  #include <map>

  int main ()
  {
    std::map<char,int> mymap;

    // first insert function version (single parameter):
    mymap.insert(std::pair<char,int>('a',100));
    mymap.insert(std::map<char,int>::value_type('z',200));

    std::pair<std::map<char,int>::iterator,bool> ret;
    ret = mymap.insert(std::pair<char,int>('z',500));
    if (ret.second == false)
    {
      std::cout << "element 'z' already existed";
      std::cout << " with a value of " << ret.first->second << '\n';
    }

    return 0;
  }

在使用指针作为 map/set 的 key 的时候要注意，key 是指针所指对象的地址，即使不同指针所指对象的值是一样的，但它们对应的 key 可能是不一样的。
如果需要保持 map/set 中指针所指对象的值也是唯一的，那么需要自定义 ``Compare`` 类（函数对象类）。

.. code-block:: cpp
  :linenos:

  #include <iostream>
  #include <string>
  #include <map>

  template<class T>
  struct Compare 
  {
      bool operator()(const T* lhs, const T* rhs) const // 定义为 const 成员
      {
          return *lhs < *rhs;
      }
  };

  int main ()
  {
    std::string s1 = "a", s2 = "a", s3 = "a";
    std::map<std::string*, int> mp;
    mp[&s1] = 1;
    mp[&s2] = 2;
    std::cout << mp.size() << std::endl; // 2
    std::cout << (mp.find(&s3) == mp.end()) << std::endl; // 1
    std::map<std::string*, int, Compare<std::string>> mpc;
    mpc[&s1] = 1;
    mpc[&s2] = 2;
    std::cout << mpc.size() << std::endl; // 1
    std::cout << (mpc.find(&s3) == mpc.end()) << std::endl; // 0
    return 0;
  }

.. note::

  ``std::map::opeartor[]`` 不是 const 成员函数（操作符），对于不在 map 中的关键字，使用下标操作符会创建新的条目从而改变了 map，因此 const map 不能使用 ``[]`` ，可以使用 ``at()`` 。 ::

    mapped_type& operator[] (const key_type& k);

    mapped_type& at (const key_type& k);
    const mapped_type& at (const key_type& k) const;

.. note::

    无序容器
      维护元素有序代价较高，map 和 set 都对应了无序版本：unordered_map 和 unordered_set。无序版本能使用有序版本的操作（find、insert 等）。
      当使用 key 来访问元素时，无序版本的速度更快。

      不能直接定义关键字类型为自定义类类型的无序容器，因为自定义类类型无法使用内建哈希函数。

      如果想定义关键字类型为自定义类类型的有序容器，也需要重载关系运算符（比较大小）；重载关系运算符的目的是为了表明该类型的关键字（key）。

.. note::

  重复关键字
    map 和 set 都对应了可以包含重复关键字的版本：multimap 和 multiset。元素是有序的，定义时可以指定二元谓词 ``Compare`` ，默认是 ``less<T>`` ，即元素从小到大排序， ``multiset<T, greater<T>>`` 可以当做大顶堆使用。

    相应地，insert 插入相同的关键字时，按插入时间顺序排序。也就是说，越晚插入的排在越后。``erase(val)`` 会删除所有重复的 val。

    另外，也有无序版本：unordered_multimap 和 unordered_multiset。

.. note::

    map、multimap、set、multiset 是基于红黑树实现的、有序的，查找操作的平均时间复杂度是 O(log N)。unordered_map、unordered_multimap、unordered_set、unordered_multiset 是基于哈希表实现的，查找操作的平均时间复杂度是 O(1)。哈希方法为了减小冲突概率，需要消耗更多的空间。

stack
---------
::

  #include<stack>

- 大小：size()，empty()
- 栈顶元素：top()
- 入栈：push(x)，emplace(x)
- 出栈：pop()

  ::

    void pop();

queue
------------
::

  #include<queue>

- 大小：size()，empty()
- 队首元素：front()
- 队尾元素：back()
- 入队：push(x)，emplace(x)
- 出队：pop()

  ::

    void pop();


priority\_queue
---------------------

::

  #include<queue>

实现 priority_queue 的底层容器默认是 vector，同时默认功能是大顶堆（值越大，优先级越高；队首元素值最大）。

::

  template <class T, class Container = vector<T>,
  class Compare = less<typename Container::value_type> > class priority_queue;

- 大小：size()，empty()
- 最高优先级元素：top()
- 入队：push(x)，emplace(x)
- 最高优先级元素出队：pop()

.. code-block:: cpp
  :linenos:

  #include <iostream>
  #include <queue>
  using namespace std;

  template<class T>
  class comparator
  {
  public:           // 必须是 public
      bool operator()(T a, T b)
      {
          return a > b; // 相当于 greater<T>，小顶堆
      }
  };

  int main(int argc, char ** argv)
  {
      priority_queue<string, vector<string>, comparator<string> > mypq;

      mypq.emplace("orange");
      mypq.emplace("strawberry");
      mypq.emplace("apple");
      mypq.emplace("pear");

      cout << "Popping out elements...";
      while (!mypq.empty())
      {
          cout << ' ' << mypq.top();
          mypq.pop();
      }
      cout << '\n';
      return 0;
  }

  // 输出结果
  // Popping out elements... apple orange pear strawberry



.. note::

  C++11 标准引入了 **emplace_front** ， **emplace** ， **emplace_back** 这些操作构造而不是拷贝元素，分别对应 **push_front** ，**insert/push** ，**push_back** 。

  调用 push 或 insert 时，先创建一个元素类型的 **临时对象** ，这个对象被 **拷贝** 到容器中。

  调用 emplace 时，将 **参数** 传递给元素类型的 **构造函数** ，在容器管理的内存空间中使用这些参数直接构造元素。传递给 emplace 的参数必须与构造函数匹配。

  相应地，**pop** 操作会调用析构函数。

.. note::

    当 STL 容器使用默认的空间配置器 ``std::allocator<T>`` 时，容器中存储的 **数据项** 都是位于堆内存（new 出来的），容器对象析构时这些空间会被释放。
    而容器的 metadata （比如 vector 的头指针、数据尾指针、空间尾指针）所在的空间受对象创建方式的影响而有所差异。
    比如， ``vector<T> vec`` 如果被定义为全局/静态变量，则 vec 位于全局/静态存储区；如果被定义为局部变量，则 vec 位于栈空间。
    ``vector<T>* vec = new vector<T>;`` 则所有数据都位于堆空间。
    假设有局部变量 ``vector<T*> vec;`` ，则 vec 位于栈空间，vec 存储的 ``T*`` 指针位于堆空间；这些指针所指的数据所在的位置由其创建方式决定。vec 析构时会释放这些指针所占的空间，但是并不会释放这些指针所指数据的空间。如果这些空间位于堆上，则在析构之前需要手动释放。


附：string
-------------------
::

  #include<string>

string 是 ``basic_string<char, std::char_traits<char>, std::allocator<char>>`` 这种类型的别名，不是 STL 的标准容器，但是其与 STL 容器有一些相似的行为，因此这里也作简单介绍。

::

  typedef basic_string<char> string;

- 长度：length()，size()，empty()
- 随机访问：[pos]，at(pos)。at()返回位置 pos 处元素的引用，越界则抛出 ``out_of_range`` 异常。
- 字典序比较：==，!=，<，<=，>，>=
- 串接：+，+=，append
- c_str()：返回指向 C 类型字符串的指针。如果需要使用 C 的字符串函数如 strcmp、strcpy 等，需要使用 c_str()。
  ::

    const char* c_str() const noexcept;

- 子串
  ::

    string substr(size_t pos = 0, size_t len = npos) const

- 插入：支持下标索引插入，在位置 pos **之前** 插入元素。插入元素之后，该元素的位置为 pos。（与 python 中 list 类的插入功能一致）
  ::

    // string (1)
    string& insert (size_t pos, const string& str);
    // substring (2)
    string& insert (size_t pos, const string& str, size_t subpos, size_t sublen);
    // c-string (3)
    string& insert (size_t pos, const char* s);
    // buffer (4)
    string& insert (size_t pos, const char* s, size_t n);
    // fill (5)
    string& insert (size_t pos, size_t n, char c);
    iterator insert (const_iterator p, size_t n, char c);
    // single character (6)
    iterator insert (const_iterator p, char c);
    // range (7)
    template <class InputIterator>
    iterator insert (iterator p, InputIterator first, InputIterator last);
    // initializer list (8)
    string& insert (const_iterator p, initializer_list<char> il);

- 查找：可以指定查找的起始位置 pos （缺省为 0）以及长度 n。没有找到则返回 ``string::npos`` 。
  ::

    // string (1)
    size_t find (const string& str, size_t pos = 0) const noexcept;
    // c-string (2)
    size_t find (const char* s, size_t pos = 0) const;
    // buffer (3)
    size_t find (const char* s, size_t pos, size_type n) const;
    // character (4)
    size_t find (char c, size_t pos = 0) const noexcept;


string 类的一个简明实现：

.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Code}`

  .. code-block:: cpp
    :linenos:

    #include<iostream>
    #include<cstring>
    #include<utility>

    class String
    {
    public:
        String(): _data(new char[1]){}
        String(const char* cs): _data(new char[1 + strlen(cs)])
        {
            strcpy(_data, cs); // strcpy: 目标字符串需要预先申请足够的空间以容纳源字符串
        }
        String(const String& s): _data(new char[1 + s.size()])
        {
            strcpy(_data, s.c_str());
        }
        String(String&& s): _data(s._data)
        {
            s._data = nullptr;
        }
        String& operator=(String rhs) // 传值参数
        {
            std::swap(_data, rhs._data);
            return *this;
        }
        ~String()
        {
            delete[] _data;
        }
        size_t size() const // const 成员函数
        {
            return strlen(_data);
        }
        const char* c_str() const // const 成员函数
        {
            return _data;
        }
        
        friend std::ostream& operator<<(std::ostream& out, const String& s);
    private:
        char* _data;
    };

    std::ostream& operator<<(std::ostream& out, const String& s)
    {
        out << s._data;
        return out;
    }

    int main()
    {
        String a; // 默认构造
        String b("abcddf"); // const char* 参数构造
        String c(b); // 拷贝构造
        a = b; // 赋值运算
        String d(std::move(b)); // 移动构造
        return 0;
    }

.. note::

  ``char* data = new char[10]`` 将数组的所有元素都初始化为 ``\0`` 。

.. tip::

  串接运算
    ``s = s + a`` 的效率低于 ``s += a`` 和 ``s.append(a)`` ，因为前者需要新构造一个临时对象， ``+=`` 实际上是调用了 ``append`` 。

to\_string函数
--------------------

::

  #include <string>

把 val 转化为字符串。

::

  string to_string (int val);
  string to_string (long val);
  string to_string (long long val);
  string to_string (unsigned val);
  string to_string (unsigned long val);
  string to_string (unsigned long long val);
  string to_string (float val);
  string to_string (double val);
  string to_string (long double val);


atoi，atof，atol
-------------------

::

  #include <cstdlib>

把 C 类型的字符串转换为数字（C++ 的 string 需要使用 ``c_str()`` 转换）。

::

  int atoi (const char * str);
  double atof (const char* str);
  long int atol ( const char * str );


size\_t和size\_type
------------------------

size\_t
^^^^^^^^^

size\_t 提供了一种可移植（不同平台下）的方法声明与系统可寻址的内存区域一致的长度。
size\_t 是通过 typedef 定义的一些 **无符号整型** 的别名，通常是 unsigned int，unsigned long 甚至是 unsigned long long。

常用于循环计数器、数组索引，或指针的算术运算。

VS 32位编译器：sizeof(size_t) = 32；VS 64位编译器：sizeof(size_t) = 64。

头文件
  - <cstddef>
  - <cstdio>
  - <cstring>
  - <ctime>
  - <cstdlib>
  - <cwchar>

size\_type
^^^^^^^^^^^^^^^

size\_type 是 STL 定义的类型属性，足够保持对应容器最大可能的容器大小，也是 **无符号整型** 。

size() 的返回类型就是 size\_type。把 size() 赋值给一个 int 变量，会有 warning。

VS 32位编译器
  - sizeof(string::size\_type) = 32
  - sizeof(vector<int>::size\_type) = 32
  - ...

VS 64位编译器
  - sizeof(string::size\_type) = 64
  - sizeof(vector<int>::size\_type) = 64
  - ...

.. warning::

   **无符号整型** 尤其是要注意下标为 0 时的边界情况。

   .. code-block:: cpp
    :linenos:

    vector<int> vec; // vec = {}
    for(size_t k = 0; k < vec.size() - 1; ++k) // 判断改为: k + 1 < vec.size()
    {
      cout << vec[k+1] - vec[k] << endl;
    }

  上例中，本意是只有当 vec 至少包含2个元素时，才输出。但是，当 vec.size() = 0，vec.size() - 1 = 2^32 - 1 或 2^64 - 1，
  而不是预想的 -1，陷入死循环。

  同样地，如果是反向遍历（下标自减），也需要注意循环终止条件。

  .. code-block:: cpp
    :linenos:

    // 正确
    for(size_t k = s.size(); k >= 1; --k)
    {
      cout << vec[k-1] << endl;
    }

    // 正确
    for(size_t k = s.size() - 1; k != -1; --k)
    {
      cout << vec[k] << endl;
    }

    // 死循环
    for(size_t k = s.size() - 1; k >= 0; --k)
    {
      cout << vec[k] << endl;
    }

    // 不进入循环
    for(size_t k = s.size() - 1; k > -1; --k)
    {
      cout << vec[k] << endl;
    }

  由于 size\_t 是无符号整型， ``size_t k = -1`` 其实是定义成了能够表示的最大整数，比如 ``string::npos`` 的定义是 ::

    static const size_t npos = -1;

  因此， ``k > -1`` 永远为 false，需要用 ``k != -1`` 作为循环终止条件。


参考资料
------------

1. C++ reference

  https://www.cplusplus.com/reference/stl/

  http://www.cplusplus.com/reference/iterator/

  http://www.cplusplus.com/reference/string/string

  http://www.cplusplus.com/reference/string/to_string

  http://www.cplusplus.com/reference/vector/vector

  http://www.cplusplus.com/reference/list/list

  http://www.cplusplus.com/reference/deque/deque

  http://www.cplusplus.com/reference/set/set

  http://www.cplusplus.com/reference/set/multiset

  http://www.cplusplus.com/reference/unordered_set/unordered_set

  http://www.cplusplus.com/reference/unordered_set/unordered_multiset

  http://www.cplusplus.com/reference/utility/pair/operators

  http://www.cplusplus.com/reference/map/map

  http://www.cplusplus.com/reference/map/multimap

  http://www.cplusplus.com/reference/unordered_map/unordered_map

  http://www.cplusplus.com/reference/unordered_map/unordered_multimap

  http://www.cplusplus.com/reference/stack/stack

  http://www.cplusplus.com/reference/queue/queue

  http://www.cplusplus.com/reference/queue/priority_queue



2. C++ STL快速入门

  https://www.cnblogs.com/skyfsm/p/6934246.html

3. STL教程：C++ STL快速入门（非常详细）

  http://c.biancheng.net/stl/

4. 标准C++中的string类的用法总结（转）

  https://www.cnblogs.com/aminxu/p/4686320.html

5. std::size\_t

  https://zh.cppreference.com/w/cpp/types/size_t

6. C++迭代器

  http://c.biancheng.net/view/338.html

  http://c.biancheng.net/view/6675.html

7. C++面试中string类的一种正确简明的写法

  https://www.cnblogs.com/Solstice/p/3362913.html
