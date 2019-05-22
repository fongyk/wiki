装饰器
========

作用
-----------
装饰器本质上是一个Python函数，它可以让其他函数在 **不需要做任何代码变动** 的前提下 **增加额外功能** ，装饰器的返回值也是一个函数对象。
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

参考资料
---------------

1. 详解Python的装饰器

  https://www.cnblogs.com/cicaday/p/python-decorator.html
