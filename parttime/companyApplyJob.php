<?php
  header("content-type:text/javascript;charset=utf-8");
  error_reporting(0);
  error_reporting(E_ERROR | E_PARSE);
  
  include("connect.php");

  if (!$con) {
      echo "Error: Unable to connect to MySQL." . PHP_EOL;
      echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
      echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
      
      exit;
  }
  
  if (!$con->set_charset("utf8")) {
      printf("Error loading character set utf8: %s\n", $con->error);
      exit();
      }
  

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {

		$id_apply = $_GET['id_apply'];		
		$status = $_GET['status'];		
	
		$sql = "UPDATE `applyjob` SET `status` = '$status' WHERE id_apply = '$id_apply'";

		$result = mysqli_query($con, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome ";
   
}

	mysqli_close($link);
?>