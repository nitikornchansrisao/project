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
                 
        $id_favorite  = $_GET['id_favorite'];
        $id_jobdescription = $_GET['id_jobdescription'];
        $status = $_GET['status'];

    // $sql = "DELETE FROM `favoritejob` WHERE status='false' ";
        // $sql = "DELETE FROM `favoritejob` WHERE id_jobdescription = '$id_jobdescription' ";
        $sql = "DELETE FROM `favoritejob` WHERE id_favorite = '$id_favorite' ";


		// $sql = "DELETE FROM `favoritejob` WHERE id_favorite = '$id_favorite' AND status='1' ";
        

		$result = mysqli_query($con, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		} //if


	} 
   
}	// if1


	mysqli_close($con);
