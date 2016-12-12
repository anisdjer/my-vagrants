<?php
$link = mysql_connect("192.168.20.2", "vagrant", "vagrant")
    or die("Impossible de se connecter : " . mysql_error());
echo 'Connexion réussie';
mysql_close($link);
