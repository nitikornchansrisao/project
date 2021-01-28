<?php
    include("connect.php");
 
    $name = $_GET['name'];
    $username = $_GET['username'];
    $password = $_GET['password'];
    $choosetype = $_GET['choosetype'];

        $sql = " INSERT INTO `usertable`(`id`, `name`, `username`, `password`, `choosetype`)  
        VALUES (Null,'$name','$username','$password','$choosetype')";
       
        $result = mysqli_query($con, $sql);

        if ($result) {
			echo "true";
		} else {
			echo "false";
		}

    mysqli_close($con);

?>