<?php
include("connect.php");

$id_user = $_GET['id_user'];
$nameJob = $_GET['nameJob'];
$id_category = $_GET['id_category'];
$description = $_GET['description'];
$qualification = $_GET['qualification'];
$age = $_GET['age'];
$salary = $_GET['salary'];
$startTime = $_GET['startTime'];
$endTime = $_GET['endTime'];
$id_gender = $_GET['id_gender'];
$contact = $_GET['contact'];
$urlPicture = $_GET['UrlPicture'];
$lat = $_GET['Lat'];
$lng = $_GET['Lng'];
$workday = $_GET['workday'];
$id_statusFav = $_GET['id_statusFav'];



// $sql = " INSERT INTO `jobdescription`(`id_jobdescription`,`id_user`, `nameJob`,`category`, `description`, `qualification`, `age`, `salary`, `startTime`, `endTime`, `gender`, `contact`, `UrlPicture`, `Lat`, `Lng`)  
// VALUES (Null, '$id_user' ,'$nameJob','$category','$description','$qualification','$age','$salary','$startTime','$endTime','$gender','$contact','$urlPicture','$lat','$lng')";

$sql = " INSERT INTO `jobdescription`(`id_jobdescription`,`id_user` , `nameJob`,`id_category`, `description`, `qualification`, `age`, `salary`, `startTime`, `endTime`, `id_gender`, `contact`, `UrlPicture`, `Lat`, `Lng`, `workday`, `id_statusFav` ) 
        VALUES (Null, '$id_user' ,'$nameJob','$id_category','$description','$qualification','$age','$salary','$startTime','$endTime','$id_gender','$contact','$urlPicture','$lat','$lng','$workday','$id_statusFav')";


$result = mysqli_query($con, $sql);

if ($result) {
    echo "true";
} else {
    echo "false";
}

mysqli_close($con);
