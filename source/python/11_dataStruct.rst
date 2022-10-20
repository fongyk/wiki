常用数据结构
==================

栈
-----

**list** 的 ``append()`` 和 ``pop()`` 方法使得 list 类型可以作为简单的栈使用。


队列
--------

.. note::
    
    Python 2 的队列模块为 ``Queue`` ，Python 3 的队列模块为 ``queue`` 。

Queue
^^^^^^^

::

  import queue

queue 模块实现了多生产者、多消费者队列，适用于消息必须安全地在多线程间交换的线程编程。

类
""""""""

.. py:class:: queue.Queue(maxsize=0)
    
    先进先出。

    maxsize 指明了队列中能存放的数据个数的上限。
    一旦达到上限，插入会导致阻塞，直到队列中的数据被消费掉。
    如果 maxsize 小于或者等于 0，队列大小没有限制。

.. py:class:: queue.LifoQueue(maxsize=0)

    后进先出，类似于栈。

.. py:class:: queue.PriorityQueue(maxsize=0)

    优先队列。

    一般使用 tuple（优先级 + 数据）作为队列元素，优先级为 tuple 的第一项。
    默认 tuple 第一项越小，优先级越高，越先出队列。

异常
""""""""

.. py:exception:: queue.Empty

  对空的 ``queue.Queue`` 对象，调用非阻塞的 ``get()`` 或 ``get_nowait()`` 时引发的异常。

.. py:exception:: queue.Full 

  对满的 ``queue.Queue`` 对象，调用非阻塞的 ``put()`` 或 ``put_nowait()`` 时引发的异常。

方法
""""""""

队列对象（ ``Queue`` ``LifoQueue`` ``PriorityQueue`` ）具有以下公共方法。

.. py:method:: qsize()

  返回队列的（ **大致** ）大小。多进程/线程情景下， ``qsize() > 0`` 不保证后续的 ``get()`` 不被阻塞， ``qsize() < maxsize`` 也不保证 ``put()`` 不被阻塞。

.. py:method:: empty()

  如果队列为空，返回 True ，否则返回 False 。多进程/线程情景下，如果 ``empty()`` 返回 True ，不保证后续调用的 ``put()`` 不被阻塞；如果 ``empty()`` 返回 False ，也不保证后续调用的 ``get()`` 不被阻塞。

.. py:method:: put(item, block=True, timeout=None)

  将 item 放入队列。如果 ``block=True`` 且 ``timeout=None`` ，则在必要时阻塞至有空闲插槽可用；如果 timeout 是个正数，将最多阻塞 timeout 秒，如果在这段时间没有可用的空闲插槽，将引发 ``queue.Full`` 异常。如果 ``block=False`` ，若有空闲插槽立即可用，则把 item 放入队列，否则引发 ``queue.Full`` 异常（在这种情况下，timeout 将被忽略）。

.. py:method:: put_nowait(item)

  相当于 ``put(item, block=False)`` 。


.. py:method:: get(block=True, timeout=None)

  从队列中 **移除并返回** 一个 item。如果 ``block=True`` 且 ``timeout=None`` ，则在必要时阻塞至 item 可获取；如果 timeout 是个正数，将最多阻塞 timeout 秒，如果在这段时间内 item 仍不能获取，将引发 ``queue.Empty`` 异常。如果 ``block=False`` ，若一个 item 可立即获取，则返回一个 item，否则引发 ``queue.Empty`` 异常（这种情况下，timeout 将被忽略）。


.. py:method:: get_nowait()

  相当于 ``get(block=False)`` 。


.. py:method:: task_done()

  在消费者进程/线程中使用，每个 ``get()`` 被用于获取一个任务，后续调用 ``task_done()`` 用来告诉队列：该任务的处理已经完成。

  如果被调用的次数多于放入队列中的 item 数量，将引发 ``ValueError`` 异常。

.. py:method:: join()

  阻塞至队列中所有的 item 都被接收和处理完毕。每调用一次 ``task_done()`` ，未完成计数就会减少 1，当未完成计数降到零的时候，阻塞被解除。


.. code-block:: python
  :linenos:

  from queue import PriorityQueue
  que = PriorityQueue()
  que.put((1,'apple'))
  que.put((10,'app'))
  que.put((5,'banana'))

  while not que.empty():
      print(que.get(), que.qsize())

::

    (1, 'apple') 2
    (5, 'banana') 1
    (10, 'app') 0

.. code-block:: python
  :linenos:

  import threading
  import queue

  q = queue.Queue()

  def worker():
      while True:
          item = q.get()
          print(f'Working on {item}')
          print(f'Finished {item}')
          q.task_done()

  # Turn-on the worker thread.
  threading.Thread(target=worker, daemon=True).start()

  # Send thirty task requests to the worker.
  for item in range(5):
      q.put(item)

  # Block until all tasks are done.
  q.join()
  print('All work completed')

::

    Working on 0
    Finished 0
    Working on 1
    Finished 1
    Working on 2
    Finished 2
    Working on 3
    BFinished 3
    loWorking on 4
    Finished 4
    ck until all tasks are done.
    All work completed

.. tip::

  多进程/线程情景下，既然 ``qsize()`` 和 ``empty()`` 不可信，那么判断循环结束条件应该注意，应使用异常来判断。

  .. code-block:: python
    :linenos:

    while True:
        try:
            ## ...
            q.get(block=False)
            ## ...
        except queue.Empty:
            break
 
  .. code-block:: python
    :linenos:

    while True:
        try:
            ## ...
            q.put(item, block=False)
            ## ...
        except queue.Full:
            break


deque
^^^^^^^^

double-ended queue，双端队列。

::

  from collections import deque

方法：
  - append(), appendleft()
  - pop(), popleft()
  - extend(), extendleft()
  - reverse()
  - rotate()
  - count()
  - clear()

.. code-block:: python
  :linenos:

  >>> dq = deque(range(5))
  >>> dq
  deque([0, 1, 2, 3, 4])
  >>> dq.rotate() ## right-shift
  >>> dq
  deque([4, 0, 1, 2, 3])
  >>> dq.rotate(3)
  >>> dq
  deque([1, 2, 3, 4, 0])
  >>> dq.rotate(-3) ## left-shift
  deque([4, 0, 1, 2, 3])
  >>> dq.reverse()
  >>> dq
  deque([3, 2, 1, 0, 4])


堆
--------

::

  import heapq

heapq 创建的是 **小顶堆** ，堆顶元素是堆的最小元素。

创建堆
^^^^^^^^^

- **heappush()**

  基于空列表[]，使用 ``heappush()`` 把元素逐个插入堆中。 ``heappop(h)`` 弹出并返回堆顶元素。h[0] 是最小值。

  如果插入元素是元组（tuple），则元组的第一项自动成为优先级，值越小，优先级越高。堆顶元素优先级最高，值最小。

  .. code-block:: python
    :linenos:

    >>> def heapsort(iterable):
    ...     h = []
    ...     for value in iterable:
    ...         heapq.heappush(h, value)
    ...     return [heapq.heappop(h) for _ in range(len(h))]  ## 不能直接返回 h
    ...
    >>> heapsort([1, 3, 5, 7, 9, 2, 4, 6, 8, 0])
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

- **heapify(list_x)**

  把列表转换为堆，in-place，线性时间。

  .. code-block:: python
    :linenos:

    >>> h = [2, 3, 5, 1, 54, 23, 132]
    >>> heapq.heapify(h)
    >>> print h
    [1, 2, 5, 3, 54, 23, 132] ## h 是堆，但是h不一定是有序的，只能保证 h[0] 是最小值。
    >>> print [heapq.heappop(h) for _ in range(len(h))]
    [1, 2, 3, 5, 23, 54, 132]

- **merge**

  合并多个排序后的序列，返回排序后的序列的迭代器。

  .. code-block:: python
    :linenos:

    >>> h1 = [32, 3, 5, 34, 54, 23, 132]
    >>> h2 = [23, 2, 12, 656, 324, 23, 54]
    >>> h1 = sorted(h1)
    >>> h2 = sorted(h2)
    >>> h = heapq.merge(h1, h2)
    >>> print type(h), list(h)
    <type 'generator'> [2, 3, 5, 12, 23, 23, 23, 32, 34, 54, 54, 132, 324, 656]

- **heapreplace**

  删除堆中最小元素，并插入新的元素。

  .. code-block:: python
    :linenos:

    >>> h = [32, 3, 5, 34, 54, 23, 132]
    >>> heapq.heapify(h)
    >>> heapq.heapreplace(h, 9)
    >>> print [heapq.heappop(h) for _ in range(len(h))]
    [5, 9, 23, 32, 34, 54, 132]

获取最值
^^^^^^^^^^^^^

::

  heapq.nlargest(n, iterable[, key])
  heapq.nsmallest(n, iterable[, key])

返回一个长度为 :math:`n` 的列表，包含数据中的前 :math:`n` 个最大/最小的元素。使用 key 定义排序关键字。

.. code-block:: python
  :linenos:

  >>> nums = [1, 3, 4, 5, 2]
  >>> print heapq.nlargest(3, nums)
  [5, 4, 3]
  >>> print heapq.nsmallest(3, nums)
  [1, 2, 3]

  >>> info = [
  ...     {'name': 'IBM', 'price': 91.1},
  ...     {'name': 'AAPL', 'price': 543.22},
  ...     {'name': 'FB', 'price': 21.09},
  ...     {'name': 'HPQ', 'price': 31.75},
  ...     {'name': 'YHOO', 'price': 16.35},
  ...     {'name': 'ACME', 'price': 115.65}
  ... ]
  >>> cheap = heapq.nsmallest(2, info, key=lambda x:x['price'])
  >>> expensive = heapq.nlargest(2, info, key=lambda x:x['price'])
  >>> print cheap
  [{'price': 16.35, 'name': 'YHOO'}, {'price': 21.09, 'name': 'FB'}]
  >>> print expensive
  [{'price': 543.22, 'name': 'AAPL'}, {'price': 115.65, 'name': 'ACME'}]


大顶堆
^^^^^^^^^^

heapq 默认创建小顶堆，为了创建大顶堆，有以下 trick::

  heapq.heappush(-x) ## 插入 x
  x = - heapq.heappop(h) ## 弹出堆顶元素


数列前 K 大的数
^^^^^^^^^^^^^^^^^^^^^

Hint：建立大小为 :math:`K` 的小顶堆，对后续所有数进行遍历：如果大于堆顶元素，则有可能是前 :math:`K` 大的数，堆顶元素弹出，插入该数。
时间复杂度 :math:`\mathcal{O}(NlogK)`。

.. code-block:: python
  :linenos:

  import heapq as hq

  class TopKHeap(object):
    def __init__(self, k=3):
      self.k = k
      self.data = []

    def push(self, x):
      if len(self.data) < self.k:
        hq.heappush(self.data, x)
      else:
        min_number = self.data[0]
        if x > min_number:
          hq.heapreplace(self.data, x)

    def topk(self):
      return list(reversed([hq.heappop(self.data) for _ in range(len(self.data))]))

  def main():
    nums = range(1, 10)
    tkh = TopKHeap(3)
    for n in nums:
      tkh.push(n)
    print tkh.topk() ## [9, 8, 7]

  if __name__ == '__main__':
    main()


计数器
----------

::

  from collections import Counter

Counter 用于统计频率。属性与字典类似，有 ``keys()`` ，``values()`` ，``items()`` 等。

.. note::

  Counter 统计之后并不一定是按照频率从高到低排列的。

.. code-block:: python
  :linenos:

  >>> cnt = Counter() ## 空计数器
  >>> for word in ['red', 'blue', 'red', 'green', 'blue', 'blue']:
  ...     cnt[word] += 1
  >>> cnt
  Counter({'blue': 3, 'red': 2, 'green': 1})
  >>> cnt = Counter(['red', 'blue', 'red', 'green', 'blue', 'blue'])
  >>> cnt
  Counter({'blue': 3, 'red': 2, 'green': 1})

  >>> cnt.most_common(2) ## 返回出现频率最高的两个元素
  [('blue', 3), ('red', 2)]

  >>> c = Counter('gallahad')
  >>> c
  Counter({'a': 3, 'l': 2, 'h': 1, 'g': 1, 'd': 1})

  >>> c = Counter({'red': 4, 'blue': 12})
  >>> c
  Counter({'blue': 12, 'red': 4})
  >>> c['green'] ## 访问不存在关键字, 可使用 c.get('green')
  0


参考资料
-------------

1. queue — A synchronized queue class

  https://docs.python.org/3/library/queue.html

  https://docs.python.org/zh-cn/3/library/queue.html

  https://docs.python.org/2/library/queue.html?highlight=priority%20queue#Queue.PriorityQueue

2. python中的Queue(队列)详解

  https://www.cnblogs.com/wdliu/p/6905396.html

3. Python collections使用

  https://www.jianshu.com/p/f2a429aa5963

4. Python标准库模块之heapq

  https://www.jianshu.com/p/801318c77ab5

  https://docs.python.org/2/library/heapq.html

5. python使用heapq实现小顶堆（TopK大）/大顶堆（BtmK小）

  https://blog.csdn.net/tanghaiyu777/article/details/55271004

6. Counter

  https://docs.python.org/2/library/collections.html?highlight=counter
