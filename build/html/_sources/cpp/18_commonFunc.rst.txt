常用函数
==============

以下函数基于 C++11 标准。

lower\_bound，upper\_bound
-------------------------------

.. highlight:: cpp

::

  #include <algorithm>

**lower_bound** 从排好序的数组区间 **[first, last)** 中，采用二分查找，返回 **大于或等于** val 的 **第一个** 元素位置。
如果所有元素都小于 val，则返回 last。

::

  template <class ForwardIterator, class T>
  ForwardIterator lower_bound (ForwardIterator first, ForwardIterator last, const T& val);


**upper_bound** 从排好序的数组区间 **[first, last)** 中，采用二分查找，返回 **大于** val 的 **第一个** 元素位置。
如果所有元素都不大于 val，则返回 last。

::

  template <class ForwardIterator, class T>
  ForwardIterator upper_bound (ForwardIterator first, ForwardIterator last, const T& val);


求有序数组中 val 的个数： ::

  upper_bound(first, last, val) - lower_bound(first, last, val);


.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Example}`

  .. code-block:: cpp
    :linenos:

    #include <iostream>
    #include <vector>
    #include <algorithm>
    using namespace std;

    int main(int argc, char ** argv)
    {
      int a[11] = {1,2,3,4,5,5,5,5,6,7,8};
      cout << lower_bound(a, a + 11, 5) - a << endl; // 4
      cout << upper_bound(a, a + 11, 5) - a << endl; // 8
      vector<int> v(a, a + 11); // 用 a 对 v 初始化
      cout << lower_bound(v.begin(), v.end(), 5) - v.begin() << endl; // 4
      cout << upper_bound(v.begin(), v.end(), 5) - v.begin() << endl; // 8

      *lower_bound(a, a + 11, 5) = 500;
      for (auto ai : a) cout << ai << ends; // 1 2 3 4 500 5 5 5 6 7 8
      cout << endl;

      *lower_bound(v.begin(), v.end(), 5) = 500;
      for (auto vi : v) cout << vi << ends; // 1 2 3 4 500 5 5 5 6 7 8
      cout << endl;

      return 0;
    }

.. note:: 

    map、multimap、set、multiset 是基于红黑树实现的、有序的，其中 map、multimap 默认按照 key 排序。
    这四种模板都自带 lower_bound 和 upper_bound 成员函数。

    ::

        map<int,int> m;
        int val = 5;
        auto it = m.lower_bound(val);

    相当于 ::

        auto it = lower_bound(
            m.begin(), 
            m.end(), 
            val,
            [](pair<int,int> p, const int v){return p.first < v;}
        );


fill，fill\_n，for\_each
-----------------------------

::

  #include <algorithm>

**fill** 函数将一个区间 **[first, last)** 的每个元素都赋予 val 值。 ::

  template <class ForwardIterator, class T>
  void fill (ForwardIterator first, ForwardIterator last, const T& val);

**fill_n** 函数从 **first** 开始依次赋予 n 个元素 val 值。 ::

  template <class OutputIterator, class Size, class T>
  void fill_n (OutputIterator first, Size n, const T& val);

**for_each** 把函数 fn 应用于区间 **[first, last)** 的每个元素。 ::

  template <class InputIterator, class Function>
  Function for_each (InputIterator first, InputIterator last, Function fn)
  {
    while (first!=last)
    {
      fn (*first);
      ++first;
    }
    return fn;      // or, since C++11: return move(fn);
  }

``fn`` 是一个一元谓词（unary predicate），接受一个参数，其返回值被忽略。``fn`` 可以是一个函数指针或函数对象。

.. note::

    函数对象
      如果一个类将 ``()`` 运算符重载为成员函数，这个类就称为函数对象类，这个类的对象就是函数对象。
      函数对象是一个对象，但是使用的形式看起来像函数调用，实际上也执行了函数调用。

.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Example}`

  .. code-block:: cpp
    :linenos:

    #include <iostream>
    #include <vector>
    #include <algorithm>
    using namespace std;

    template<class T>
    void print(T elem){ cout << elem << " "; }

    struct myclass
    {
      void operator() (int elem) { cout << elem << " "; }
    }myobject;
    // 注意：这里重载的是 () 运算符，接受一个参数；myobject 是一个结构体变量（类对象），调用 myobject(6) 会打印 6。

    int main(int argc, char ** argv)
    {

      float a[4] = { 0.0 }; // {0.0, 0.0, 0.0, 0.0}
      vector<int> v(4, 0); // {0, 0, 0, 0}

      fill(a, a+4, 3.3); // {3.3, 3.3, 3.3, 3.3}
      fill_n(a, 2, 6.6); // {6.6, 6.6, 3.3, 3.3}
      fill_n(v.begin(), 4, 9); // {9, 9, 9, 9}

      for_each(a, a + 4, print<float>); //  6.6 6.6 3.3 3.3
      cout << endl;
      for_each(v.begin(), v.end(), print<int>); //  9 9 9 9
      cout << endl;
      for_each(v.begin(), v.end(), myobject); //  9 9 9 9
      cout << endl;

      int b[10][20];
      fill(b[0], b[0] + 200, 2); // b 所有元素为 2

      return 0;
    }


最长上升子序列：

.. code-block:: cpp
  :linenos:
  :emphasize-lines: 13-15

  /* https://leetcode.com/problems/longest-increasing-subsequence/ */
  /* O(nlogn) in time.*/

  class Solution
  {
  public:
    int lengthOfLIS(vector<int>& nums)
    {
      if(nums.size()<=1) return nums.size();
      int inf = INT_MAX;
      int len = nums.size();
      int* dp = new int[len];
      fill(dp, dp+len, inf);
      for(int k = 0; k < len; ++k) *lower_bound(dp, dp+len, nums[k]) = nums[k];
      int length = lower_bound(dp, dp+len, inf) - dp;
      delete[] dp;
      return length;
    }
  };

sort
---------

::

  #include <algorithm>

  // default
  template <class RandomAccessIterator>
  void sort (RandomAccessIterator first, RandomAccessIterator last);

  // custom
  template <class RandomAccessIterator, class Compare>
  void sort (RandomAccessIterator first, RandomAccessIterator last, Compare comp);

``comp`` 是一个二元谓词（binary predicate），接受两个参数，返回 bool 型或一个可以转换为 bool 型的类型。``comp`` 可以是一个函数指针或函数对象。

如果需要稳定排序，可以使用 ``stable_sort`` 直接代替 ``sort`` 。

.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Example}`

  .. code-block:: cpp
    :linenos:

    #include <iostream>
    #include <vector>
    #include <functional>
    #include <algorithm>
    using namespace std;

    bool comparator(int i, int j)
    {
      return (i < j);
    }

    struct myclass
    {
      bool operator() (int i, int j)
      {
        return (i < j);
      }
    } myobject;
    // 注意：这里重载的是 () 运算符，接受两个参数；myobject 是一个结构体变量（类对象）

    int main(int argc, char ** argv)
    {

      int a[] = { 32, 71, 12, 45, 26, 80, 53, 33 };
      vector<int> v(a, a + 8);               // 32 71 12 45 26 80 53 33

      // using default comparison (operator <):
      sort(v.begin(), v.begin() + 4);           //(12 32 45 71)26 80 53 33

      // using comparator as comp，这里是相当于一个函数指针
      sort(v.begin() + 4, v.end(), comparator); // 12 32 45 71(26 33 53 80)

      // using object as comp，这里是一个函数对象
      sort(v.begin(), v.end(), myobject);     //(12 26 32 33 45 53 71 80)

      // using build-in comp: 类模板 greater 的类对象
      sort(v.begin(), v.end(), greater<int>()); // (80 71 53 45 33 32 26 12)

      // using build-in comp: 类模板 less 的类对象
      sort(v.begin(), v.end(), less<int>());  //(12 26 32 33 45 53 71 80)

      // using reverse_iterator
      sort(v.rbegin(), v.rend());  // (80 71 53 45 33 32 26 12)

      // sort array
      sort(a, a + 8, greater<int>());  // (80 71 53 45 33 32 26 12)
      sort(a, a + 8);                 // (12 26 32 33 45 53 71 80)，可使用 comparator、myobject、less<int>()

      return 0;
    }


**string** 类也是可以排序的，如 ::

  string str;
  sort(str.begin(), str.end());


.. warning::

  如果把自定义的 ``comparator`` 函数封装为类的成员函数，应该定义为 **静态成员函数（static）** 。


reverse
-------------------

::

  #include <algorithm>

  template <class BidirectionalIterator>
  void reverse (BidirectionalIterator first, BidirectionalIterator last);

翻转区间 [first, last) 内的元素。适用于 vector、string 以及 静态数组、动态数组等。

.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Example}`

  .. code-block:: cpp
    :linenos:

    #include <iostream>     // std::cout
    #include <algorithm>    // std::reverse
    #include <numeric>      // std::iota
    #include <vector>       // std::vector

    int main ()
    {
      std::vector<int> myvector;

      // set some values:
      myvector.resize(9);
      std::iota(myvector.begin(), myvector.end(), 1);   // 1 2 3 4 5 6 7 8 9

      std::reverse(myvector.begin(),myvector.end());    // 9 8 7 6 5 4 3 2 1

      // print out content:
      std::cout << "myvector contains:";
      for (std::vector<int>::iterator it=myvector.begin(); it!=myvector.end(); ++it)
        std::cout << ' ' << *it;
      std::cout << '\n';

      return 0;
    }


min\_element，max\_element，minmax\_element
--------------------------------------------------------
::

  #include <algorithm>

- **min_element** ：会返回指向输入序列的最小元素的迭代器；
- **max_element** ：会返回指向最大元素的迭代器；
- **minmax_element** ：会以 pair 对象的形式返回这两个迭代器。first 指向最小元素；second 指向最大元素。

**min\_element**::

  // default
  template <class ForwardIterator>
  ForwardIterator min_element (ForwardIterator first, ForwardIterator last);

  // custom
  template <class ForwardIterator, class Compare>
  ForwardIterator min_element (ForwardIterator first, ForwardIterator last, Compare comp); // [first, last)



.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Example}`

  .. code-block:: cpp
    :linenos:

    #include <iostream>
    #include <algorithm>
    using namespace std;

    int main(int argc, char ** argv)
    {

      int a[10] = { 1, 2, 3, 4, 5, 6 };
      cout << a[9] << endl; // 0

      cout << *min_element(a, a + 10) << endl; // 0

      cout << *max_element(a, a + 10) << endl; // 6

      auto p = minmax_element(a, a + 10);

      cout << *p.first << ends << *p.second << endl; // 0 6

      return 0;
    }


accumulate
----------------

::

  #include <numeric>

  // sum
  template <class InputIterator, class T>
  T accumulate (InputIterator first, InputIterator last, T init);

  // custom
  template <class InputIterator, class T, class BinaryOperation>
  T accumulate (InputIterator first, InputIterator last, T init, BinaryOperation binary_op);

累加区间 **[first, last)** 的元素，并加上 **init** 。

.. container:: toggle

    .. container:: header

      :math:`\color{darkgreen}{Example}`

    .. code-block:: cpp
      :linenos:

      #include <iostream>     // std::cout
      #include <functional>   // std::minus
      #include <numeric>      // std::accumulate

      int myfunction (int x, int y) {return x+2*y;}

      struct myclass
      {
      	int operator()(int x, int y) {return x+3*y;}
      } myobject;

      int main ()
      {
        int init = 100;
        int numbers[] = {10,20,30};

        std::cout << "using default accumulate: ";
        std::cout << std::accumulate(numbers,numbers+3,init); // 100 + (10 + 20 + 30)
        std::cout << '\n';

        std::cout << "using functional's minus: ";
        std::cout << std::accumulate (numbers, numbers+3, init, std::minus<int>()); // 100 - (10 + 20 + 30)
        std::cout << '\n';

        std::cout << "using custom function: ";
        std::cout << std::accumulate (numbers, numbers+3, init, myfunction); // 100 + 2 * (10 + 20 + 30)
        std::cout << '\n';

        std::cout << "using custom object: ";
        std::cout << std::accumulate (numbers, numbers+3, init, myobject); // 100 + 3 * (10 + 20 + 30)
        std::cout << '\n';

        return 0;
      }


partial_sum
---------------

::

  #include <numeric>

累加，并把结果存到序列（数组、向量） **result** 中。

::

  // sum
  template <class InputIterator, class OutputIterator>
  OutputIterator partial_sum (InputIterator first, InputIterator last, OutputIterator result);

  // custom
  template <class InputIterator, class OutputIterator, class BinaryOperation>
  OutputIterator partial_sum (InputIterator first, InputIterator last,
                              OutputIterator result,
                              BinaryOperation binary_op);

  // y0 = x0
  // y1 = x0 + x1
  // y2 = x0 + x1 + x2
  // y3 = x0 + x1 + x2 + x3
  // y4 = x0 + x1 + x2 + x3 + x4
  // ... ... ...


.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Example}`

  .. code-block:: cpp
    :linenos:

    #include <iostream>     // std::cout
    #include <functional>   // std::multiplies
    #include <numeric>      // std::partial_sum
    #include <vector>

    int myop (int x, int y) {return x+y+1;}

    int main ()
    {
      int val[] = {1,2,3,4,5};
      int result[5];

      std::partial_sum (val, val+5, result);
      std::cout << "using default partial_sum: ";
      for (int i=0; i<5; i++) std::cout << result[i] << ' '; // 1 3 6 10 15
      std::cout << '\n';

      std::vector<int> result_vec(6, 0); // 0 0 0 0 0 0
      std::partial_sum (val, val+5, result_vec.begin()); // 1 3 6 10 15 0

      std::partial_sum (val, val+5, result, std::multiplies<int>()); // 1 2 6 24 120
      std::cout << "using functional operation multiplies: ";
      for (int i=0; i<5; i++) std::cout << result[i] << ' ';
      std::cout << '\n';

      std::partial_sum (val, val+5, result, myop); // 1 4 8 13 19
      std::cout << "using custom function: ";
      for (int i=0; i<5; i++) std::cout << result[i] << ' ';
      std::cout << '\n';
      return 0;
    }



iota
---------------

::

  #include <numeric>

  template <class ForwardIterator, class T>
  void iota (ForwardIterator first, ForwardIterator last, T val);

采用递增的形式，将 val 开始的等差数列赋值给区间 [first, last) 的元素。

.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Example}`

  .. code-block:: cpp
    :linenos:

    #include <iostream>     // std::cout
    #include <numeric>      // std::iota

    int main () {
      float numbers[10];

      std::iota (numbers,numbers+10,3.5);

      std::cout << "numbers:";
      for (float& i:numbers) std::cout << ' ' << i; // 3.5 4.5 5.5 6.5 7.5 8.5 9.5 10.5 11.5 12.5
      std::cout << '\n';

      return 0;
    }



inner\_product
------------------

::

  #include <numeric>

  // sum/multiply
  template <class InputIterator1, class InputIterator2, class T>
  T inner_product (InputIterator1 first1, InputIterator1 last1, InputIterator2 first2, T init);

  // custom
  template <class InputIterator1, class InputIterator2, class T, class BinaryOperation1, class BinaryOperation2>
  T inner_product (InputIterator1 first1, InputIterator1 last1,
                   InputIterator2 first2,
                   T init,
                   BinaryOperation1 binary_op1,
                   BinaryOperation2 binary_op2);

内积运算，再与 **init** 做运算::

  while (first1!=last1)
  {
    init = init + (*first1)*(*first2);
    // or: init = binary_op1 (init, binary_op2(*first1,*first2));
    ++first1; ++first2;
  }
  return init;

.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Example}`

  .. code-block:: cpp
    :linenos:

    #include <iostream>     // std::cout
    #include <functional>   // std::minus, std::divides
    #include <numeric>      // std::inner_product

    int myaccumulator (int x, int y) {return x-y;}
    int myproduct (int x, int y) {return x+y;}

    int main ()
    {
      int init = 100;
      int series1[] = {10,20,30};
      int series2[] = {1,2,3};

      std::cout << "using default inner_product: ";
      std::cout << std::inner_product(series1,series1+3,series2,init); // 100 + (10*1 + 20*2 + 30*3)
      std::cout << '\n';

      std::cout << "using functional operations: ";
      std::cout << std::inner_product(series1,series1+3,series2,init,
                                      std::minus<int>(),std::divides<int>()); // 100 - (10/1 + 20/2 + 30/3)
      std::cout << '\n';

      std::cout << "using custom functions: ";
      std::cout << std::inner_product(series1,series1+3,series2,init,
                                      myaccumulator,myproduct); // 100 - (10+1 + 20+2 + 30+3)
      std::cout << '\n';

      return 0;
    }



memset
------------------

::

  #include <cstring>

  void *memset ( void * ptr, int value, size_t num );

**memset** 按 **字节** 赋值， **fill** 按 **元素** 赋值。

如果用 memset 给 int 型变量赋值，只能是 0 或 -1。

.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Example}`

  .. code-block:: cpp
    :linenos:

    #include <iostream>
    #include <cstring>

    int main()
    {
      char str[] = "almost every programmer should know memset!";
      memset (str,'-',6);
      cout << str << endl; // ------ every programmer should know memset!

      int a[10][10];
      memset(a, -1, sizeof(a)); // 或者 10*10*sizeof(int)，全部赋值为-1
      for(int e:a) cout << bitset<sizeof(int)*8>(e) << endl; // 11111111  11111111  11111111  11111111 （补码）

      int b[5];
      memset(b, 1, sizeof(b));// 或者 5*sizeof(int)，全部赋值为 16843009
      for(int e:b) cout << bitset<sizeof(int)*8>(e) << endl; // 00000001 00000001 00000001 00000001 （int型占4字节，每个字节都赋值为1）

      return 0;
    }


附：头文件
----------------

- ``cmath``

  - pow()

  - sqrt()

  - floor()

  - ceil()

  - round()

  - log()

  - log10()

  - exp()

- ``cstdlib``

  - abs()

  - fabs()

  - rand()

- ``limits``

  - INT_MIN: ``(signed int)0x80000000``

  - INT_MAX: ``0x7fffffff``

- ``algorithm``

  - min()

  - max()

- ``utility``

  - pair

  - move

- ``functional``

  - less< *TYPE* >()

  - greater< *TYPE* >()

- ``cassert``

  - assert()



参考资料
--------------

1. C++ reference

  http://www.cplusplus.com/reference/algorithm/lower_bound

  http://www.cplusplus.com/reference/algorithm/upper_bound

  http://www.cplusplus.com/reference/algorithm/fill

  http://www.cplusplus.com/reference/algorithm/for_each

  http://www.cplusplus.com/reference/algorithm/sort

  http://www.cplusplus.com/reference/algorithm/reverse

  http://www.cplusplus.com/reference/algorithm/min_element

  http://www.cplusplus.com/reference/numeric/accumulate

  http://www.cplusplus.com/reference/numeric/partial_sum

  http://www.cplusplus.com/reference/numeric/iota

  http://www.cplusplus.com/reference/numeric/inner_product

  http://www.cplusplus.com/reference/cstring/memset


2. C/C++-STL中lower_bound与upper_bound的用法

  https://blog.csdn.net/jadeyansir/article/details/77015626

3. c++sort函数的使用总结

  https://www.cnblogs.com/TX980502/p/8528840.html

4. C++ sort排序函数用法

  https://blog.csdn.net/w_linux/article/details/76222112
