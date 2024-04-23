计时器
===========

.. raw:: html

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>timer</title>
        <script>
            var start = (new Date()).getTime();
            var defaultStr = "00:00:00:00";
            var timeStr = defaultStr;
            var alive = false;
            var records = ["记录"];
            var clock = 0;//计时器
            function resetTimer()
            {
                alive = false;
                clearInterval(clock);
                start = (new Date()).getTime();
                timeStr = defaultStr;
                document.getElementById('timeValue').value = timeStr;
            }
            function startTimer()
            {
                alive = true;
                start = (new Date()).getTime();
                timeStr = defaultStr;
                clearInterval(clock);
                clock = setInterval(timer, 10);
            }
            function stopTimer() {
                if (!alive) return;
                alive = false;
                clearInterval(clock);
                records.push(timeStr);
                document.getElementById('timeValue').value = timeStr;
                document.getElementById('records').innerHTML = records.join("<br><br>");
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
                width: 6rem;
                height: 3rem;
                font-style: normal;
                /* font-weight: bold; */
                font-size: 1.5rem; 
                color: #042230;
                border: 1px #003399 solid;
                color: #006699;
                border: none;
                border-radius: 1rem;
                cursor: hand;
                margin-left: 1.1rem;
                margin-right: 1.1rem;
            }
            .buttoncss:hover {
                box-shadow: 0px 0px 3px 3px #6d0404;
            }
            .textcss {
                text-align: center;
                color: #3d0606;
                font-size: 1.8rem;
                font-family: Consolas, monospace
            }
        </style>
    </head>
    <body>
        <div style="text-align:center">
            <br><br><br>
            <input type="text" id="timeValue" style="width:25rem;height:6rem;text-align:center;background-color:#edf0f2;border:none;border-radius:0.9rem;color:#2980b9;font-size:3.5rem;font-family:consolas,monospace" value="00:00:00:00" readonly><br>
            <br><br><br><br>
            <button type="button" class="buttoncss" style="background-color:#89cfb3;" onclick="startTimer()">开始</button>
            <button type="button" class="buttoncss" style="background-color:#e69d9d;" onclick="stopTimer()">停止</button>
            <button type="button" class="buttoncss" style="background-color:#b8b0b0;" onclick="resetTimer()">重置</button>
            <br><br><br><br>
            <p class="textcss" id="records"></p>
            <br><br><br>
        </div>
    </body>
    </html>