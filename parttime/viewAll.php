<?php

include("connect.php");

$category = $con->query("SELECT * FROM category");
$list = array();

while ($rowdata = $category->fetch_assoc()){
    $list[] = $rowdata;
}

echo json_encode($list);

