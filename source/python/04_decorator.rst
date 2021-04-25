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


@register
----------------

装饰器不是必须要修饰被装饰的函数，它还可以简单地注册一个函数，并将其解包返回。例如，可以使用它来创建一个轻量级插件体系结构:

.. code-block:: python
    :linenos:

    PLUGINS = dict()

    def register(func):
        """Register a function as a plug-in"""
        PLUGINS[func.__name__] = func
        return func
    
    @register
    def say_hello():
        print("hello")

    @register
    def say_goodbye():
        print("good bye")


    if __name__ == "__main__":
        import random
        say = random.choice(["say_hello", "say_goodbye"])
        PLUGINS[say]() ## 调用函数

缓存装饰器
-------------

LRU，即 Least Recently Used，最近最少使用，是一种常用的页面置换算法，选择最近最久未使用的页面予以淘汰。

``lru_cache`` 根据参数缓存每次函数调用结果，对于相同参数的，无需重新函数计算，直接返回之前缓存的返回值。 ``maxsize`` 指定了缓存的长度， ``typed=True`` 则不同类型的函数参数将单独缓存，例如，f(3)和f(3.0)将视为不同的调用。

.. code-block:: python
    :linenos:

    import functools

    @functools.lru_cache(maxsize=128, typed=False)
    def fibonacci(n:int) -> int:
        if n == 0: return 0
        elif n == 1: return 1
        elif n > 1: 
            return fibonacci(n-2) + fibonacci(n-1)


参考资料
---------------

1. 详解Python的装饰器

  https://www.cnblogs.com/cicaday/p/python-decorator.html

2. 使用@property

  https://www.liaoxuefeng.com/wiki/897692888725344/923030547069856

3. Python 装饰器入门(上)

  https://www.cnblogs.com/flashBoxer/p/9847521.html
