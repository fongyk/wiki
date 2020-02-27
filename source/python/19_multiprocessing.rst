multiprocessing
==================

multiprocessing，基于进程的并行。

Process 类
----------------

::

    class multiprocessing.Process(group=None, target=None, name=None, args=(), kwargs={}, *, daemon=None)

进程对象表示在单独进程中运行的活动。

参数说明：

- ``group`` 应该始终是 ``None`` ，它仅用于兼容 ``threading.Thread`` 。 ``target`` 是由 ``run()`` 方法调用的可调用对象；默认为 ``None`` ，意味着什么都没有被调用。 
- ``name`` 是进程名称。
- ``args`` 是目标调用的参数元组；``kwargs`` 是目标调用的关键字参数字典。
- ``daemon`` 是进程的守护标志，一个布尔值，必须在 ``start()`` 被调用之前设置；初始值继承自创建进程。

常用方法、属性：

- ``run()`` ：表示进程活动的方法，可以在子类中重载此方法。标准 ``run()`` 方法调用传递给对象构造函数的可调用对象（ ``target`` ）。
- ``start()`` ：启动进程活动，每个进程对象最多只能调用一次；它会将对象的 ``run()`` 方法安排在一个单独的进程中调用。
- ``join([timeout])`` ：使主调进程（包含 ``p.join()`` 语句的进程）阻塞，直至被调用进程 ``p`` 运行结束或超时（指定 ``timeout`` ）。
- ``is_alive()`` ：返回进程是否处于活动状态。粗略地说，从 ``start()`` 方法返回到子进程终止之前，进程对象仍处于活动状态。
- ``name`` ：进程的名称，是一个字符串，仅用于识别目的；可以为多个进程指定相同的名称。
- ``pid`` ：进程ID，在生成该进程之前为 ``None`` 。

进程池
---------

``Pool`` 类表示一个工作进程池，它具有允许以几种不同方式将任务分配到工作进程的方法。

::

    class multiprocessing.pool.Pool([processes[, initializer[, initargs[, maxtasksperchild[, context]]]]])

- ``processes`` 是要使用的工作进程数目。如果 ``processes`` 为 ``None`` ，则使用 ``os.cpu_count()`` 返回的值。
- ``context`` 是用于指定启动工作进程的上下文。通常一个进程池是使用函数 ``multiprocessing.Pool()`` 或者一个上下文对象的 ``Pool()`` 方法创建的。

方法：

- ``apply(func[, args[, kwds]])`` ：对应的子进程是排队执行的，实际非并行（阻塞的，即上一个子进程完成了才能进行下一个子进程；注意是单个子进程执行的，而不是按批执行的）。
- ``apply_async(func[, args[, kwds[, callback[, error_callback]]]])`` ：对应的每个子进程是异步执行的；异步执行指的是一批子进程并行执行，且子进程完成一个，就新开始一个，而不必等待同一批其他进程完成。如果指定了 ``callback`` , 它必须是一个接受单个参数的可调用对象。当执行成功时， ``callback`` 会被用于处理执行后的返回结果，否则，调用 ``error_callback`` 。如果指定了 ``error_callback`` , 它必须是一个接受单个参数的可调用对象。当目标函数执行失败时，会将抛出的异常对象作为参数传递给 ``error_callback`` 执行。
- ``map(func, iterable[, chunksize])`` ：内置 ``map()`` 函数的并行版本（但它只支持一个 ``iterable`` 参数，对于多个可迭代对象请参阅 ``starmap()`` ）。 它会保持阻塞直到获得结果。这个方法会将可迭代对象分割为许多块，然后提交给进程池。可以将 ``chunksize`` 设置为一个正整数从而（近似）指定每个块的大小。注意对于很长的迭代对象，可能消耗很多内存。可以考虑使用 ``imap()`` 或 ``imap_unordered()`` 并且显示指定 ``chunksize`` 以提升效率。
- ``map_async(func, iterable[, chunksize[, callback[, error_callback]]])`` ：``map()`` 的异步（并行）版本，返回 MapResult 实例（其具有 ``get()`` 方法，获取结果组成的 list）。
- ``imap(func, iterable[, chunksize])`` ：``map()`` 的迭代器版本，返回迭代器实例。 ``imap()`` 速度远慢于 ``map()`` ，但是对内存需求非常小。
- ``starmap(func, iterable[, chunksize])`` ：子进程活动 ``func`` 允许包含多个参数，也即 ``iterable`` 的每个元素也是 ``iterable`` （其每个元素作为 ``func`` 的参数），返回结果组成 list。
- ``starmap_async(func, iterable[, chunksize[, callback[, error_callback]]])`` ：``starmap()`` 的异步（并行）版本，返回 MapResult 实例（其具有 ``get()`` 方法，获取结果组成的 list）。
- ``close()`` ：关闭进程池，关闭后不能往池中增加新的子进程，然后可以调用 ``join()`` 函数等待已有子进程执行完毕。
- ``terminate()`` ：不必等待未完成的任务，立即停止工作进程。当进程池对象被垃圾回收时，会立即调用 ``terminate()`` 。
- ``join()`` ：等待进程池中的子进程执行完毕，需在 ``close()`` 函数后调用。
- ``get([timeout])`` ：用于获取执行结果。
- ``wait([timeout])`` ：阻塞，直到返回结果或超时。


进程通信
-----------

数据共享：Manager
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

由 ``Manager()`` 返回的管理器对象控制一个服务进程，该进程保存 Python 对象并允许其他进程使用代理操作它们。支持类型： list 、 dict 、 Namespace 、 Lock 、 RLock 、 Semaphore 、 BoundedSemaphore 、 Condition 、 Event 、 Barrier 、 Queue 、 Value 和 Array 。

注意：在操作共享对象的元素（子对象）时，除了赋值操作，其他的方法都作用在共享对象的拷贝上，并不会对共享对象生效。

数据传递：Queue
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

共享队列::

    class multiprocessing.Queue([maxsize])

允许多个进程放入、多个进程从队列取出对象。

方法：

- ``qsize()`` ：返回队列的大致长度。由于多线程或者多进程的上下文，这个数字是不可靠的。
- ``empty()`` ：如果队列是空的，返回 True。 由于多线程或多进程的环境，该状态是不可靠的。
- ``full()`` ：如果队列是满的，返回 True ，反之返回 False 。 由于多线程或多进程的环境，该状态是不可靠的。
- ``put(obj[, block[, timeout]])`` ：将 ``obj`` 放入队列。如果可选参数 ``block`` 是 True（默认值）而且 ``timeout`` 是 None（默认值）, 将会阻塞当前进程，直到有空的缓冲槽。如果 ``timeout`` 是正数，将会在阻塞了最多 ``timeout`` 秒之后还是没有可用的缓冲槽时抛出 ``queue.Full``  异常。反之（ ``block`` 是 False 时），仅当有可用缓冲槽时才放入对象，否则抛出 ``queue.Full`` 异常（在这种情形下 ``timeout`` 参数会被忽略）。
- ``get([block[, timeout]])`` ：从队列中取出并返回对象。

数据传递：Pipe
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    multiprocessing.Pipe([duplex])

返回一对 Connection 对象  ``(conn1, conn2)`` ， 分别表示管道的两端。

如果 ``duplex`` 被置为 True（默认值），那么该管道是双向的。如果 ``duplex`` 被置为 False ，那么该管道是单向的，即 ``conn1`` 只能用于接收消息，而 ``conn2`` 仅能用于发送消息。

Connection 对象的方法：

- ``send(obj)`` ：发送数据。只能发送可 pickle 的数据
- ``recv()`` ：读取管道中接收到的数据。
- ``close()`` ：关闭连接对象。当连接对象被垃圾回收时会自动调用。
- ``poll([timeout])`` ：判断管道对象是否有收到数据待读取。


示例
--------

创建进程
^^^^^^^^

.. code-block:: python
    :linenos:

    from multiprocessing import Process
    import os

    def info(title):
        print(title)
        print('module name:', __name__)
        print('parent process:', os.getppid())
        print('process id:', os.getpid())

    def f(name):
        info('function f')
        print('hello', name)

    if __name__ == '__main__':
        info('main line')
        p = Process(target=f, args=('bob',))
        p.start()
        p.join()

    ## if __name__ == '__main__' 是必需的


锁
^^^^^^^^^

使用 Lock 同步，在一个任务输出完成之后，再允许另一个任务输出，可以避免多个任务同时向终端输出。

.. code-block:: python
    :linenos:

    from multiprocessing import Process, Lock

    def f(l, i):
        l.acquire()
        try:
            print('hello world', i)
        finally:
            l.release()

    if __name__ == '__main__':
        lock = Lock()

        for num in range(10):
            Process(target=f, args=(lock, num)).start()

Pool
^^^^^^

.. code-block:: python
    :linenos:

    def f(a): ## map方法只允许1个参数
        return a

    if __name__ == "__main__":
        pool = multiprocessing.Pool()
        result = [pool.apply_async(f, (a,)) for a in [10,20]]
        pool.close()
        pool.join()

        for item in result:
            print(item.get())

.. code-block:: python
    :linenos:

    def f(a): ## map方法只允许1个参数
        return a

    if __name__ == "__main__":
        pool = multiprocessing.Pool() 
        result = pool.map_async(f, (a0, a1,)).get()
        pool.close()
        pool.join()

        for item in result:
            print(item)


.. code-block:: python
    :linenos:

    def f(a, b): ## starmap方法允许多个参数
        return a

    if __name__ == "__main__":
        pool = multiprocessing.Pool() 
        result = pool.starmap_async(f, ((a0, b0), (a1, b1), )).get()
        pool.close()
        pool.join()


Manager
^^^^^^^^^^

.. code-block:: python
    :linenos:

    from multiprocessing import Process, Manager
    import os
    
    def f(d, l):
        d[1] = 'Python'
        d[2] = "Java"
        d[3] = str(os.getpid())
        l.append(os.getpid()) # 获得当前的进程号
        print(l)
    
    
    if __name__ == '__main__':
        with Manager() as manager:
            d = manager.dict()
            l = manager.list()
            p_list = []
            for i in range(3):
                p = Process(target=f, args=(d, l))
                p.start()
                p_list.append(p)
            for res in p_list:
                res.join()
            print(d)

输出::

    [14168]
    [14168, 14108]
    [14168, 14108, 5412]
    {1: 'Python', 2: 'Java', 3: '5412'}


Pipe
^^^^^^^^^^

.. code-block:: python
    :linenos:

    import time, random
    from multiprocessing import Process, Pipe, current_process
    from multiprocessing.connection import wait

    '''
    wait(object_list) ：
    可以一次轮询多个连接对象，一直等待直到 object_list 中某个对象处于就绪状态。
    返回 object_list 中处于就绪状态的对象。
    当一个连接或者套接字对象拥有有效的数据可被读取的时候，或者另一端关闭后，这个对象就处于就绪状态。
    '''

    def foo(w):
        for i in range(5):
            w.send((i, current_process().name))
        w.close()

    if __name__ == '__main__':
        readers = []

        for i in range(2):
            r, w = Pipe(duplex=False)
            readers.append(r)
            p = Process(target=foo, args=(w,))
            p.start()
            w.close()

        while readers:
            for r in wait(readers):
                try:
                    msg = r.recv()
                except EOFError:
                    readers.remove(r)
                else:
                    print(msg)

输出::

    (0, 'Process-1')
    (1, 'Process-1')
    (2, 'Process-1')
    (3, 'Process-1')
    (4, 'Process-1')
    (0, 'Process-2')
    (1, 'Process-2')
    (2, 'Process-2')
    (3, 'Process-2')
    (4, 'Process-2')


参考资料
----------

1. multiprocessing — Process-based parallelism

  https://docs.python.org/3/library/multiprocessing.html

  https://docs.python.org/zh-cn/3/library/multiprocessing.html

2. python并行计算（上）：multiprocessing、multiprocess模块

  https://zhuanlan.zhihu.com/p/46798399