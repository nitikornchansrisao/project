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
			
		$id = $_GET['id'];		
        $nameShop = $_GET['nameShop'];
        $UrlPicture = $_GET['UrlPicture'];
		$Lat = $_GET['Lat'];
		$Lng = $_GET['Lng'];
    
							
		$sql = "UPDATE `usertable` SET `nameShop` = '$nameShop', `UrlPicture` = '$UrlPicture',`Lat` = '$Lat',`Lng` = '$Lng' 
        WHERE id = '$id'";

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