.. SphinxTheme documentation master file, created by
   sphinx-quickstart on Wed May 16 09:00:04 2018.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

.. raw:: html

   <p id="current-time" style="font-size:20px; color:#2980b9;"></p>

    <script>
        function displayTime() {
            var currentTime = new Date();
            var timestamp = parseInt(currentTime.getTime() / 1000);
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

            var timeString = dayOfWeek;
            timeString = timeString + " " + year + "-" + month + "-" + day;
            timeString = timeString + " " + hours + ":" + minutes + ":" + seconds;
            timeString = timeString + " " + timestamp;
            document.getElementById("current-time").innerHTML = timeString;
        }
        // flush every second
        setInterval(displayTime, 1000);
    </script>


文档
========
.. note::

    **文档中可能存在错误，欢迎 PR。**

    https://github.com/fongyk/wiki

.. toctree::
   :maxdepth: 1
   :caption: 目录

   link/index
   cpp/index
   python/index
   linux/index
   git/index
   machineLearning/index
   deepLearning/index
   mathematicsAlgorithm/index
   recommender/index
   regularExpression/index
   cron/index
   computerNetwork/index
   softwares/index
   tech/index
   else/index
