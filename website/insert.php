<!DOCTYPE html>
<html>
<body>

<?php

echo "Using insert.php";

$servername = "35.193.254.184";
$username = "ins";
$password = "guest";
$dbname = "contact_db";

echo "Attempted Insert at $servername" ;

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if(!$conn) echo 'Not Connected to Server';


$sql = "INSERT INTO contact (firstname, lastname, email, phonenumber, message)
VALUES ($_POST('FName'), $_POST('LName'), $_POST('Email'), $_POST('Tel'), $_POST('Msg'))";

if(!mysqli_query($conn, $sql)){
	echo 'Not Inserted';
}
else{
	echo 'Inserted';
}

header("refresh:2; url = index.html");
?> 
</body>
</html>