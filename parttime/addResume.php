<?php
    include("connect.php");
 
    $id_user = $_GET['id_user'];
    $firstname = $_GET['firstname'];
    $lastname = $_GET['lastname'];
    $age = $_GET['age'];
    $gender = $_GET['gender'];
    $experience = $_GET['experience'];
    $address = $_GET['address'];
    $contact = $_GET['contact'];
    $urlPicture = $_GET['urlPicture'];
    
        $sql = " INSERT INTO `resume`(`id`, `id_user`, `firstname`, `lastname`, `age`, `gender`, `experience`, `address`, `contact`, `urlPicture`)  
        VALUES (Null, '$id_user' ,'$firstname','$lastname','$age','$gender','$experience','$address','$contact','$urlPicture')";
       
        $result = mysqli_query($con, $sql);

        if ($result) {
			echo "true";
		} else {
			echo "false";
		}

    mysqli_close($con);

?>