json
============

JSON（JavaScript Object Notation）是一种轻量级的数据交换格式。

语法规则：

- 字符串必须用双引号 ``""`` 。

- key 只能是字符串。

- value 可以是字符串、浮点数、布尔值（ ``true`` ``false`` ）或者 ``null`` ，或者它们构成的数组或者对象。

- 花括号保存 key:value 对象。

- 方括号保存数组。

- 元素之间用逗号分隔。

Python 的 `json <https://docs.python.org/3/library/json.html>`_ 模块提供了与标准库 `marshal <https://docs.python.org/3/library/marshal.html#module-marshal>`_ 和 `pickle <https://docs.python.org/3/library/pickle.html#module-pickle>`_ 相似的API接口。

基本用法
--------------

::

    import json

.. py:function:: json.dump(obj, fp, *, skipkeys=False, ensure_ascii=True, check_circular=True, allow_nan=True, cls=None, indent=None, separators=None, default=None, sort_keys=False, **kw)

   将 ``obj`` 序列化为 JSON 格式化流形式的 ``fp`` (支持 ``.write()`` 的 file-like object)。json 模块始终产生 ``str`` 对象而非 ``bytes`` 对象。因此，``fp.write()`` 必须支持 ``str`` 输入。

   :param bool skipkeys: 默认为 False ，如果为 True ，那么那些不是基本对象（包括 ``str`` ``int`` ``float`` ``bool`` ``None`` ）的字典的键会被跳过，否则引发 ``TypeError`` 异常。
   :param bool ensure_ascii: 默认为 True ，输出保证将所有输入的非 ASCII 字符转义，否则这些字符会原样输出。
   :param bool allow_nan: 默认为 True ，如果为 False ，那么在对越界的 ``float`` 类型值（ ``nan`` ``inf`` ``-inf`` ）进行序列化时会引发 ``ValueError`` 异常。默认情况下使用它们的 JavaScript 等价形式（ ``NaN`` ``Infinity`` ``-Infinity`` ）。
   :param indent: 默认为 ``None`` ，选择最紧凑的表达。如果 ``indent`` 是一个非负整数或者字符串，那么 JSON 数组元素和对象成员会被美化输出为该值指定的缩进等级。如果缩进等级为零、负数或者 ``""``，则只会添加换行符；如果是一个正整数，会让每一层缩进同样数量的空格。。
   :param separators: 是一个 (item_separator, key_separator) 元组。当 ``indent = None`` 时，默认值取 ``(', ', ': ')``，否则取 ``(',', ': ')``。为了得到最紧凑的 JSON 表达式，应该指定其为 ``(',', ':')`` 以消除空白字符。
   :param bool sort_keys: 默认为 False ，如果为 True ，那么字典的输出会以键的顺序排序。


.. py:function:: json.dumps(obj, *, skipkeys=False, ensure_ascii=True, check_circular=True, allow_nan=True, cls=None, indent=None, separators=None, default=None, sort_keys=False, **kw)

    将 ``obj`` 序列化为 JSON 格式的 ``str`` 。其他参数的含义与 ``json.dump`` 相同。

.. py:function:: json.load(fp, *, cls=None, object_hook=None, parse_float=None, parse_int=None, parse_constant=None, object_pairs_hook=None, **kw)

    将 ``fp`` (一个支持 ``.read()`` 并包含一个 JSON 文档的 text file 或者 binary file) 反序列化为一个 Python 对象。

    :param parse_float: 从字符串解析浮点数的方法，默认情况下相当于 ``float(num_str)`` 。
    :param parse_int: 从字符串解析整数的方法，默认情况下相当于 ``int(num_str)`` 。
    :param parse_constant: 解析 ``'-Infinity'`` ``'Infinity'`` ``'NaN'`` 的方法。

.. py:function:: json.loads(s, *, cls=None, object_hook=None, parse_float=None, parse_int=None, parse_constant=None, object_pairs_hook=None, **kw)

    将 ``s`` (一个包含 JSON 文档的 ``str`` ， ``bytes`` 或 ``bytearray`` 实例) 反序列化为 Python 对象。其他参数的含义与 ``json.load`` 中的相同。

::

    >>> json.loads('[{"a": 123}, {"abc": [1,2,"3"]}, 45.67, [100, "hex"]]')
    [{'a': 123}, {'abc': [1, 2, '3']}, 45.67, [100, 'hex']]

.. note::

    JSON 中的键-值对中的键永远是 ``str`` 类型的。当一个对象被转化为 JSON 时，字典中所有的键都会被强制转换为字符串。这造成的结果是：字典被转换为 JSON 然后转换回字典时可能和原来的不相等。换句话说，如果 ``x`` 具有非字符串的键，则 ``loads(dumps(x)) != x`` 。


美化输出
^^^^^^^^^^^^

:: 

    >>> json.dumps([1, 2, 3, {4: 5, 6: 7}], separators=(',', ':'))
    '[1,2,3,{"4":5,"6":7}]'
    >>> json.dumps({'4': 5, '6': 7}, sort_keys=True, indent=4)
    '{\n    "4": 5,\n    "6": 7\n}'
    >>> print(json.dumps({'4': 5, '6': 7}, sort_keys=True, indent=4))
    {
        "4": 5,
        "6": 7
    }

命令行使用 json.tool 来验证并美化输出::

    $ echo '{"json":"obj"}' | python -m json.tool
    {
        "json": "obj"
    }
    $ echo '{1.2:3.4}' | python -m json.tool
    Expecting property name enclosed in double quotes: line 1 column 2 (char 1)
    $ echo '{"1.2":3.4}' | python -m json.tool
    {
        "1.2": 3.4
    }

编码器和解码器
--------------

.. py:class:: json.JSONEncoder(*, skipkeys=False, ensure_ascii=True, check_circular=True, allow_nan=True, sort_keys=False, indent=None, separators=None, default=None)

    用于 Python 数据结构的可扩展 JSON 编码器，将 Python 数据类型转成 JSON 数据类型。

    :param default: 是一个函数，每当某个对象无法被序列化时它会被调用。它应该返回该对象的一个可以被 JSON 编码的版本或者引发 ``TypeError`` 异常。默认情况下会直接引发 ``TypeError`` 异常。

    .. py:method:: encode(o)

        返回 Python ``o`` 数据类型的 JSON 字符串表达方式。

        ::

            >>> json.JSONEncoder().encode({"foo": ["bar", "baz"]})
            '{"foo": ["bar", "baz"]}'

.. py:class:: json.JSONDecoder(*, object_hook=None, parse_float=None, parse_int=None, parse_constant=None, strict=True, object_pairs_hook=None)

    简单的 JSON 解码器，将 JSON 数据类型转成 Python 数据类型。

    :param bool strict: 默认为 True，如果为 False，那么控制字符（ASCII 码范围 0 - 31）将被允许包含在字符串内，比如 ``\t`` ``\r`` ``\n`` 。

    .. py:method:: decode(s)

        返回 ``s`` （包含一个 JSON 文档的 ``str`` 实例）的 Python 表示形式。

        ::

            >>> json.JSONDecoder(strict=False).decode('{"foo": ["bar", "baz\t"]}')
            {'foo': ['bar', 'baz\t']}

    .. py:method:: raw_decode(s)

        从 ``s`` （以 JSON 文档 **开头** 的一个 ``str`` 对象，该字符串的末尾可能有无关的数据）中解码出 JSON 文档并返回一个 Python 表示形式：一个二元组，包含了解析出来的 Python 对象以及该 JSON 文档在 ``s`` 中的结束位置。

        ::

            >>> json.JSONDecoder().raw_decode('{"foo": ["bar", "baz"]} hello world')
            ({'foo': ['bar', 'baz']}, 23)


转换表
------------

Python 到 JSON 转换表
^^^^^^^^^^^^^^^^^^^^^^^^^

``dump`` 、 ``dumps`` 、 ``JSONEncoder`` 转换表。

=========================================== =======================
Python                                       JSON
=========================================== =======================
dict                                          object
list, tuple                                   array
str                                            string
int, float, int 和 float 派生的枚举              number
True                                           true
False                                          false
None                                           null
=========================================== =======================


JSON 到 Python 转换表
^^^^^^^^^^^^^^^^^^^^^^^^^

``load`` 、 ``loads`` 、 ``JSONDecoder`` 转换表。

=========================================== =======================
JSON                                          Python
=========================================== =======================
object                                          dict
array                                          list
string                                          str
number (int)                                   int
number (real)                                   float
true                                           True
false                                          False
null                                           None
=========================================== =======================


参考资料
--------------

1. json — JSON encoder and decoder

  https://docs.python.org/3/library/json.html

  https://docs.python.org/zh-cn/3/library/json.html