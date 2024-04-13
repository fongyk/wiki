现在时刻
==========

.. raw:: html

    <html>
    <head>
        <title>Chinese Lunar Date Example</title>
        <script src="https://cdn.jsdelivr.net/npm/chinese-lunar"></script>
    </head>
    <body>

    <p id="current-week" style="text-align: center; font-size:30px; color:#2980b9;"></p>

    <p id="current-time" style="text-align: center; font-size:30px; color:#2980b9;"></p>

    <p id="current-ts" style="text-align: center; font-size:30px; color:grey;"></p>
    
    <br>

    <p id="lunar-year" style="text-align: center; font-size:30px; color:#2980b9;"></p>

    <p id="lunar-date" style="text-align: center; font-size:30px; color:#2980b9;"></p>


    <script>
        function displayTime() {
            var currentTime = new Date();
            var timestamp = currentTime.getTime() / 1000;
            var year = currentTime.getFullYear();
            var month = currentTime.getMonth() + 1;
            var day = currentTime.getDate();
            var hours = currentTime.getHours();
            var minutes = currentTime.getMinutes();
            var seconds = currentTime.getSeconds();
            var days = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'];
            var dayOfWeek = days[currentTime.getDay()];

            month = (month < 10 ? "0" : "") + month;
            day = (day < 10 ? "0" : "") + day;
            hours = (hours < 10 ? "0" : "") + hours;
            minutes = (minutes < 10 ? "0" : "") + minutes;
            seconds = (seconds < 10 ? "0" : "") + seconds;

            var timeString = year + "-" + month + "-" + day;
            timeString = timeString + " " + hours + ":" + minutes + ":" + seconds;
            document.getElementById("current-time").innerHTML = timeString;
            document.getElementById("current-week").innerHTML = dayOfWeek;
            document.getElementById("current-ts").innerHTML = timestamp.toString().padEnd(14, '0');
            
            var tiangan = ['甲', '乙', '丙', '丁', '戊', '己', '庚', '辛', '壬', '癸'];
            var dizhi = ['子', '丑', '寅', '卯', '辰', '巳', '午', '未', '申', '酉', '戌', '亥'];
            var shengxiao = ['鼠', '牛', '虎', '兔', '龙', '蛇', '马', '羊', '猴', '鸡', '狗', '猪'];

            var idx1 = (year - 4) % 10;
            var idx2 = (year - 4) % 12;
            document.getElementById("lunar-year").innerHTML = tiangan[idx1] + dizhi[idx2] + shengxiao[idx2] + "年";

            utcDateM1 = new Date(Date.UTC(currentTime.getFullYear(), currentTime.getMonth(), currentTime.getDate() - 1));
            var lunarDate = chineseLunar.solarToLunar(utcDateM1);
            document.getElementById("lunar-date").innerHTML = chineseLunar.format(lunarDate, 'YMD');;
        }
        // flush every second
        setInterval(displayTime, 123);
    </script>

    </body>
    </html>
