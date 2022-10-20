curl
================

curl（Client URL）是常用的命令行工具，用来请求 Web 服务器以传输数据。

.. note::

    Postman 可以用来生成和测试 curl 请求。

-X
-------------

指定 HTTP 请求的方法。

::

    curl -X POST https://www.example.com

上面命令对 ``https://www.example.com`` 发出 POST 请求。


-H
-------------

即 ``--header`` ，添加 HTTP 请求的标头。

添加两个 HTTP 标头::

    curl -H 'Accept-Language: en-US' -H 'Secret-Message: xyzzy' https://www.google.com

添加标头 ``Content-Type: application/json`` ，然后用 ``-d`` 参数发送 JSON 数据::

    curl -H 'Content-Type: application/json' -d '{"login": "emma", "pass": "123"}' https://www.google.com/login

-A
-------------

指定客户端的用户代理标头（header），即 ``User-Agent`` 。curl 的默认用户代理字符串是 ``curl/[version]`` 。

::

    curl -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36' https://www.google.com

上面命令将 ``User-Agent`` 改成 Chrome 浏览器。

可以通过 ``-H`` 参数直接指定标头，更改 ``User-Agent``::

    curl -H 'User-Agent: php/1.0' https://www.google.com

.. note::

    User-Agent 包含了浏览器类型及版本、操作系统及版本、浏览器内核等。

    User-Agent 是可以伪装的。Chrome 浏览器的 User-Agent 还包含了 Mozilla/5.0、(KHTML, like Gecko)、Safari 等，是为了兼容性。

-b
----------

向服务器发送 Cookie ::

    curl -b 'foo=bar' https://www.google.com

上面命令会生成一个标头Cookie: foo=bar，向服务器发送一个名为foo、值为bar的 Cookie。

发送两个 Cookie::

    curl -b 'foo1=bar;foo2=bar2' https://www.google.com

读取本地 Cookie 文件::

    curl -b cookies.txt https://www.google.com


-c
--------

将服务器设置的 Cookie 写入一个文件::

    curl -c cookies.txt https://www.google.com


-d
---------

发送 POST 请求的数据体。

::

    curl -d 'login=emma＆password=123' -X POST https://www.example.com/login
    # 或者
    curl -d 'login=emma' -d 'password=123' -X POST  https://www.example.com/login

使用 ``-d`` 参数以后，HTTP 请求会自动加上标头 ``Content-Type : application/x-www-form-urlencoded`` ，并且会自动将请求转为 POST 方法，因此可以省略 ``-X POST`` 。

可以读取本地文本文件的数据，向服务器发送::

    curl -d '@data.txt' https://www.example.com/login

--data-urlencode
-------------------------

功能与 ``-d`` 相同，用于发送 POST 请求的数据体，区别在于： ``-d`` 需要使用 URL 编码之后的数据，而 ``--data-urlencode`` 会自动将发送的数据进行 URL 编码。

::

    curl -d 'name=johnny%20depp' https://www.example.com/login
    curl --data-urlencode 'name=john depp' https://www.example.com/login

上面命令中有一个空格，需要进行 URL 编码。

.. note::

    不指定请求方法默认为 GET，或者通过不同方法专用的命令选项自动确定所用的请求方法。

-e
-------

设置标头 ``Referer`` ，表示请求的来源。

::

    curl -e 'https://google.com?q=example' https://www.example.com


上面命令将 ``Referer`` 标头设为 ``https://google.com?q=example`` ，将对 ``https://www.example.com`` 的请求伪装成来自谷歌搜索 example。


``-H`` 参数可以通过直接添加标头 ``Referer`` ，达到同样效果::

    curl -H 'Referer: https://google.com?q=example' https://www.example.com

-F
-------

向服务器上传二进制文件。

::

    curl -F 'file=@photo.png' https://www.google.com/profile

上面命令会给 HTTP 请求加上标头 ``Content-Type: multipart/form-data`` ，然后将文件 ``photo.png`` 作为 ``file`` 字段上传。

-G
----------

构造 URL 的查询字符串。

::

    curl -G -d 'q=kitties' -d 'count=20' https://www.google.com/search

上面命令会发出一个 GET 请求，实际请求的 URL 为 ``https://google.com/search?q=kitties&count=20`` 。如果省略 ``-G`` ，会发出一个 POST 请求。

如果数据需要 URL 编码，使用 ``--data-urlencode`` 参数::

    curl -G --data-urlencode 'wd=百度' -d 'pn=0' https://www.baidu.com/s

.. note::

    上述请求可能会被服务端拒绝，需要添加更多 header 信息。

-i
------------

发送 GET 请求，打印出服务器响应的 HTTP 标头。

::

    curl -i https://www.google.com

收到服务器响应后，先输出服务器响应的标头，然后空一行，再输出网页的源码。

``-I`` 发送的是 HEAD 请求，等同于 ``--head`` 。


-k
-------

跳过 SSL 检测，不验证 SSL 证书。

::

    curl -k https://www.example.com


-L
-------

即 ``--location`` ，跟随服务器的重定向，curl 默认不跟随重定向。

::

    curl -L http://catonmat.net

这条命令请求 ``http://catonmat.net`` ，但是网站已经迁到 https，最终请求会重定向到 ``https://catonmat.net`` 。


-o
----------

将服务器的响应保存成文件，等同于 ``wget`` 命令。

::

    curl -o google.html https://www.google.com

``-O`` 参数会自动将请求 URL 的最后部分当做文件名保存下来::

    curl -O https://www.example.com/foo/bar.html

或者使用 ``>`` ``>>`` 重定向到文件。

-s
---------

即 ``--silent`` ，不输出错误和进度条。

不产生任何输出::

    curl -s -o /dev/null https://www.google.com

只输出错误::

    curl -S -s -o /dev/null https://www.google.com


-u
----------

设置服务器认证的用户名和密码。

::

    curl -u 'bob:12345' https://example.com/login

上面命令设置用户名为 ``bob`` ，密码为 ``12345`` ，添加标头 ``Authorization: Basic Ym9iOjEyMzQ1`` 。

curl 能够识别 URL 里面的用户名和密码::

    curl https://bob:12345@example.com/login


-v
------

输出通信的整个过程，用于调试。比如会输出使用的代理。

使用 ``--trace -`` 还会输出原始二进制数据。

::

    curl -v www.baidu.com
    curl --trace - www.baidu.com

-x
------

指定请求所用的代理。

::

    curl -x socks5h://127.0.0.1:1080 www.google.com
    curl -x http://127.0.0.1:1080 www.google.com


参考资料
----------

1. curl 的用法指南

  https://www.ruanyifeng.com/blog/2019/09/curl-reference.html

2. Curl Cookbook

  https://catonmat.net/cookbooks/curl

3. curl man page

  https://curl.se/docs/manpage.html