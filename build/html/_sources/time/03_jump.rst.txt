日期跳转
==========

.. raw:: html

    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>TIME</title>
        <!-- <script src="https://cdn.jsdelivr.net/npm/chinese-lunar"></script> -->
        <script>
            function setJumpTime(e) {
                var jumpTime = e.target.value;
                displayTime();
            }
            function parseTime(targetTime) {
                var timestamp = Math.floor(targetTime.getTime() / 1000);
                var year = targetTime.getFullYear();
                var month = targetTime.getMonth() + 1;
                var day = targetTime.getDate();
                var hours = targetTime.getHours();
                var minutes = targetTime.getMinutes();
                var seconds = targetTime.getSeconds();
                var days = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'];
                var dayOfWeek = days[targetTime.getDay()];

                month = (month < 10 ? "0" : "") + month;
                day = (day < 10 ? "0" : "") + day;
                hours = (hours < 10 ? "0" : "") + hours;
                minutes = (minutes < 10 ? "0" : "") + minutes;
                seconds = (seconds < 10 ? "0" : "") + seconds;

                var timeString = year + "-" + month + "-" + day;
                timeString = timeString + " " + hours + ":" + minutes + ":" + seconds;

                return [year, month, day, hours, minutes, seconds, dayOfWeek, timestamp, timeString]
            }
            function displayTime() {
                var jumpTime = document.getElementById("jump-time").value;
                var targetTime;
                if (jumpTime.length == 0) {
                    targetTime = new Date("1970-01-01 08:00:00");
                } else {
                    if (!jumpTime.includes(" ")) {
                        jumpTime += " 00:00:00";
                    }
                    targetTime = new Date(jumpTime);
                }
                var parsedTime = parseTime(targetTime);
                year = parsedTime[0];
                month = parsedTime[1];
                day = parsedTime[2];
                hours = parsedTime[3];
                minutes = parsedTime[4];
                seconds = parsedTime[5];
                dayOfWeek = parsedTime[6];
                timestamp = parsedTime[7];
                timeString = parsedTime[8];
                if (jumpTime.length == 0) {
                    document.getElementById("jump-time").placeholder = "1970-01-01 08:00:00";
                }
                document.getElementById("target-week").innerHTML = dayOfWeek;
                document.getElementById("target-ts").innerHTML = timestamp.toString();

                var timeZoneOffset = targetTime.getTimezoneOffset();
                var timeZoneOffsetSign = timeZoneOffset > 0 ? "-" : "+";
                timeZoneOffset = parseInt(Math.abs(timeZoneOffset / 60));
                var timeZone = Intl.DateTimeFormat().resolvedOptions().timeZone;
                timeZone = timeZone + " UTC" + timeZoneOffsetSign + timeZoneOffset.toString().padStart(2, '0'); 
                document.getElementById("target-tz").innerHTML = timeZone;

                utcDateM1 = new Date(Date.UTC(targetTime.getFullYear(), targetTime.getMonth(), targetTime.getDate() - 1));
                var lunarDate = chineseLunar.solarToLunar(utcDateM1);
                var lunarDateOut = chineseLunar.format(lunarDate, 'YMD');
                // fix chineseLunar bug when cross month
                var lunarDateA1 = chineseLunar.solarToLunar(new Date(
                    Date.UTC(targetTime.getFullYear(), targetTime.getMonth(), targetTime.getDate())));
                if ((lunarDate.month + 1) % 12 == lunarDateA1.month % 12) {
                    var lunarDateA1Out = chineseLunar.format(lunarDateA1, 'YMD');
                    if (lunarDateA1Out.includes("初二")) {
                        lunarDate = lunarDateA1;
                        lunarDateOut = lunarDateA1Out.replace("初二", "初一");
                    }
                }
                document.getElementById("lunar-date").innerHTML = lunarDateOut;

                var tiangan = ['甲', '乙', '丙', '丁', '戊', '己', '庚', '辛', '壬', '癸'];
                var dizhi = ['子', '丑', '寅', '卯', '辰', '巳', '午', '未', '申', '酉', '戌', '亥'];
                var shengxiao = ['鼠', '牛', '虎', '兔', '龙', '蛇', '马', '羊', '猴', '鸡', '狗', '猪'];

                var idx1 = (lunarDate.year - 4) % 10;
                var idx2 = (lunarDate.year - 4) % 12;
                document.getElementById("lunar-year").innerHTML = tiangan[idx1] + dizhi[idx2] + shengxiao[idx2] + "年";
            }
            window.addEventListener("load", displayTime);
        </script>
        <style>
            canvas {
                border: 1px solid black;
            }
            .time {
                text-align: center; 
                font-size: 30px; 
                color: #2980b9;
            }
            p input[type="text"] {
                border:1px solid rgba(0, 0, 0, 0.1);
                text-align:center;
                background:transparent;
                color:#830303;
                margin:0 auto;
                width:21rem;
                font-size:30px;
                border-radius:0.9rem;
            }
            /*
            input::placeholder {
                color: #2980b9;
            }
            */
        </style>
    </head>
    <body>

        <p id="target-week" class="time"></p>

        <p style="text-align:center;">
            <input type="text" oninput="setJumpTime(event)" id="jump-time" placeholder="1970-01-01 08:00:00">
        </p>

        <p id="target-ts" class="time"></p>

        <p id="target-tz" class="time"></p>
        
        <br>

        <p id="lunar-year" class="time"></p>

        <p id="lunar-date" class="time"></p>

    </body>
    </html>
