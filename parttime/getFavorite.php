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
                
     
        // $id_user = $_GET['id_user'];
        $id_resume = $_GET['id_resume'];
        // $id_user = 58;

		$result = mysqli_query($con, "SELECT * FROM favoritejob INNER JOIN category ON favoritejob.id_category = category.category INNER JOIN resume ON favoritejob.id_resume = resume.id INNER JOIN jobdescription ON favoritejob.id_jobdescription = jobdescription.id_jobdescription WHERE id_resume = '$id_resume'");

		if ($result) {

			while($row=mysqli_fetch_assoc($result)){

			$output[]=$row;

			}	// while

			echo json_encode($output);

		} //if

	} 
   
}	// if1


	mysqli_close($con);
    
?>