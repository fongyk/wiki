数组形参
================

非引用
-------------------

当数组以 **非引用** 类型传递，数组会悄悄退化为指针，形参复制的是这个指针的值（指向数组第一个元素）。通过该形参做的任何改变都是在修改数组元素本身。

.. code-block:: cpp
    :linenos:

    void func1(int arr[100])
    {
        cout << sizeof(arr) << endl; // 指针的大小为4（32位编译器）
        /*
            function body
        */
    }

    void func2(int *arr)
    {
        cout << sizeof(arr) << endl; // 指针的大小为4（32位编译器）
        /*
            function body
        */
    }
    
    int a[10] = {1,2,3};
    func2(a);




引用
--------

如果形参是数组的 **引用** ，编译器不会将数组实参转化为指针，而是传递数组的引用本身。编译器会检查数组实参的大小与形参是否匹配。


.. code-block:: cpp
    :linenos:

    void func1(int (&arr)[10])
    {
        cout << sizeof(arr) << endl; // 大小为4*10=40（32位编译器）
        /*
            function body
        */
    }
    
    int a[10] = {1,2,3};
    func2(a);