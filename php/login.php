<?php  

$conn=mysqli_connect("localhost","id19864938_flutter","jmv}5qQFWzLwM=1g","id19864938_bhautik");

$username=$_REQUEST['username'];
$password=$_REQUEST['password'];

$qry=mysqli_query($conn,"select * from user where (email='$username' or contact='$username') and password='$password'");

$row=mysqli_num_rows($qry);

$temp=array();
$data=array();

if($row==1)
{
    $temp['result']=1;
    $data=mysqli_fetch_assoc($qry);
    $temp['data']=$data;


}
else
{
    $temp['result']=0;
}

echo json_encode($temp);


?>