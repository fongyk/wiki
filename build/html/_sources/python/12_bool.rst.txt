逻辑运算与布尔测试
=======================

逻辑运算
-------------

.. table:: 逻辑运算
  :align: center

  =================== ===============================================================
    运算符               描述
  =================== ===============================================================
     and                 与，x and y：如果x为False，返回False，否则返回y的 **计算值**
     or                  或，x or y：如果x为True，返回True，否则返回y的 **计算值**
     not                 非，not x：如果x为True，返回False，否则返回True
  =================== ===============================================================

.. code-block:: python
  :linenos:

  >>> print 'a'<'b' and 'c'
  c
  >>> print 'a'>'b' and 'c'
  False

  >>> print 'a'>'b' or 'c'
  c
  >>> print 'a'<'b' or 'c'
  True


成员运算
------------

.. table:: 成员运算
  :align: center

  =================== ==================================================================
    运算符               描述
  =================== ==================================================================
     in                 如果在指定列表/元组/字符串/字典中找到值，返回True，否则返回False
     not in             如果未在指定列表/元组/字符串/字典中找到值，返回True，否则返回False
  =================== ==================================================================

.. code-block:: python
  :linenos:

  >>> 1 in [1,2,3]
  True
  >>> 1 in (1,2)
  True
  >>> 'a' in 'abc'
  True

  >>> cnt = {'a':1}
  >>> 'a' in cnt
  True
  >>> {'a':1} in cnt
  TypeError: unhashable type: 'dict'


.. note::

  查找的值必须是可哈希的，也就是不可变类型。


布尔测试
--------------

下面对象的布尔值都是 ``False`` ：

  - False（布尔类型）

  - None

  - ""（空字符串）

  - []（空列表）

  - {}（空字典）

  - ()（空元组）

  - 所有值为零的数

    - 0（整型）

    - 0.0（浮点型）

    - 0L（长整型）

    - 0.0 + 0.0j（复数）

.. code-block:: python
  :linenos:

  flag = None
  if not flag:
      print "flag is none:", flag
      print flag==False

  flag = {}
  if not flag:
      print "flag is empty:", flag
      print flag == False
  flag = {'a':1}
  if flag:
      print "flag is not empty:", flag

  flag = []
  if not flag:
      print "flag is empty:", flag
      print flag == False
  flag = [1]
  if flag:
      print "flag is not empty:", flag

  flag = ""
  if not flag:
      print "flag is empty:", flag
      print flag == False
  flag = "a"
  if flag:
      print "flag is not empty:", flag

  flag = 0.0
  if not flag:
      print "flag is zero:", flag
      print flag == False
  flag = 1
  if flag:
      print "flag is not empty:", flag

输出结果为::

  flag is none: None
  False

  flag is empty: {}
  False
  flag is not empty: {'a': 1}

  flag is empty: []
  False
  flag is not empty: [1]

  flag is empty:        ## ""
  False
  flag is not empty: a

  flag is zero: 0.0
  True                  ## 只有这一个是True：0.0 == False
  flag is not empty: 1

.. note::

  布尔值是False，不代表等于False。

  零的布尔值是False，同时也等于False。


参考资料
-----------

1. Python基本数据类型

  https://www.cnblogs.com/littlefivebolg/p/8982889.html
