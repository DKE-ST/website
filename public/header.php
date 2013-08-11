<?php

$url = "http://bruiser.mit.edu/dke/php_header";
$context = "?uname=" . $_SERVER["REMOTE_USER"];
$content = file_get_contents($url.$context);
$header_end = strpos($content,"</header>");
echo substr($content,0,$header_end+9);

echo "<h1 style='padding-left:10px'>Index of " . urldecode($_SERVER['REQUEST_URI']) . "</h1>";
?>
