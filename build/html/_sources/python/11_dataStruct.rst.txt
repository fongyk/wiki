常用数据结构
==================

栈
-----

**list** 的 ``append()`` 和 ``pop()`` 方法使得list类型可以作为简单的栈使用。


队列
--------

Queue
^^^^^^^

::

  import Queue

- FIFO

  ::

    Queue.Queue(maxsize=0)
    先进先出。
    maxsize指明了队列中能存放的数据个数的上限。
    一旦达到上限，插入会导致阻塞，直到队列中的数据被消费掉。
    如果maxsize小于或者等于0，队列大小没有限制。

- LIFO

  ::

    Queue.LifoQueue(maxsize=0)
    后进先出，类似于栈。

- Priority

  ::

    Queue.PriorityQueue(maxsize=0)
    优先队列。
    一般使用tuple（优先级+数据）作为队列元素，优先级为tuple的第一项。
    默认sorted(list(entries))[0])，即tuple第一项越小，优先级越高，越先出队列。

插入元素 ::

  ## que is an initialization of Queue
  que.put(item)

弹出并返回元素 ::

  item = que.get()

判断是否为空 ::

  que.empty()

队列大小 ::

  que.qsize()

例子：

.. code-block:: python
  :linenos:

  from Queue import PriorityQueue
  que = PriorityQueue()
  que.put((1,'apple'))
  que.put((10,'app'))
  que.put((5,'banana'))

  while not que.empty():
      print que.get(), que.qsize()

  ## print result
  ## (1, 'apple') 2
  ## (5, 'banana') 1
  ## (10, 'app') 0


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

例子：

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

heapq创建的是 **小顶堆** ，堆顶元素是堆的最小元素。

创建堆
^^^^^^^^^

- **heappush()**

  基于空列表[]，使用 ``heappush()`` 把元素逐个插入堆中。 ``heappop(h)`` 弹出并返回堆顶元素。h[0]是最小值。

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

返回一个长度为n的列表，包含数据中的前n个最大/最小的元素。使用key定义排序关键字。

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

heapq默认创建小顶堆，为了创建大顶堆，有以下trick::

  heapq.heappush(-x) ## 插入 x
  x = - heapq.heappop(h) ## 弹出堆顶元素


数列前K大的数
^^^^^^^^^^^^^^^^^^^^^

Hint：建立大小为K的小顶堆，对后续所有数进行遍历：如果大于堆顶元素，则有可能是前K大的数，堆顶元素弹出，插入该数。
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

Counter用于统计频率。属性与字典类似，有keys()，values()，items()等。

.. note::

  Counter统计之后并不一定是按照频率从高到低排列的。

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

1. python中的Queue(队列)详解

  https://www.cnblogs.com/wdliu/p/6905396.html

2. Python collections使用

  https://www.jianshu.com/p/f2a429aa5963

3. Python标准库模块之heapq

  https://www.jianshu.com/p/801318c77ab5

  https://docs.python.org/2/library/heapq.html

4. python使用heapq实现小顶堆（TopK大）/大顶堆（BtmK小）

  https://blog.csdn.net/tanghaiyu777/article/details/55271004

5. Counter

  https://docs.python.org/2/library/collections.html?highlight=counter
