<?php 
$conn=mysqli_connect("localhost","id19864938_flutter","jmv}5qQFWzLwM=1g","id19864938_bhautik");
   
    $name = $_POST['name'];
	$email = $_POST['email'];
	$contact = $_POST['contact'];
	$password = $_POST['password'];

    $image = $_FILES['file'];

    $imagename=$image['name'];
    $imagepath=$image['tmp_name'];

    $folderpath="images/.$imagename";

    $temp = array();


    $check=mysqli_query($conn,"select * from user where contact='$contact' " );
    $check2=mysqli_query($conn,"select * from user where  email='$email' " );

   

    $row = mysqli_num_rows($check);
    $row2= mysqli_num_rows($check2);




    if($row==0 && $row2==0)
    {
        if(move_uploaded_file($imagepath,$folderpath))
        {
            $qry=mysqli_query($conn,"insert into user (name,email,password,contact,imagepath) values ('$name','$email','$password','$contact','$folderpath')");
    
            if($qry)
            {
                    $temp['result']=1;
            }
            else
            {
                $temp['result']=0;
            }
    
        }
        else
        {
            $temp['result']=0;
        }

    }
    elseif($row2==1)
    {
        $temp['result']=3;
    }
    else if($row==1)
    {
        $temp['result']=2;
    }

  

   
    echo json_encode($temp);
?>