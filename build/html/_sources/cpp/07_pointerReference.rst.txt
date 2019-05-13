指针与引用
====================

**1**. 指针是一个对象，有存储的 **值** 和 **地址** ，存储的数据类型是数据的地址；非常量指针可以被重新赋值，指向另一个对象。引用是对象的别名，必须初始化并总是指向（代表）最初绑定的那个对象，对对象及其引用进行取地址操作得到的结果相同。

.. code-block:: cpp
  :linenos:

  #include <iostream>
  using namespace std;

  int main(int argc, char ** argv)
  {
    int k = 1;
    int* pk = &k;
    int& rk = k;

    cout << "&k:" << &k << endl;   // 0029FC44
    cout << "k:" << k << endl;     // 1

    cout << "&pk:" << &pk << endl; // 0029FC68
    cout << "pk:" << pk << endl;   // 0029FC44 (pk = &k)
    cout << "*pk" << *pk << endl;  // 1

    cout << "&rk:" << &rk << endl; // 0029FC44 (&rk = &k)
    cout << "rk:" << rk << endl;   // 1

    return 0;
  }


**2**. 指针可以有多级，但是引用只能是一级（不存在 *引用的引用* ）。

**3**. 有 ``null pointer`` ，没有 ``null reference`` ，故使用前无需检查是非为空。

.. code-block:: cpp
    :linenos:

    void rValue(const int &x)
    {
        cout << x << endl;
    }

    void pValue(const int* p)
    {
        if(p) cout << *p << endl;
    }

**4**. 例子。

.. code-block:: cpp
    :linenos:

    string s1("nancy");
    string s2("candy");
    string& rs = s1;
    string* ps = &s2;
    rs = s2; // rs仍指向s1，但是s1值变为"candy"。
    ps = &s2; // ps指向s2，s1无变化
