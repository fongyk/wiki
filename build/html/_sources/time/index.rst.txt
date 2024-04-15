现在时刻
==========

.. raw:: html

    <html>
    <head>
        <title>TIME</title>
        <script src="https://cdn.jsdelivr.net/npm/chinese-lunar"></script>
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

                var timeZoneOffset = currentTime.getTimezoneOffset();
                var timeZoneOffsetSign = timeZoneOffset > 0 ? "-" : "+";
                timeZoneOffset = parseInt(Math.abs(timeZoneOffset / 60));
                var timeZone = Intl.DateTimeFormat().resolvedOptions().timeZone;
                timeZone = timeZone + " UTC" + timeZoneOffsetSign + timeZoneOffset.toString().padStart(2, '0'); 
                document.getElementById("current-tz").innerHTML = timeZone;

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
            setInterval(displayTime, 123);
        </script>
        <style>
            canvas {
                border: 1px solid black;
            }
        </style>
    </head>
    <body>

        <p id="current-week" style="text-align: center; font-size:30px; color:#2980b9;"></p>

        <p id="current-time" style="text-align: center; font-size:30px; color:#2980b9;"></p>

        <p id="current-ts" style="text-align: center; font-size:30px; color:grey;"></p>

        <p id="current-tz" style="text-align: center; font-size:30px; color:#2980b9;"></p>
        
        <br>

        <p id="lunar-year" style="text-align: center; font-size:30px; color:#2980b9;"></p>

        <p id="lunar-date" style="text-align: center; font-size:30px; color:#2980b9;"></p>

    </body>
    </html>


.. raw:: html

    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>CLOCK</title>
        <style>
            body, html {
                height: 100%;
                margin: 0;
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .clock-container {
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .scale-1x{font-size: 8px; width: 150px; height: 150px; border: 10px solid black; box-shadow: 0px 0px 10px 1px #444 inset, 0px 0px 10px 1px #444;}
            .scale-2x{font-size: 10px; width: 250px; height: 250px; border: 10px solid black; box-shadow: 0px 0px 10px 2px #444 inset, 0px 0px 10px 1px #444;}
            .scale-3x{font-size: 15px; width: 300px; height: 300px; border: 10px solid black; box-shadow: 0px 0px 10px 3px #444 inset, 0px 0px 10px 1px #444;}

            .clockbox{ border-radius: 50%; position: relative;}
            /*时钟中心点*/
            .clockcenter{ width: 3%; height: 3%; border-radius: 40%; background: #520404; top: 48.5%; left: 48.5%; position: absolute;}
            /*时钟数字*/
            .num{ width: 10%; height: 10%; line-height: 1.6em; text-align: center; font-size: 1.5em; position: absolute;}
            /*时钟刻度*/
            .clockscale{ width:50%;height:1px;transform-origin:0%;z-index:7;position:absolute;top:50%;left:50%;}
            .hiddenscale_min{ width:91.5%;height:1px;float:left;} 
            .displayscale_min{ width:5%;height:1px;background-color:#555;float:left;}
            .hiddenscale_hour{ width:90%;height:2px;float:left;} 
            .displayscale_hour{ width:12px;height:2px;background-color:#520404;float:left;}
            /*时针、分针、秒针*/
            .hourhand{width:23%;height:3px;background-color:black;transform-origin:0%;z-index:20;position:absolute;top:49.4%;left:50%;border-radius:2px;box-shadow:1px -3px 8px 3px #aaa;}
            .minutehand{width:33.5%;height:2px;background-color:grey;transform-origin:0%;z-index:21;position:absolute;top:49.8%;left:50%;border-radius:1px;box-shadow:1px -3px 8px 1px #aaa;}
            .secondhand{width:45.5%;height:1px;background-color:red;transform-origin:0%;z-index:22;position:absolute;top:49.99%;left:50%;border-radius:0.5px;box-shadow:1px -3px 8px 1px #aaa;}
        </style>
    </head>
    <body>
        <br>
        <br>
        <div class="clock-container">
            <div class="clockbox scale-3x" id="clock"> 
                <!-- 时钟中心点 -->  
                <div class="clockcenter"></div>  
                <!-- 时钟数 -->  
                <div class="clocknum">  
                    <div class="num">12</div>  
                    <div class="num">1</div>  
                    <div class="num">2</div>  
                    <div class="num">3</div>  
                    <div class="num">4</div>  
                    <div class="num">5</div>  
                    <div class="num">6</div>  
                    <div class="num">7</div>  
                    <div class="num">8</div>  
                    <div class="num">9</div>  
                    <div class="num">10</div>  
                    <div class="num">11</div>  
                </div>  
                <div class="hourhand" id="hourhand"></div>  <!--  时针 -->
                <div class="minutehand" id="minutehand"></div>  <!--  分针 -->
                <div class="secondhand" id="secondhand"></div>  <!--  秒针 -->
            </div>
        </div>
        <script>
            var clock = document.getElementById("clock");
            function initClockLayout(){
                var radius = clock.clientWidth/2-clock.clientWidth/10;
                var relativelength = clock.clientWidth/2-clock.clientWidth/20;
                var rad = 2 * Math.PI / 12;
                var dot = document.getElementsByClassName("num");
                for (var i = 0; i < dot.length; i++) {
                    dot[i].style.left = (relativelength + Math.sin(rad * i) * radius) + "px";
                    dot[i].style.top = (relativelength - Math.cos(rad * i) * radius) - 3 + "px";
                }
                for(var i = 0; i < 60; i++){
                    if (i % 5 == 0) {
                        clock.innerHTML += "<div class='clockscale'><div class='hiddenscale_hour'></div><div class='displayscale_hour'></div></div>"; 
                    } else {
                        clock.innerHTML += "<div class='clockscale'><div class='hiddenscale_min'></div><div class='displayscale_min'></div></div>"; 
                    }
                }
                var scale = document.getElementsByClassName("clockscale");
                for(var i = 0;  i < scale.length; i++){
                    scale[i].style.transform = "rotate(" + (i * 6 - 90) +"deg)";
                }
            }
            initClockLayout();
            var hourhand = document.getElementById("hourhand");
            var minutehand = document.getElementById("minutehand");
            var secondhand = document.getElementById("secondhand");
            function updateTime(){
                var my_date = new Date();
                var hour = my_date.getHours(), minute = my_date.getMinutes(), second = my_date.getSeconds();
                var hour_rotate = (hour * 30 - 90) + (Math.floor(minute / 12) * 6);
                hourhand.style.transform = "rotate(" + hour_rotate + "deg)";
                minutehand.style.transform = "rotate(" + (minute * 6 - 90) + "deg)";
                secondhand.style.transform = "rotate(" + (second * 6 - 90) + "deg)";
                setTimeout(updateTime, 123);
            }
            setTimeout(updateTime, 123);
        </script>
    </body>
    </html>