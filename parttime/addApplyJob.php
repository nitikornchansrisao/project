
    <?php
    include("connect.php");
 
    $id_resume = $_GET['id_resume'];
    $id_jobdescription = $_GET['id_jobdescription'];
    $id_category = $_GET['id_category'];
    $status = $_GET['status'];

    
        $sql = " INSERT INTO `applyjob`(`id_apply`,`id_resume`, `id_jobdescription`, `id_category`, `status` )  
        VALUES (Null, '$id_resume' ,'$id_jobdescription','$id_category','$status')";
       
        $result = mysqli_query($con, $sql);

        if ($result) {
			echo "true";
		} else {
			echo "false";
		}

    mysqli_close($con);

?>
