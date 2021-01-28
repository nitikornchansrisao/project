<?php
    $host="localhost";
    $user="root";
    $pass="";
    $db="parttime";

    $con = mysqli_connect($host,$user,$pass,$db);

    if(mysqli_connect_errno())
    {
        echo "Connection not successful".mysqli_connect_error();
        exit();
    }

    
    mysqli_query($con,"SET NAMES utf8");

?>