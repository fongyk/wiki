指针与引用
====================

**1**. **非常量** 指针可以被重新赋值，指向另一个对象；引用是对象的别名，必须初始化并总是指向（代表）最初绑定的那个对象。

**2**. 有 ``null pointer`` ，没有 ``null reference`` ，故使用前无需检查是非为空。

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

**3**. 例子。

.. code-block:: cpp
    :linenos:

    string s1("nancy");
    string s2("candy");
    string& rs = s1;
    string* ps = &s2;
    rs = s2; // rs仍指向s1，但是s1值变为"candy"。
    ps = &s2; // ps指向s2，s1无变化