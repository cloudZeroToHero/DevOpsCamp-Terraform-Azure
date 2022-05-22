<?php
echo "<h1 align=center> Congratulations ! </h1>";
echo "<h2 align=center> You have just deployed web server :-) </h2>";
echo "<h3 align=center> Your server Public IP is: ". $_SERVER['HTTP_HOST'] ." </h3>";
echo "<h3 align=center> Your server Private IP is: ". $_SERVER['SERVER_ADDR'] ." </h3>";
?>