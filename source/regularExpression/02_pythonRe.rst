Python 正则
=======================

::

    import re

Python 的 **re** 模块提供了与 Perl 语言类似的正则表达式匹配操作。

模式（Pattern）和被搜索的字符串既可以是 Unicode 字符串（ ``str`` ），也可以是 8 位字节串（ ``bytes`` ），但是两者不能混用。

模式通常都使用原始字符串表示法：在带有 ``r`` 前缀的字符串字面值中，反斜杠不必做任何特殊处理。


正则标志
--------------

- ``re.I`` ：忽略大小写。

- ``re.M`` ：多行模式， ``^`` 匹配字符串的开始，以及每一行的开始（换行符后面紧跟的符号）； ``$`` 匹配字符串尾，以及每一行的结尾（换行符前面那个符号）。

- ``re.S`` ： ``.`` 匹配任何字符，包括换行符。

- ``re.X`` ：为了增加可读性，忽略空格和 ``#`` 后面的注释。下面两个正则表达式等价::

    a = re.compile(r"""\d +  # the integral part
                   \.    # the decimal point
                   \d *  # some fractional digits""", re.X)
    b = re.compile(r"\d+\.\d*")


re.compile
---------------

::

    re.compile(pattern, flags=0)

将正则表达式的样式编译为一个正则表达式对象（正则对象）。 flag 是正则标志。

正则表达式对象 Pattern 支持以下方法和属性：

.. py:function:: Pattern.search(string[, pos[, endpos]])
    
    扫描整个 string 寻找第一个匹配的位置，并返回一个相应的匹配对象；如果没有匹配，就返回 ``None`` 。

.. py:function:: Pattern.match(string[, pos[, endpos]])
    
    如果 string 的开始位置能够找到这个正则样式的任意个匹配，就返回一个相应的匹配对象；如果不匹配，就返回 ``None`` 。

.. py:function:: Pattern.fullmatch(string[, pos[, endpos]])
    
    如果整个 string 匹配这个正则表达式，就返回一个相应的匹配对象，否则就返回 ``None`` 。

.. py:function:: Pattern.split(string, maxsplit=0)
    
    等价于 ``re.split`` 。

.. py:function:: Pattern.findall(string[, pos[, endpos]])
    
    类似于 ``re.findall`` ，也可以接收可选参数 pos 和 endpos ，限制搜索范围。

.. py:function:: Pattern.sub(repl, string, count=0)
    
    等价于 ``re.sub`` 。

.. py:function:: Pattern.groups
    
    捕获到的模式串中组的数量。

re.search
-----------------

::

    re.search(pattern, string, flags=0)

扫描整个字符串找到匹配样式的 **第一个位置** ，并返回一个相应的匹配对象；如果没有匹配，就返回一个 ``None`` 。


re.match
-----------------

::

    re.match(pattern, string, flags=0)

如果 string 开始的 0 或者多个字符匹配到了正则表达式样式，就返回一个相应的匹配对象；如果没有匹配，就返回 ``None`` 。

.. code-block:: python
    :linenos:

    >>> re.match("c", "abcdef") # No match
    >>> re.search("c", "abcdef") # match
    <re.Match object; span=(2, 3), match='c'>
    >>> re.search("^c", "abcdef") # No match
    >>> re.search("^a", "abcdef") # match
    <re.Match object; span=(0, 1), match='a'>


匹配对象
---------------

匹配对象 Match 常用成员方法如下：

.. py:function:: Match.groups(default=None)
    
    - 返回一个元组，包含所有匹配的子组。

.. py:function:: Match.groupdict(default=None)

    - 返回匹配子组的字典形式，需要配合 ``?P<first_name>`` 使用。

    .. code-block:: python 
        :linenos:

        >>> m = re.match(r"(?P<first_name>\w+) (?P<last_name>\w+)", "Malcolm Reynolds")
        >>> m.groupdict()
        {'first_name': 'Malcolm', 'last_name': 'Reynolds'}
        >>> m.group('first_name')
        'Malcolm'

.. py:function:: Match.group([group1, ...])

    - 返回一个或者多个匹配的子组。如果只有一个参数，结果就是一个字符串；如果有多个参数，结果就是一个元组（每个参数对应一个项）；如果没有参数，或者参数是 0，返回所有的匹配。

    .. code-block:: python 
        :linenos:

        >>> m = re.match(r"(\w+) (\w+)", "Isaac Newton, physicist")
        >>> m.group(0)       # The entire match
        'Isaac Newton'
        >>> m.group(1)       # The first parenthesized subgroup.
        'Isaac'
        >>> m.group(2)       # The second parenthesized subgroup.
        'Newton'
        >>> m.group(1, 2)    # Multiple arguments give us a tuple.
        ('Isaac', 'Newton')

.. py:function:: Match.start([group])

    - 返回 group 匹配到的字串的开始位置。group 默认为 0（意思是整个匹配的子串）。
    
.. py:function:: Match.end([group])

    - 返回 group 匹配到的字串的结束位置（前闭后开）。group 默认为 0（意思是整个匹配的子串）。

.. py:function:: Match.span([group])

    - 对于一个匹配 m ， 返回一个二元组 ``(m.start(group), m.end(group))`` 。 注意如果 group 没有在这个匹配中，就返回 ``(-1, -1)`` 。group 默认为0，就是整个匹配。


re.findall
---------------

::

    re.findall(pattern, string, flags=0)

返回 pattern 在 string 中的所有非重叠（Non-overlapping ）匹配，以字符串列表或字符串元组列表的形式。对 string 的扫描从左至右，匹配结果按照找到的顺序返回。 空匹配也包括在结果中。

返回结果取决于模式中捕获组的数量。如果没有组，返回与整个模式匹配的字符串列表。如果有且仅有一个组，返回与该组匹配的字符串列表。如果有多个组，返回与这些组匹配的字符串元组列表。
非捕获组不影响结果。

.. code-block:: python 
    :linenos:

    >>> re.findall(r'\bf[a-z]*', 'which foot or hand fell fastest')
    ['foot', 'fell', 'fastest']
    >>> re.findall(r'(\w+)=(\d+)', 'set width=20 and height=10')
    [('width', '20'), ('height', '10')]

迭代器版本： ``re.finditer(pattern, string, flags=0)`` 。

re.split
-------------

::

    re.split(pattern, string, maxsplit=0, flags=0)

用 pattern 分开 string 。 如果在 pattern 中捕获到括号，那么所有的组里的字符也会包含在列表里。
如果 maxsplit 非零， 最多进行 maxsplit 次分隔， 剩下的字符全部返回到列表的最后一个元素。
如果没有匹配，不会进行分割。

.. code-block:: python
    :linenos:

    >>> re.split(r'\W+', 'Words, words, hello.') ## 注意：是大写的 W
    ['Words', 'words', 'hello', '']
    >>> re.split(r'(\W+)', 'Words, words, hello.')
    ['Words', ', ', 'words', ', ', 'hello', '.', '']


re.sub
----------------

::

    re.sub(pattern, repl, string, count=0, flags=0)

返回通过使用 repl 替换在 string 最左边非重叠出现的 pattern 而获得的字符串。
如果 pattern 没有找到，则直接返回 string。 

repl 可以是字符串或函数，这个函数只能有一个匹配对象参数，并返回一个替换后的字符串。

可选参数 count 是要替换的最大次数，必须是非负整数。如果省略这个参数或设为 0，所有的匹配都会被替换。 ::

    >>> re.sub(r'\D', '', '1234-5678-9999')
    '123456789999'


参考资料
------------------

1. Python 正则表达式

  https://www.runoob.com/python/python-reg-expressions.html

2. re 正则表达式操作
  
  https://docs.python.org/3/library/re.html#regular-expression-objects