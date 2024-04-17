倒计时
==========

.. raw:: html

    <html lang="en">
    <head>
    <meta charset="UTF-8">
    <title>countdown</title>
    <script>
        function getDistance(endTime) {
        endTime = new Date(endTime).getTime();
        var now = new Date().getTime();
        var distance = endTime - now;
        var sign = distance > 0? "还有":"已过";
        distance = Math.abs(distance);
        var days = Math.floor(distance / (1000 * 60 * 60 * 24));
        var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);
        return [sign, days, hours, minutes, seconds, distance]
        }
        function format(n, key, flag) {
            document.getElementById(key).innerHTML = n.toString().padStart(2, "0");
            if (flag) {
                document.getElementById(key).style.color = "#6d0404";
            } else {
                document.getElementById(key).style.color = "#2980b9";
            }
        }
        function countdown() {
        var endTime = document.getElementById("endTime").value;
        // var arr = ["**", "--", "--", "--", "--", 0]
        if (endTime.length == 0) {
            var now = new Date();
            var nextYear = (now.getFullYear() + 1) + "-01-01 00:00:00";
            endTime = new Date(nextYear);
            document.getElementById("endTime").placeholder = nextYear;
        }
        arr = getDistance(endTime);
        if (arr[1] == 0) {
            arr[1] = "--";
            if (arr[2] == 0) {
                arr[2] = "--";
                if (arr[3] == 0) {
                    arr[3] = "--";
                }
            }
        }
        var flag = arr[5] <= 3600000;
        document.getElementById("sign").innerHTML = arr[0];
        format(arr[1], "days", flag);
        format(arr[2], "hours", flag);
        format(arr[3], "minutes", flag);
        format(arr[4], "seconds", flag);
        }
        setInterval(countdown, 1000);
        function setInput(e) {
        var interval;
        var endTime = e.target.value;
        var countDownDate = new Date(endTime).getTime();
        countdown();
        }
    </script>
    <style>
        .textcss{
            text-align:center;
            font-size:30px; 
            color:rgb(4, 62, 80);
        }
    </style>
    </head>
    <body>
        <br><br>
        <p class="textcss">距离</p>
        <p style="text-align:center;">
            <input type="text" style="border:1px solid rgba(0, 0, 0, 0.1);text-align:center;background:transparent;color:#830303;margin:0 auto;width:380px;font-size:30px;border-radius:10px;" oninput="setInput(event)" id="endTime" placeholder="YYYY-MM-DD HH:MM:SS">
        </p>
        <p class="textcss"><span id="sign"></span></p>
        <p class="textcss">
            <span id="days"></span> 天 
            <span id="hours"></span> 小时
            <span id="minutes"></span> 分钟 
            <span id="seconds"></span> 秒 
        </p>
        <br><br><br><br><br>
    </body>
    </html>