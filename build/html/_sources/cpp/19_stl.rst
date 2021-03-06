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

.. highlight:: cpp


string
-----------
::

  #include<string>

- 长度：length()，size()，empty()
- 访问：[pos]，at(pos)。at()返回位置pos处元素的引用，越界则抛出out\_of\_range异常。
- 字典序比较：==，!=，<，<=，>，>=
- 串接：+
- c_str()：返回指向C类型字符串的指针。
- 子串
  ::

    string substr(size_t pos = 0, size_t len = npos) const


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
- 尾部插入：push_back(x)
- 尾部弹出：pop_back()
- 迭代器插入：在position **之前** 插入元素。

  ::

    iterator insert (iterator position, const value_type& val)


- 尾部删除：pop_back()
- 申请空间：至少能容纳n个元素。

  ::

    void reserve (size_type n)


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
- 插入：push_front(x)，push_back(x)
- 删除：pop_front()，pop_back()
- 迭代器插入：在position **之前** 插入元素。

  ::

    iterator insert (iterator position, const value_type& val)


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
- 入栈：push(x)
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
- 入队：push(x)
- 出队：pop()

  ::

    void pop();


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

  http://www.cplusplus.com/reference/vector/vector

  http://www.cplusplus.com/reference/list/list

  http://www.cplusplus.com/reference/deque/deque

  http://www.cplusplus.com/reference/map/map

  http://www.cplusplus.com/reference/stack/stack

  http://www.cplusplus.com/reference/queue/queue


2. C++ STL快速入门

  https://www.cnblogs.com/skyfsm/p/6934246.html

3. STL教程：C++ STL快速入门（非常详细）

  http://c.biancheng.net/stl/

4. 标准C++中的string类的用法总结（转）

  https://www.cnblogs.com/aminxu/p/4686320.html

5. std::size\_t

  https://zh.cppreference.com/w/cpp/types/size_t
