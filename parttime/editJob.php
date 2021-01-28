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
			
	  $id_jobdescription = $_GET['id_jobdescription'];
    $nameJob = $_GET['nameJob'];
    $description = $_GET['description'];
    $qualification = $_GET['qualification'];
    $age = $_GET['age'];
    $salary = $_GET['salary'];
    $startTime = $_GET['startTime'];
    $endTime = $_GET['endTime'];
    // $gender = $_GET['gender'];
    $contact = $_GET['contact'];
    $urlPicture = $_GET['UrlPicture'];
    $lat = $_GET['Lat'];
    $lng = $_GET['Lng'];
							
		$sql = "UPDATE `jobdescription` SET `nameJob`='$nameJob',`description`='$description',`qualification`='$qualification',`age`='$age',`salary`='$salary',`startTime`='$startTime',`endTime`='$endTime',`contact`='$contact',`UrlPicture`='$urlPicture' 
    WHERE `id_jobdescription`='$id_jobdescription'";

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