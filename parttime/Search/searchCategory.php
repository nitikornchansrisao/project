<?php
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);

include("../connect.php");

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

        $id_category = $_GET['id_category'];
        $workday = $_GET['workday'];
        $salary = $_GET['salary'];
        $id_gender = $_GET['id_gender'];
        $startTime = $_GET['startTime'];
        $endTime = $_GET['endTime'];

        if ($workday == '[]' &&  $salary == '' && $id_gender == 'เพศ' && $startTime == '' && $endTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category'");
        } //1

        else if ($salary == '' && $id_gender == 'เพศ' && $startTime == '' && $endTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND workday='$workday'");
        }//1,2

        else if ($workday == '[]' &&  $id_gender == 'เพศ' && $startTime == '' && $endTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND salary='$salary'");
        }//1,3

        else if ($workday == '[]' &&  $salary == '' && $startTime == '' && $endTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND id_gender='$id_gender'");
        }//1,4

        else if ($workday == '[]' &&  $salary == '' && $id_gender == 'เพศ' && $endTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND startTime='$startTime'");
        } //1,5

        else if ($workday == '[]' &&  $salary == '' && $id_gender == 'เพศ' && $startTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND endTime='$endTime'");
        } //1,6

        else if ( $id_gender == 'เพศ' && $startTime == '' && $endTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND workday='$workday' AND  salary='$salary' ");
        } //1,2,3

        else if ($salary == '' && $startTime == '' && $endTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category'AND workday='$workday' AND id_gender='$id_gender'");
        } //1,2,4

        else if ($salary == '' && $id_gender == 'เพศ' && $endTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND workday='$workday' AND startTime='$startTime'");
        } //1,2,5

        //***************************************************************************************//


        else if ($salary == '' && $id_gender == 'เพศ' && $startTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND workday='$workday' AND endTime='$endTime'");
        } //1,2,6

        else if ($workday == '[]' &&  $startTime == '' && $endTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND salary='$salary' AND id_gender='$id_gender'");
        } //1,3,4

        else if ($workday == '[]' && $id_gender == 'เพศ' && $endTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND salary='$salary' AND startTime='$startTime'");
        } //1,3,5

        else if ($workday == '[]' && $id_gender == 'เพศ' && $startTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND salary='$salary' AND endTime='$endTime'");
        } //1,3,6

        else if ($workday == '[]' &&  $salary == '' && $endTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND id_gender='$id_gender' AND startTime='$startTime'");
        } //1,4,5

        else if ($workday == '[]' &&  $salary == '' && $startTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND id_gender='$id_gender' AND endTime='$endTime'");
        } //1,4,6

        else if ($workday == '[]' &&  $salary == '' && $id_gender == 'เพศ') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND startTime='$startTime' AND endTime='$endTime'");
        } //1,5,6

        else if ($startTime == '' && $endTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND workday='$workday' AND  salary='$salary' AND id_gender='$id_gender'");
        } //1,2,3,4

        else if ($id_gender == 'เพศ' && $endTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND workday='$workday' AND  salary='$salary' AND startTime='$startTime'");
        } //1,2,3,5

        else if ($id_gender == 'เพศ' && $startTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND workday='$workday' AND  salary='$salary' AND endTime='$endTime'");
        } //1,2,3,6
        
        
        //***************************************************************************************//

        else if ($salary == '' && $endTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND workday='$workday' AND id_gender='$id_gender' AND startTime='$startTime'");
        } //1,2,4,5

        else if ($salary == '' && $startTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND workday='$workday' AND id_gender='$id_gender' AND endTime='$endTime'");
        } //1,2,4,6

        else if ($salary == '' && $id_gender == 'เพศ') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND workday='$workday' AND startTime='$startTime' AND endTime='$endTime'");
        } //1,2,5,6

        else if ($endTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND workday='$workday' AND  salary='$salary' AND id_gender='$id_gender' AND startTime='$startTime'");
        } //1,2,3,4,5

        else if ($startTime == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND workday='$workday' AND  salary='$salary' AND id_gender='$id_gender' AND endTime='$endTime'");
        } //1,2,3,4,6

        else if ($id_gender == 'เพศ') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND workday='$workday' AND  salary='$salary' AND startTime='$startTime' AND endTime='$endTime'");
        } //1,2,3,5,6

        else if ($salary == '') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND workday='$workday' AND id_gender='$id_gender' AND startTime='$startTime' AND endTime='$endTime'");
        } //1,2,4,5,6

        else if ($workday == '[]') {
            $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category' AND  salary='$salary' AND id_gender='$id_gender' AND startTime='$startTime' AND endTime='$endTime'");
        } //1,3,4,5,6

        // if ($id_category=''&& $workday == '[]' &&  $salary == '' && $id_gender == 'เพศ' && $startTime == '' && $endTime == '') {
        //     $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category'");
        // } //1
        

        


        


        // $result = mysqli_query($con, "SELECT * FROM jobdescription WHERE id_category='$id_category'   ");

        if ($result) {

            while ($row = mysqli_fetch_assoc($result)) {

                $output[] = $row;
            }    // while

            echo json_encode($output);
        } //if

    }
}    // if1


mysqli_close($con);
