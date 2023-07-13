字符
=======================

正则表达式（Regular Expression）是一种文本模式，包括普通字符（如 a 到 z 之间的字母）和特殊字符（称为“元字符”）。

正则表达式使用单个字符串来描述用于匹配某个句法规则的字符串。许多程序设计语言都支持利用正则表达式进行字符串操作。


常用符号及描述
-----------------

========================================  ====================================================================  =============================================
 常用符号                                       描述                                                                  示例
========================================  ====================================================================  =============================================
\\                                          转义 
^                                           匹配输入字符串的开始位置
$                                           匹配输入字符串的结束位置
.                                           匹配除换行符（ ``\n`` ``\r`` ）之外的任何单个字符                                                                            
\*                                          匹配前面的子表达式 **零次** 或多次                                        ``zo*`` 能匹配 z 以及 zoo ；等价于 ``{0,}`` 。
\+                                          匹配前面的子表达式 **一次** 或多次
?                                           匹配前面的子表达式 **零次** 或 **一次**                                   ``do(es)?`` 可以匹配 do 或 does ；等价于 ``{0,1}`` 。
{n}                                         匹配 n 次                                                               ``o{2}`` 可以匹配 food ；要匹配 \{ 请使用 ``\{`` 。
{n,}                                        至少匹配 n 次
{n,m}                                       匹配 n 到 m 次
\*?, +?, ??, {n}?, {n,}?, {n,m}?            非贪婪匹配                                                             对于字符串 oooo， ``o+?`` 将匹配单个 o，而 ``o+`` 将匹配所有 o。
(pattern)                                   匹配 pattern 并获取这一匹配                                                                                     
(?:pattern)                                 非获取匹配                                                              ``industr(?:y|ies)`` 是一个比 ``industry|industries`` 更简略的表达式                                       
(?=pattern)                                 正向肯定预查（Look Ahead Positive Assertion），非获取匹配                       ``Windows(?=95|98|NT|2000)`` 能匹配 Windows2000 中的 Windows ，但不能匹配 Windows3.1 中的 Windows。预查不消耗字符。 
(?!pattern)                                 正向否定预查（Look Ahead Negative Assertion），非获取匹配                       ``Windows(?!95|98|NT|2000)`` 能匹配 Windows3.1 中的 Windows ，但不能匹配 Windows2000 中的 Window。                                                                     
(?<=pattern)                                反向肯定预查（Look Behind Positive Assertion），非获取匹配                      ``(?<=95|98|NT|2000)Windows`` 能匹配 2000Windows 中的 Windows ，但不能匹配 3.1Windows 中的 Windows。                                                      
(?<!pattern)                                反向否定预查（Look Behind Negative Assertion），非获取匹配                      ``(?<!95|98|NT|2000)Windows`` 能匹配 3.1Windows 中的 Windows ，但不能匹配 2000Windows 中的 Windows。
x|y                                          匹配 x 或 y                                                                      
[xyz]                                        字符集合，匹配所包含的任意一个字符                                                                     
[^xyz]                                       负值字符集合，匹配未包含的任意字符                                                                    
[a-z]                                        匹配任意小写字母                                                                      
[^a-z]                                       匹配非小写字母                                                                     
\\d                                          匹配一个数字字符，等价于 ``[0-9]``                                                                        
\\D                                          匹配一个非数字字符，等价于 ``[^0-9]``                                                                   
\\n                                          匹配一个换行符                                                                      
\\r                                          匹配一个回车符                                                                     
\\s                                          匹配任何空白字符，等价于 ``[ \f\n\r\t\v]``                                                                      
\\S                                          匹配任何非空白字符，等价于 ``[^ \f\n\r\t\v]``                                                                     
\\t                                          匹配一个制表符                                                                     
\\w                                          匹配字母、数字、下划线，等价于 ``[A-Za-z0-9_]``                                                                     
\\W                                          匹配非字母、数字、下划线，等价于 ``[^A-Za-z0-9_]``                                                                        
\\b                                          匹配 ``\w`` 类型和 ``\W`` 类型之间的分界                                ``er\b`` 能匹配 never 中的 er，但不能匹配 verb 中的 er。                                       
\\B                                          匹配 ``\w`` 类型和 ``\w`` 类型之间的分界                                ``er\B`` 能匹配 verb 中的 er，但不能匹配 never 中的 er。                                       
\\num                                        后向引用（Back Reference），对第 ``num`` 个获取式匹配的引用               ``([a-z])\1`` 能匹配连续的两个相同小写字母。                                       
========================================  ====================================================================  =============================================

匹配邮箱的例子::

    \b[\w.%+-]+@[\w.-]+\.[a-zA-Z]{2,6}\b

.. note::

    非贪婪匹配尽可能少的匹配所搜索的字符串，而默认的贪婪模式则尽可能多的匹配所搜索的字符串。

    ``(pattern)`` 获取式匹配可以从产生的 Matches 集合（Groups）得到，要匹配圆括号字符，请使用 ``\(`` 或 ``\)`` 。

.. note::

    ``^`` ``$`` ``\b`` ``\B`` 等属于 Anchor 类字符，用于限定匹配位置，不占用实际字符宽度。

    比如 ``abc---123`` 可以理解为 ``^abc---123$`` 或  ``\ba\Bb\Bc\b---\b1\B2\B3\b`` 。

.. tip::

    放在中括号 ``[]`` 里面的时候， ``.`` ``+`` ``*`` 等特殊字符可以不用转义。

.. tip::

    VS Code 在使用正则进行查找替换的时候，替换结果中使用 ``$num`` 来引用所获取的匹配组（ ``num`` 从 1 开始）, ``$0`` 表示完整的原始字符串。

    VS Code 可以使用 ``\u`` ``\U`` ``\l`` ``\L`` 四种字符来改变匹配组的大小写：

    - ``\u`` 将匹配组的第一个字符转换为大写
  
    - ``\l`` 将匹配组的第一个字符转换为小写

    - ``\U`` 将匹配组的所有字符转换为大写

    - ``\L`` 将匹配组的所有字符转换为小写

    - ``\u\u\u$1`` 将第一个匹配组的前三个字符转为大写

    - ``\l\U$1`` 将第一个匹配组的第一个字符转为小写，其余字符转为大写

参考资料
------------------

1. Regular expression

  https://en.wikipedia.org/wiki/Regular_expression

2. Regular Expression Language - Quick Reference

  https://learn.microsoft.com/en-us/dotnet/standard/base-types/regular-expression-language-quick-reference

3. 正则表达式
  
  https://www.runoob.com/regexp/regexp-metachar.html

  https://www.runoob.com/regexp/regexp-syntax.html

4. 正则表达式在线测试及常用正则表达式
  
  https://c.runoob.com/front-end/854/

5. 在 Visual Studio 中使用正则表达式

  https://learn.microsoft.com/zh-cn/visualstudio/ide/using-regular-expressions-in-visual-studio?view=vs-2022
  
6. VS Code now supports changing the case of regex matching groups while doing a find/replace

  https://code.visualstudio.com/updates/v1_47#_editor