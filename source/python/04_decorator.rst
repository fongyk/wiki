装饰器
========

作用
-----------
装饰器本质上是一个 Python 函数，它可以让其他函数在 **不需要做任何代码变动** 的前提下 **增加额外功能** ，装饰器的返回值也是一个函数对象。
它经常用于有切面需求的场景，比如：插入日志、性能测试、事务处理、缓存、权限校验等场景。
装饰器是解决这类问题的绝佳设计，有了装饰器，我们就可以抽离出大量与函数功能本身无关的雷同代码并继续重用。

概括的讲，装饰器的作用就是为已经存在的函数或对象添加额外的功能。

使用装饰器计时
-------------------

.. code-block:: python
    :linenos:

    from functools import wraps
    import time

    def timer(func):
        @wraps(func)
        def function_timer(*args, **kwargs):
            start_time = time.time()
            result = func(*args, **kwargs)
            end_time = time.time()
            print "time (s): ", end_time - start_time
            return result
        return function_timer

    @timer
    def foo():
        print "hello"
        return 0

    print foo.__name__
    print foo.__doc__

使用 ``wraps`` 可以保持函数 ``foo()`` 的属性 ``__name__`` 和 ``__doc__`` ，而不变成函数 ``function_timer`` 的相关属性。

@property
----------------

暴露属性
^^^^^^^^^^^^^^

.. code-block:: python
  :linenos:

  class Student(object):

      def __init__(self, value):
          self.score = value

.. code-block:: python
  :linenos:

  >>> obj = Student(10)
  >>> obj.score
  10
  >>> obj.score = -100
  >>> obj.score
  -100

直接把属性暴露出去，虽然写起来很简单，但是没办法检查参数，导致 ``score`` 可以被随意改动。

实例方法
^^^^^^^^^^^^^^

为了限制 ``score`` 的范围，可以通过一个 ``set_score()`` 方法来设置成绩，再通过一个 ``get_score()`` 方法来获取成绩。
这样，在 ``set_score()`` 方法里，就可以检查参数。

.. code-block:: python
  :linenos:

  class Student(object):

    def __init__(self, value):
        self._score = value

    def get_score(self):
        return self._score

    def set_score(self, value):
        if not isinstance(value, int):
            raise ValueError('score must be an integer !')
        if value < 0 or value > 100:
            raise ValueError('score must between 0 ~ 100 !')
        self._score = value

.. code-block:: python
  :linenos:

  >>> obj = Student(10)
  >>> obj.get_score()
  10
  >>> obj.set_score(-100)
  ValueError: score must between 0 ~ 100 !

但是，上面的调用方法又略显复杂，没有直接调用属性那么直接简单。

@property
^^^^^^^^^^^^^^

``@property`` 装饰器负责把一个方法变成属性。

.. code-block:: python
  :linenos:

  class Student(object):

    def __init__(self, value):
        self._score = value

    @property
    ## 把一个 getter 方法变成属性
    def score(self):
        return self._score

    @score.setter
    ## 把一个 setter 方法变成属性赋值
    def score(self, value):
        if not isinstance(value, int):
            raise ValueError('score must be an integer !')
        if value < 0 or value > 100:
            raise ValueError('score must between 0 ~ 100 !')
        self._score = value

.. code-block:: python
  :linenos:

  >>> obj = Student(10)
  >>> obj.score = 60
  >>> obj.score
  60
  >>> obj.score = -10
  ValueError: score must between 0 ~ 100 !

利用 ``@property`` ，对实例属性操作的时候，该属性很可能不是直接暴露的，而是通过 ``getter`` 和 ``setter`` 方法来实现的。

只定义 ``getter`` 方法，不定义 ``setter`` 方法就是一个只读属性。

参考资料
---------------

1. 详解Python的装饰器

  https://www.cnblogs.com/cicaday/p/python-decorator.html

2. 使用@property

  https://www.liaoxuefeng.com/wiki/897692888725344/923030547069856
