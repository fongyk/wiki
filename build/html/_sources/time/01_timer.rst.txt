计时器
===========

.. raw:: html

    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>timer</title>
        <script>
            var start = (new Date()).getTime();
            var timeStr = "00:00:00:00";
            var clock = 0;//计时器
            function resetTimer()
            {
                clearInterval(clock);
                start = (new Date()).getTime();
                timeStr = "00:00:00:00";
                document.getElementById('timeValue').value = timeStr;
            }
            function startTimer()
            {
                start = (new Date()).getTime();
                timeStr = "00:00:00:00";
                clearInterval(clock);
                clock = setInterval(timer, 123);
            }
            function stopTimer() {
                clearInterval(clock);
                document.getElementById('timeValue').value = timeStr;
            }
            //计时函数
            function timer(){
                var now = (new Date()).getTime();
                var diff = (now - start);
                hr = parseInt(diff / 3600000).toString().padStart(2, '0');
                min = parseInt(diff / 60000 % 60).toString().padStart(2, '0');
                sec = parseInt(diff / 1000 % 60).toString().padStart(2, '0');
                msec = parseInt(diff / 10 % 100).toString().padStart(2, '0');
                timeStr = hr + ":" + min + ":" + sec + ":" + msec;
                document.getElementById('timeValue').value = timeStr;
            }

        </script>
        <style>
            .buttoncss {
                width:100px;
                height:50px;
                font-style: normal;
                font-weight: bold;
                font-size:20pt; color: #042230;
                border: 1px #003399 solid;
                color:#006699;
                border:none;
                border-radius:20px;
                cursor: hand;
                margin-left: 20px;
                margin-right: 20px;
            }
            .buttoncss:hover {
                box-shadow: 0px 0px 3px 3px #6d0404;
            }
            .textcss {
                width: 200px;
                height: 30px;
                text-align:center;
                background:transparent;
                border:none;
                color:#2980b9;
                font-size:100px;
                font-family:consolas,monospace
            }
        </style>
    </head>
    <body>
        <div style="text-align:center">
            <br><br><br><br>
            <input type="text" id="timeValue" style="width:450px;height:70px;text-align:center;background-color:#edf0f2;border:none;border-radius:10px;color:#2980b9;font-size:60px;font-family:consolas,monospace" value="00:00:00:00" readonly><br>
            <br><br><br><br><br>
            <button type="button" class="buttoncss" style="background-color:#89cfb3;" onclick="startTimer()">开始</button>
            <button type="button" class="buttoncss" style="background-color:#e69d9d;" onclick="stopTimer()">停止</button>
            <button type="button" class="buttoncss" style="background-color:#b8b0b0;" onclick="resetTimer()">重置</button>
            <br><br><br><br><br>
        </div>
    </body>
    </html>