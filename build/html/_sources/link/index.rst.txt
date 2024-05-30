快速访问
=============

访客信息
------------

.. raw:: html


    <html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Info</title>
        <style>
          .info {
            margin: 0 10%;
            overflow-wrap: break-word;
          }
          .key {
            font-family: Menlo, 'Droid Sans Mono', Consolas, monospace;
            font-size: 20px;
            color: grey;
            white-space: pre-wrap;
          }
          .value {
            font-family: Menlo, 'Droid Sans Mono', Consolas, monospace;
            font-size: 20px;
            color: #2980b9;
            white-space: pre-wrap;
          }
        </style>
    </head>
    <body>
        <div class="info">
            <p><span class="key">        IP: </span><span id="userIp" class="value"></span></p>
            <p><span class="key">      City: </span><span id="userCity" class="value"></span></p>
            <p><span class="key">    Region: </span><span id="userRegion" class="value"></span></p>
            <p><span class="key">   Country: </span><span id="userCountry" class="value"></span></p>
            <p><span class="key">  Location: </span><span id="userLocation" class="value"></span></p>
            <p><span class="key">  TimeZone: </span><span id="userTimezone" class="value"></span></p>
            <p><span class="key">  Platform: </span><span id="userPlatform" class="value"></span></p>
            <p><span class="key">    Screen: </span><span id="userScreen" class="value"></span></p>
            <p><span class="key">       App: </span><span id="app" class="value"></span></p>
            <p><span class="key"> UserAgent: </span><span id="userAgent" class="value"></span></p>
        </div>
        
        <script>
            // Get User IP
            fetch('https://api.ipify.org/?format=json')
            .then(response => response.json())
            .then(data => {
                document.getElementById('userIp').innerText = data.ip;
                // Get User Location
                fetch(`https://ipapi.co/${data.ip}/json/`)
                .then(response => response.json())
                .then(locationData => {
                    document.getElementById('userCity').innerText = locationData.city;
                    document.getElementById('userRegion').innerText = locationData.region;
                    document.getElementById('userCountry').innerText = locationData.country_name;
                    document.getElementById('userLocation').innerText = locationData.latitude + "°" + ", " + locationData.longitude + "°";
                    document.getElementById('userTimezone').innerText = locationData.timezone;
                })
                .catch(error => console.error('Error fetching location data:', error));
            })
            .catch(error => console.error('Error fetching IP address:', error));
            try {
                document.getElementById('userPlatform').innerText = navigator.userAgentData.platform;
            } catch (e) {
                document.getElementById('userPlatform').innerText = detectOS();
            }
            document.getElementById('userScreen').innerText = window.screen.width + " x " + window.screen.height + " x " + window.screen.colorDepth;
            document.getElementById('userAgent').innerText = navigator.userAgent;
            document.getElementById('app').innerText = navigator.appName + ", " + navigator.appCodeName + ", " + navigator.vendor;

            function detectOS() {
                var t = navigator.userAgent;
                var e = "Win32" === navigator.platform || "Windows" === navigator.platform;
                var n = "Mac68K" === navigator.platform || "MacPPC" === navigator.platform || "Macintosh" === navigator.platform || "MacIntel" === navigator.platform;
                if (n)
                    return "Mac";
                if ("X11" === navigator.platform && !e && !n)
                    return "Unix";
                if (String(navigator.platform).indexOf("Linux") > -1)
                    return "Linux";
                if (e) {
                    if (t.indexOf("Windows NT 5.0") > -1 || t.indexOf("Windows 2000") > -1)
                        return "Win2000";
                    if (t.indexOf("Windows NT 5.1") > -1 || t.indexOf("Windows XP") > -1)
                        return "WinXP";
                    if (t.indexOf("Windows NT 5.2") > -1 || t.indexOf("Windows 2003") > -1)
                        return "Win2003";
                    if (t.indexOf("Windows NT 6.0") > -1 || t.indexOf("Windows Vista") > -1)
                        return "WinVista";
                    if (t.indexOf("Windows NT 6.1") > -1 || t.indexOf("Windows 7") > -1)
                        return "Win7";
                    if (t.indexOf("Windows NT 8") > -1 || t.indexOf("Windows 8") > -1)
                        return "Win8";
                    if (t.indexOf("Windows NT 10") > -1 || t.indexOf("Windows 10") > -1)
                        return "Win10"
                }
                return navigator.userAgent;
            }
        </script>
    </body>
    </html>

USTC
-------------

.. hlist::
    :columns: 3

    - .. figure:: pictures/ustc-home.jpeg
         :target: https://ustc.edu.cn
         :width: 160px
         :height: 120px
         :align: center
         
         ustc

    - .. figure:: pictures/ustc-mail.jpeg
         :target: https://mail.ustc.edu.cn
         :width: 160px
         :height: 120px
         :align: center
         
         mail

    - .. figure:: pictures/ustc-lug.jpeg
         :target: https://lug.ustc.edu.cn
         :width: 160px
         :height: 120px
         :align: center
         
         lug

Diff
---------------

.. figure:: pictures/diff.png
    :target: https://fongyq.github.io/diff/
    :width: 160px
    :height: 120px
    :align: center

    diff

PyRun
---------------

.. figure:: pictures/pyrun.png
    :target: https://fongyq.github.io/pyrun
    :width: 160px
    :height: 120px
    :align: center

    pyrun


JsonViewer
---------------

.. figure:: pictures/json_viewer.png
    :target: https://fongyq.github.io/json
    :width: 160px
    :height: 120px
    :align: center

    json viewer

AnyKnew
---------------

.. figure:: pictures/anyknew.jpeg
    :target: https://www.anyknew.com/#/
    :width: 160px
    :height: 120px
    :align: center

    anyknew



ShareLatex/Overleaf
--------------------------

.. figure:: pictures/overleaf.jpeg
    :target: https://www.overleaf.com/login
    :width: 160px
    :height: 120px
    :align: center
    
    overleaf

在线 LaTex 公式编辑器
---------------------------

.. figure:: pictures/latex.jpeg
    :target: https://www.latexlive.com/
    :width: 160px
    :height: 120px
    :align: center
    
    latex




C++ Shell
--------------

.. hlist::
    :columns: 2

    - .. figure:: pictures/cpp-shell.jpeg
         :target: http://cpp.sh/
         :width: 160px
         :height: 120px
         :align: center
         
         c++ shell

    - .. figure:: pictures/coliru.jpeg
         :target: http://coliru.stacked-crooked.com/
         :width: 160px
         :height: 120px
         :align: center
         
         coliru


HTTPIE 在线 API 测试
--------------------------

.. figure:: pictures/httpie.jpeg
    :target: https://httpie.io/app
    :width: 160px
    :height: 120px
    :align: center
    
    httpie



Json.cn
------------

.. figure:: pictures/json.jpeg
    :target: https://www.json.cn/
    :width: 160px
    :height: 120px
    :align: center
    
    json.cn


在线正则表达式
---------------------------

.. hlist::
    :columns: 2

    - .. figure:: pictures/cn-re.jpeg
         :target: https://c.runoob.com/front-end/854/
         :width: 160px
         :height: 120px
         :align: center
         
         runoob

    - .. figure:: pictures/oschina-re.jpeg
         :target: https://tool.oschina.net/regex
         :width: 160px
         :height: 120px
         :align: center
         
         oschina


Catonmat 在线工具
---------------------------

.. figure:: pictures/catonmat.jpeg
    :target: https://catonmat.net/projects
    :width: 160px
    :height: 120px
    :align: center
    
    catonmat


Diagram
-----------

.. hlist::
    :columns: 2

    - .. figure:: pictures/diagrams.jpeg
         :target: https://app.diagrams.net/
         :width: 160px
         :height: 120px
         :align: center
         
         diagrams

    - .. figure:: pictures/drawio.jpeg
         :target: https://github.com/jgraph/drawio-desktop
         :width: 160px
         :height: 120px
         :align: center
         
         drawio

图形计算器
----------------
.. hlist::
    :columns: 2


    - .. figure:: pictures/geogebra.png
         :target: https://www.geogebra.org/graphing
         :width: 160px
         :height: 120px
         :align: center
         
         geogebra

         
    - .. figure:: pictures/desmos.png
         :target: https://www.desmos.com/calculator?lang=zh-CN
         :width: 160px
         :height: 120px
         :align: center
         
         desmos


重构与设计模式
------------------------

.. figure:: pictures/design-pattern.jpeg
    :target: https://refactoringguru.cn/
    :width: 160px
    :height: 120px
    :align: center
    
    refactoringguru

Docker
------------

.. hlist::
    :columns: 2

    - .. figure:: pictures/docker-docs.jpeg
         :target: https://docs.docker.com/engine/reference/run/
         :width: 160px
         :height: 120px
         :align: center
         
         docker docs

    - .. figure:: pictures/docker-hub.jpeg
         :target: https://hub.docker.com/search?q=&image_filter=official
         :width: 160px
         :height: 120px
         :align: center
         
         docker hub

Curl
---------

.. hlist::
    :columns: 3

    - .. figure:: pictures/curl.jpeg
         :target: https://curl.se/
         :width: 160px
         :height: 120px
         :align: center
         
         curl

    - .. figure:: pictures/curl-man.jpeg
         :target: https://curl.se/docs/manpage.html
         :width: 160px
         :height: 120px
         :align: center
         
         curl manpage

    - .. figure:: pictures/everything-curl.jpeg
         :target: https://everything.curl.dev/
         :width: 160px
         :height: 120px
         :align: center
         
         everything curl

Graphviz
-------------

.. figure:: pictures/graphviz.jpeg
    :target: http://graphviz.org/
    :width: 160px
    :height: 120px
    :align: center
    
    graphviz

Jupyter
-----------------

.. figure:: pictures/jupyter.jpeg
    :target: https://jupyter.org/
    :width: 160px
    :height: 120px
    :align: center
    
    jupyter


arXiv
-----------

.. figure:: pictures/arxiv.jpeg
    :target: https://arxiv.org/
    :width: 160px
    :height: 120px
    :align: center

    arxiv



C++ Reference
---------------

.. hlist::
    :columns: 2

    - .. figure:: pictures/cplusplus.jpeg
         :target: http://www.cplusplus.com/reference/
         :width: 160px
         :height: 120px
         :align: center
         
         cplusplus

    - .. figure:: pictures/cppreference.jpeg
         :target: https://en.cppreference.com/w/
         :width: 160px
         :height: 120px
         :align: center
         
         cppreference

Numpy
-----------

.. figure:: pictures/numpy.jpeg
    :target: https://numpy.org/doc/stable/reference/index.html
    :width: 160px
    :height: 120px
    :align: center

    reference

Pytorch
------------

.. hlist::
    :columns: 2

    - .. figure:: pictures/pytorch-tutorial.jpeg
         :target: https://pytorch.org/tutorials/
         :width: 160px
         :height: 120px
         :align: center
         
         Tutorials

    - .. figure:: pictures/pytorch-doc.jpeg
         :target: https://pytorch.org/docs/master/index.html
         :width: 160px
         :height: 120px
         :align: center
         
         Docs

Hugging Face
---------------

.. figure:: pictures/huggingface.png
    :target: https://huggingface.co/
    :width: 160px
    :height: 120px
    :align: center

    hugging face


ANN Search
---------------------------

.. hlist::
    :columns: 2

    - .. figure:: pictures/faiss.jpeg
         :target: https://github.com/facebookresearch/faiss
         :width: 160px
         :height: 120px
         :align: center
         
         faiss

    - .. figure:: pictures/annoy.jpeg
         :target: https://github.com/spotify/annoy
         :width: 160px
         :height: 120px
         :align: center
         
         annoy


Standford University Lectures
-------------------------------

.. hlist::
    :columns: 2

    - .. figure:: pictures/cs229.jpeg
         :target: http://cs229.stanford.edu/
         :width: 160px
         :height: 120px
         :align: center
         
         cs229

    - .. figure:: pictures/cs231.jpeg
         :target: http://cs231n.github.io/
         :width: 160px
         :height: 120px
         :align: center
         
         cs231


Read the Docs
---------------

.. figure:: pictures/read-the-docs.jpeg
    :target: https://readthedocs.org/
    :width: 160px
    :height: 120px
    :align: center

    read the docs


小林 Coding
---------------

.. figure:: pictures/xiaolin.jpeg
    :target: https://xiaolincoding.com
    :width: 160px
    :height: 120px
    :align: center

    xiaolincoding


阮一峰的网络日志
--------------------

.. figure:: pictures/ryf.jpeg
    :target: https://www.ruanyifeng.com/blog/weekly
    :width: 160px
    :height: 120px
    :align: center

    weekly



Github Page
-------------

.. figure:: pictures/fongyq-github-io.jpeg
    :target: https://fongyq.github.io/
    :width: 160px
    :height: 120px
    :align: center

    fongyq.github.io