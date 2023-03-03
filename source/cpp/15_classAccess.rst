public、protected、private
=============================

.. table:: 类成员访问权限（可访问： :math:`\checkmark`）
  :align: center

  ============   ====================   ====================   ====================   ====================
    权限            类成员                    类对象                   派生类成员               友元函数
  ============   ====================   ====================   ====================   ====================
    public        :math:`\checkmark`     :math:`\checkmark`     :math:`\checkmark`    :math:`\checkmark`
    private       :math:`\checkmark`       :math:`\times`        :math:`\times`        :math:`\checkmark`
    protected     :math:`\checkmark`       :math:`\times`        :math:`\checkmark`    :math:`\checkmark`
  ============   ====================   ====================   ====================   ====================

继承
----------------

.. table:: public继承下对基类成员的访问权限
  :align: center

  ============   =========================   ======================   ======================
    内部权限       权限变化(相对于派生类)           派生类成员              派生类对象
  ============   =========================   ======================   ======================
    public            -> public                :math:`\checkmark`       :math:`\checkmark`
    private           -> private               :math:`\times`           :math:`\times`
    protected         -> protected             :math:`\checkmark`       :math:`\times`
  ============   =========================   ======================   ======================


.. table:: private继承下对基类成员的访问权限
  :align: center

  ============   =========================   ======================   ======================
    内部权限       权限变化(相对于派生类)           派生类成员                派生类对象
  ============   =========================   ======================   ======================
    public            -> private               :math:`\checkmark`         :math:`\times`
    private           -> private               :math:`\times`             :math:`\times`
    protected         -> private               :math:`\checkmark`         :math:`\times`
  ============   =========================   ======================   ======================

.. table:: protected继承下对基类成员的访问权限
  :align: center

  ============   =========================   ======================   ======================
    内部权限       权限变化(相对于派生类)           派生类成员                派生类对象
  ============   =========================   ======================   ======================
    public            -> protected             :math:`\checkmark`         :math:`\times`
    private           -> private               :math:`\times`             :math:`\times`
    protected         -> protected             :math:`\checkmark`         :math:`\times`
  ============   =========================   ======================   ======================


class 与 struct
-------------------

class 不写权限修饰符，成员默认是 ``private`` ；struct 的成员默认是 ``public`` 。

class 的继承默认是 ``private`` ，struct 的继承默认是 ``public`` 。


参考资料
----------------

1. C++中关于public、protect、private的访问权限控制

  https://blog.csdn.net/ycf74514/article/details/49053041

2. C++的关键字public,private和protected

  https://www.jianshu.com/p/943c0d2fe292

3. C++中public,protected,private访问

  https://www.cnblogs.com/jiudianren/p/5668438.html
