logging
=============

logging 模块是 Python 内置的标准模块，主要用于输出运行日志。

日志等级（从高到低）：

- ``CRITICAL``

- ``ERROR``

- ``WARNING``

- ``INFO``

- ``DEBUG``

- ``NOTSET``

默认情况下只显示大于等于 ``WARNING`` 级别的日志。

若要对 logging 进行更多灵活的控制，必须了解 ``Logger`` ，``Handler`` ，``Formatter`` ，``Filter`` 等概念：

- ``Logger`` 提供了应用程序可以直接使用的接口；

- ``Handler`` 将 ``Logger`` 创建的日志记录发送到合适的目的输出（控制台、文件、网络等）；

- ``Filter`` 提供了细度设置来决定输出哪条日志记录；

- ``Formatter`` 决定日志记录的最终输出格式。


Logger
------------

::

    class logging.Logger

不要直接实例化 ``Logger`` ，应当通过模块级别的函数 ``logging.getLogger(name)`` 来得到对象。多次使用相同的 ``name`` 调用会一直返回相同的 ``Logger`` 对象的引用。
如果 ``name`` 不给定默认为 ``root`` 。

``name`` 是以点号分割的命名方式命名的（a.b.c）。这种命名方式里面，后面的 loggers 是前面 logger 的子 logger，自动继承父 logger 的 logging 设置。正因为此，没有必要把一个应用的所有 logger 都配置一遍，只要把顶层的 logger 配置好了，然后子 logger 根据需要继承就行了。

方法：

- ``setLevel(level)`` ：等级低于 ``level`` 的日志将不会输出。

- ``addHandler(hdlr)`` ，``removeHandler(hdlr)`` ：添加、删除 handler。

- ``addFilter(filter)`` ，``removeFilter(filter)`` ：添加、删除 filter。

- ``debug/info/warning/exception/error/critial(msg, *args, **kwargs)`` ：输出相应等级的信息。其中 ``exception`` 和 ``error`` 同级。


Handler
-----------

``Handler`` 通常也不直接实例化。以下是几个常用的 handler ：

- ``logging.StreamHandler(stream=None)``

    可以像类似于 ``sys.stdout`` 或者 ``sys.stderr`` 的任何文件对象（file object）输出信息。``stream`` 默认是 ``sys.stderr`` ，输出到控制台。

- ``logging.FileHandler(filename, mode='a', encoding=None, delay=False)``

    向一个文件输出日志信息。``mode='a'`` 表示追加到文件末尾，``'w'`` 表示写入。

- ``logging.handlers.RotatingFileHandler(filename, mode='a', maxBytes=0, backupCount=0, encoding=None, delay=False)``

    类似于上面的 ``FileHandler`` ，但是它可以管理文件大小。当文件达到一定大小之后，它会自动将当前日志文件改名，然后创建一个新的同名日志文件继续输出。

- ``logging.handlers.TimedRotatingFileHandler(filename, when='h', interval=1, backupCount=0, encoding=None, delay=False, utc=False, atTime=None)`` 

    间隔一定时间就自动创建新的日志文件。

Handler 方法：

- ``setLevel(level)`` ：该 handler 对等级低于 ``level`` 的日志无效。

- ``setFormatter(fmt)`` ：设置输出格式。


Formatter
------------

::

    class logging.Formatter(fmt=None, datefmt=None, style='%')

``Formatter`` 定义了最终 log 信息的内容格式，可以直接实例化 ``Foamatter`` 类。信息格式字符串用 ``%(<dictionary key>)s`` 风格的字符串做替换。

可能用到的格式化串：

- ``%(name)s`` logger 的名字
- ``%(levelno)s`` 数字形式的日志级别
- ``%(levelname)s`` 文本形式的日志级别
- ``%(pathname)s`` 调用日志输出函数的模块的完整路径名
- ``%(filename)s`` 调用日志输出函数的模块的文件名
- ``%(module)s`` 调用日志输出函数的模块名
- ``%(funcName)s`` 调用日志输出函数的函数名
- ``%(lineno)d`` 调用日志输出函数的语句所在的代码行
- ``%(created)f`` 当前时间，用 UNIX 标准的表示时间的浮点数表示
- ``%(relativeCreated)d`` 输出日志信息时的，自 logger 创建以来的毫秒数
- ``%(asctime)s`` 字符串形式的当前时间（默认格式是 "2003-07-08 16:49:45,896"，逗号后面的是毫秒）
- ``%(thread)d`` 线程 ID。
- ``%(threadName)s`` 线程名
- ``%(process)d`` 进程 ID
- ``%(message)s`` 用户输出的消息

示例
-----------

- logging 基本设置

.. code-block:: python
    :linenos:

    import logging
    logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    logger = logging.getLogger(__name__)
    
    logger.info("Start print log")
    logger.debug("Do something")
    logger.warning("Something maybe fail.")
    logger.info("Finish")

控制台输出::

    2020-03-01 14:35:57,550 - __main__ - INFO - Start print log
    2020-03-01 14:35:57,551 - __main__ - WARNING - Something maybe fail.
    2020-03-01 14:35:57,551 - __main__ - INFO - Finish

- 同时输出到控制台和文件

.. code-block:: python
    :linenos:

    import logging
    logger = logging.getLogger(__name__)
    logger.setLevel(level = logging.INFO)

    handler = logging.FileHandler("log.txt") ## file
    handler.setLevel(logging.INFO)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    handler.setFormatter(formatter)
    
    console = logging.StreamHandler() ## concole
    console.setLevel(logging.INFO)
    
    logger.addHandler(handler)
    logger.addHandler(console)
    
    logger.info("Start print log")
    logger.debug("Do something")
    logger.warning("Something maybe fail.")
    logger.info("Finish")

控制台输出::

    Start print log
    Something maybe fail.
    Finish

文件输出::

    2020-03-01 15:26:49,162 - __main__ - INFO - Start print log
    2020-03-01 15:26:49,163 - __main__ - WARNING - Something maybe fail.
    2020-03-01 15:26:49,163 - __main__ - INFO - Finish


配置文件
----------

可以从字典中加载 logging 配置，这也就意味着可以通过 JSON 或者 YAML 文件加载日志的配置。

以 YAML 为例，新建 log.yaml：

.. container:: toggle

  .. container:: header

    :math:`\color{darkgreen}{Show/Hide\ Code}`

  .. code-block:: yaml
    :linenos:

    version: 1
    disable_existing_loggers: False
    formatters:
            simple:
                format: "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
    handlers:
        console:
                class: logging.StreamHandler
                level: DEBUG
                formatter: simple
                stream: ext://sys.stdout
        info_file_handler:
                class: logging.handlers.RotatingFileHandler
                level: INFO
                formatter: simple
                filename: info.log
                maxBytes: 10485760
                backupCount: 20
                encoding: utf8
        error_file_handler:
                class: logging.handlers.RotatingFileHandler
                level: ERROR
                formatter: simple
                filename: errors.log
                maxBytes: 10485760
                backupCount: 20
                encoding: utf8
    loggers:
        my_module:
                level: ERROR
                handlers: [info_file_handler]
                propagate: no
    root:
        level: DEBUG
        handlers: [console, info_file_handler, error_file_handler]

|

导入：

.. code-block:: python
    :linenos:

    import yaml
    import logging
    ## logging 的 __init__ 文件里面没有 config
    import logging.config
    import os
    
    def setup_logging(default_path="log.yaml", default_level=logging.INFO, env_key="LOG_CFG"):
        path = default_path
        ## getenv 获取全局变量
        value = os.getenv(env_key, None)
        if value:
            path = value
        if os.path.exists(path):
            with open(path, "r") as f:
                cfg = yaml.load(f, Loader=yaml.FullLoader)
                logging.config.dictConfig(cfg)
        else:
            logging.basicConfig(level=default_level)
    
    def func():
        logging.debug("start func")
    
        logging.info("exec func")
    
        logging.error("error end")
    
    if __name__ == "__main__":
        setup_logging()
        func()

控制台输出::

    2020-03-01 14:54:21,566 - root - DEBUG - start func
    2020-03-01 14:54:21,566 - root - INFO - exec func
    2020-03-01 14:54:21,566 - root - ERROR - error end

文件输出::

    2020-03-01 14:54:21,566 - root - ERROR - error end

从名字可以看出，程序中的 ``logging`` 默认使用的是  ``root`` 对应的设置，这和使用 ::

    logger = logging.getLogger()

是等效的。如果想采用 ``my_module`` 对应的设置，则使用 ::

    logger = logging.getLogger("loggers.my_module")


附录：print 函数
---------------------

::

    print(*objects, sep=' ', end='\n', file=sys.stdout, flush=False)

- ``objects`` ：复数，表示可以一次输出多个对象。输出多个对象时，需要用 ``,`` 分隔。
- ``sep`` ：用来间隔多个对象，默认值是一个空格。
- ``end`` ：用来设定以什么结尾，默认值是换行符 ``\n`` 。
- ``file`` ：要写入的文件对象，默认为 ``sys.stdout`` 。 ``input()`` 对应 ``sys.stdin`` ， ``exception`` 写入 ``sys.stderr`` 。
- ``flush`` ：输出是否被缓存通常决定于 ``file`` ，但如果 ``flush`` 关键字参数为 True，流会被强制刷新，立即输出。

例子：

- 控制台 loading 效果

    设置 ``flush=True`` ，每隔0.5秒屏幕会打印一个点号。否则会在5秒之后输出10个点号。

    .. code-block:: python
        :linenos:

        import time

        print("Loading", end=" ")
        for i in range(10):
            print(".", end='', flush=True)
            time.sleep(0.5)

- 输出到文件

    .. code-block:: python
        :linenos:

        >>> fw = open('a.txt', 'w')
        >>> print('hello', file=fw, flush=True)
        ## 在关闭文件之前，此时打开文件已经可以看到输出了
        >>> fw.close()

参考资料
-------------

1. Python logger模块

  https://www.cnblogs.com/qianyuliang/p/7234217.html

2. python3 logging模块

  https://www.cnblogs.com/wenwei-blog/p/7196658.html

3. logging — Logging facility for Python

  https://docs.python.org/3/library/logging.html#handler-objects