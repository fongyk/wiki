倒计时
==========

.. raw:: html
    
    <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8">
            <title>countdown</title>
            <script>
                function formatDate(date) {
                    var timestamp = date.getTime() / 1000;
                    var year = date.getFullYear();
                    var month = date.getMonth() + 1;
                    var day = date.getDate();
                    var hours = date.getHours();
                    var minutes = date.getMinutes();
                    var seconds = date.getSeconds();
                    month = (month < 10 ? "0" : "") + month;
                    day = (day < 10 ? "0" : "") + day;
                    hours = (hours < 10 ? "0" : "") + hours;
                    minutes = (minutes < 10 ? "0" : "") + minutes;
                    seconds = (seconds < 10 ? "0" : "") + seconds;
                    var timeString = year + "-" + month + "-" + day;
                    timeString = timeString + " " + hours + ":" + minutes + ":" + seconds;
                    return timeString;
                }
                function getDistance(startTime, endTime) {
                    startTime = new Date(startTime).getTime();
                    endTime = new Date(endTime).getTime();
                    if (startTime < endTime) {
                        startTime = Math.floor(startTime / 1000) * 1000; // 秒取整
                    }
                    var distance = endTime - startTime;
                    var sign = distance > 0? "还有":"已过";
                    distance = Math.abs(distance);
                    var years = Math.round(distance / (1000 * 60 * 60 * 24 * 365) * 10) / 10; // 保留 1 位小数
                    var days = Math.floor(distance / (1000 * 60 * 60 * 24));
                    var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                    var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                    var seconds = Math.floor((distance % (1000 * 60)) / 1000);
                    return [sign, days, hours, minutes, seconds, years, distance];
                }
                function format(n, key, flag) {
                    if (n === "") {
                        document.getElementById(key).innerHTML = "";
                    } else {
                        document.getElementById(key).innerHTML = n.toString().padStart(2, "0");
                    }
                    if (flag) {
                        document.getElementById(key).style.color = "#6d0404";
                    } else {
                        document.getElementById(key).style.color = "#2980b9";
                    }
                }
                function countdown() {
                    var endTime = document.getElementById("endTime").value;
                    var startTime = document.getElementById("startTime").value;
                    // var arr = ["**", "--", "--", "--", "--", 0]
                    if (startTime.length == 0) {
                        startTime = formatDate(new Date());
                        document.getElementById("startTime").placeholder = startTime;
                        document.getElementById("startTimeFlag").innerHTML = "现在时刻";
                    } else {
                        if (!startTime.includes(" ")) {
                            startTime += " 00:00:00";
                        }
                        document.getElementById("startTimeFlag").innerHTML = "<br>";
                    }
                    if (endTime.length == 0) {
                        var t = new Date(startTime);
                        var wuyi = t.getFullYear() + "-05-01 00:00:00";
                        var shiyi = t.getFullYear() + "-10-01 00:00:00";
                        var nextYear = (t.getFullYear() + 1) + "-01-01 00:00:00";
                        var endTime;
                        if (startTime <= wuyi) {
                            endTime = wuyi;
                        } else if (startTime <= shiyi) {
                            endTime = shiyi;
                        } else {
                            endTime = nextYear;
                        }
                        document.getElementById("endTime").placeholder = endTime;
                    } else {
                        if (!endTime.includes(" ")) {
                            endTime += " 00:00:00";
                        }
                    }
                    var keys = ["年", "天", "小时", "分钟", "秒"];
                    var arr = getDistance(startTime, endTime);
                    if (arr[1] == 0) {
                        arr[1] = "";
                        keys[1] = "";
                        if (arr[2] == 0) {
                            arr[2] = "";
                            keys[2] = ""
                            if (arr[3] == 0) {
                                arr[3] = "";
                                keys[3] = "";
                            }
                        }
                    }
                    var flag = arr[6] <= 3600000;
                    document.getElementById("sign").innerHTML = arr[0];
                    format(arr[1], "days", flag);
                    format(arr[2], "hours", flag);
                    format(arr[3], "minutes", flag);
                    format(arr[4], "seconds", flag);
                    document.getElementById("k1").innerText = keys[1];
                    document.getElementById("k2").innerText = keys[2];
                    document.getElementById("k3").innerText = keys[3];
                    document.getElementById("k4").innerText = keys[4];
                    if (arr[5] < 1.0) {
                        document.getElementById("years").innerHTML = "";
                    } else {
                        document.getElementById("years").innerHTML = "(" + '<span style="color:#2980b9;">' + arr[5] + '</span>' + keys[0] + ")";
                    }
                }
                setInterval(countdown, 100);
                function setStartTime(e) {
                    var startTime = e.target.value;
                    countdown();
                }
                function setEndTime(e) {
                    var endTime = e.target.value;
                    countdown();
                }
            </script>
            <style>
                p input[type="text"] {
                    border:1px solid rgba(0, 0, 0, 0.1);
                    text-align:center;
                    background:transparent;
                    color:#830303;
                    margin:0 auto;
                    width:24rem;
                    font-size:1.9rem;
                    border-radius:0.9rem;
                }
                .textcss{
                    text-align:center;
                    font-size:2rem; 
                    color:rgb(4, 62, 80);
                }
            </style>
        </head>
        <body>
            <br><br>
            <p class="textcss" id="startTimeFlag"></p>
            <p style="text-align:center;">
                <input type="text" oninput="setStartTime(event)" id="startTime" placeholder="YYYY-MM-DD HH:MM:SS">
            </p>
            <p class="textcss">距离</p>
            <p style="text-align:center;">
                <input type="text" oninput="setEndTime(event)" id="endTime" placeholder="YYYY-MM-DD HH:MM:SS">
            </p>
            <p class="textcss"><span id="sign"></span></p>
            <p class="textcss">
                <span id="days"></span> <span id="k1"></span>
                <span id="hours"></span> <span id="k2"></span>
                <span id="minutes"></span> <span id="k3"></span>
                <span id="seconds"></span> <span id="k4"></span>
                <span id="years"></span>
            </p>
            <br><br><br><br><br>
        </body>
    </html>