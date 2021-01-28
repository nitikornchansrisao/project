<?php

include("connect.php");


$gender = $con->query("SELECT * FROM gender");
$list = array();

while ($rowdata = $gender->fetch_assoc()){
    $list[] = $rowdata;
}

echo json_encode($list);

