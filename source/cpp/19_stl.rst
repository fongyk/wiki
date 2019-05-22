常用STL类及容器
==================

**STL: Standard Template Library** ，标准模板库。

顺序容器
  - array
  - vector
  - list
  - deque
  - string
  - ...

关联容器
  - set
  - map
  - multiset
  - multimap
  - ...

容器适配器
  - stack
  - queue
  - priority_queue


一个容器适配器接受一种已有的容器类型，使其行为看起来像一种不同的类型。默认情况下，stack和queue基于deque实现，priority_queue基于vector实现。


.. highlight:: cpp


string
-----------
::

  #include<string>

- 长度：length()，size()，empty()
- 访问：[pos]，at(pos)。at()返回位置pos处元素的引用，越界则抛出 ``out_of_range`` 异常。
- 字典序比较：==，!=，<，<=，>，>=
- 串接：+
- c_str()：返回指向C类型字符串的指针。如果需要使用C的字符串函数如strcmp、strcpy等，需要使用c_str()。
  ::

    const char* c_str() const noexcept;

- 子串
  ::

    string substr(size_t pos = 0, size_t len = npos) const

- 插入：支持下标索引插入，在位置pos **之前** 插入元素。插入元素之后，该元素的位置为 position。（与python中list类的插入功能一致）
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
    string& insert (size_t pos,   size_t n, char c);
    iterator insert (const_iterator p, size_t n, char c);
    // single character (6)
    iterator insert (const_iterator p, char c);
    // range (7)
    template <class InputIterator>
    iterator insert (iterator p, InputIterator first, InputIterator last);
    // initializer list (8)
    string& insert (const_iterator p, initializer_list<char> il);


vector
------------
::

  #include<vector>

**底层实现：顺序表（数组）。**

- 元素个数：size()，empty()
- 逐元素比较：==，!=，<，<=，>，>=
- 内存空间：capcity()
- 访问：[pos]，at(pos)
- 头部元素：front()，返回的是引用
- 尾部元素：back()，返回的是引用
- 尾部插入：push_back(x)，emplace_back(x)
- 尾部弹出：pop_back()
- 迭代器插入：在position **之前** 插入元素。

  ::

    iterator insert (iterator position, const value_type& val);

    template <class... Args>
    iterator emplace (const_iterator position, Args&&... args);


- 尾部删除：pop_back()
- 申请空间：至少能容纳n个元素（capcity()为n）。

  ::

    void reserve (size_type n)

- 改变大小：将元素个数变为n。如果指定val且n大于原来的size，则使用val填充新元素，原来的元素不变；如果n小于原来的size，则丢弃尾部元素。

  ::

    void resize (size_type n);
    void resize (size_type n, const value_type& val);

- 赋值

  - 数组或其他向量区间 [first,last) 内的值赋给当前向量。

    ::

      template <class InputIterator>
      void assign (InputIterator first, InputIterator last)


  - 赋予n个val元素给当前向量。

    ::

      void assign (size_type n, const value_type& val)

- 删除：删除一个元素之后，此位置之后所有元素往前移动。虽然当前迭代器没有+1，但是由于后续元素的前移，相当于迭代器自动指向了下一个元素。故删除了一个元素之后如果要访问下一个元素，不必执行it++。

  ::

    iterator erase (const_iterator position);
    iterator erase (const_iterator first, const_iterator last); // 区间 [first,last)

- 清除：

  - ``vector< value_type >().swap(myVec)``
  - ``myVec.clear()`` 让myVec.size()为0，但是myVec.capcity()不为0，调用 ``myVec.clear()`` 之后再调用 ``myVec.shrink_to_fit()`` 。 ``shrink_to_fit()`` 的作用是减小capcity()以匹配size()。



list
---------
::

  #include<list>

**底层实现：双向链表。**

- 元素个数：size()，empty()
- 表首元素：front()
- 表尾元素：back()
- 插入：push_front()，push_back()，emplace_front()，emplace_back()
- 删除：pop_front()，pop_back()
- 迭代器插入：在position **之前** 插入元素。

  ::

    iterator insert (iterator position, const value_type& val)


deque
---------
::

  #include<deque>

**底层实现：循环队列。**

- 元素个数：size()，empty()
- 队首元素：front()
- 队尾元素：back()
- 插入：push_front(x)，push_back(x)，emplace_front(x)，emplace_back(x)
- 删除：pop_front()，pop_back()
- 迭代器插入：在position **之前** 插入元素。

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

``map<K，T>::key_type`` ：键类型

``map<K，T>::mapped_type`` ：值类型

``map<K，T>::value_type`` ：pair类型， ``<map<K，T>::key_type, map<K，T>::mapped_type>``

- 访问：[key]，at(key)

  - [key]，key不存在，会创建新的键值对。

  - at(key)，key不存在，抛出out\_of\_range异常。

- 查找：找不到key则返回 ``map::end`` 。

  ::

    iterator find (const key_type& k);
    const_iterator find (const key_type& k) const;

- 插入：如果key已经存在，则插入无效。map的元素自动按照key升序排序，不能人为对map进行排序。

  ::

    pair<iterator,bool> insert (const value_type& val);


- 删除：返回删除元素后的下一个元素的迭代器，当前迭代器失效。

  ::

    iterator  erase (const_iterator position);
    size_type erase (const key_type& k);
    iterator  erase (const_iterator first, const_iterator last);

  ``it = myMap.erase(it)`` 等效为 ``myMap.erase(it++)`` 。


例子

.. code-block:: cpp
  :linenos:

  #include <iostream>
  #include <map>

  int main ()
  {
    std::map<char,int> mymap;

    // first insert function version (single parameter):
    mymap.insert ( std::pair<char,int>('a',100) );
    mymap.insert ( std::map<char,int>::value_type('z',200) );

    std::pair<std::map<char,int>::iterator,bool> ret;
    ret = mymap.insert ( std::pair<char,int>('z',500) );
    if (ret.second==false)
    {
      std::cout << "element 'z' already existed";
      std::cout << " with a value of " << ret.first->second << '\n';
    }

    return 0;
  }



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

  C++11标准引入了 **emplace_front** ，**emplace** ，**emplace_back** 这些操作构造而不是拷贝元素，分别对应 **push_front** ，**insert/push** ，**push_back** 。

  调用 push 或 insert 时，先创建一个元素类型的 **临时对象** ，这个对象被 **拷贝** 到容器中。

  调用 emplace 时，将 **参数** 传递给元素类型的 **构造函数** ，在容器管理的内存空间中使用这些参数直接构造元素。传递给 emplace 的参数必须与构造函数匹配。



to\_string函数
--------------------

::

  #include <string>

把val转化为字符串。

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

把C类型的字符串转换为数字（C++的string需要使用 ``c_str()`` 转换）。

::

  int atoi (const char * str);
  double atof (const char* str);
  long int atol ( const char * str );


size\_t和size\_type
------------------------

size\_t
^^^^^^^^^

size\_t 提供了一种可移植（不同平台下）的方法声明与系统可寻址的内存区域一致的长度。
size\_t 是通过typedef定义的一些 **无符号整型** 的别名，通常是 unsigned int，unsigned long 甚至是unsigned long long。

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

size\_type 是STL定义的类型属性，足够保持对应容器最大可能的容器大小。也是 **无符号整型** 。

size() 的返回类型就是size\_type。把 size() 赋值给一个 int 变量，会有 warning。

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

  上例中，本意是只有当 vec 至少包含2个元素时，才输出。但是，当 vec.size() = 0，vec.size() - 1 = 2^32 - 1 或2^64 - 1，
  而不是预想的 -1。



参考资料
------------

1. C++ reference

  http://www.cplusplus.com/reference/string/string

  http://www.cplusplus.com/reference/string/to_string

  http://www.cplusplus.com/reference/vector/vector

  http://www.cplusplus.com/reference/list/list

  http://www.cplusplus.com/reference/deque/deque

  http://www.cplusplus.com/reference/utility/pair/operators

  http://www.cplusplus.com/reference/map/map

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
