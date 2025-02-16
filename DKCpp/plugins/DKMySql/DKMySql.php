<?php

header('Access-Control-Allow-Origin: *');
include("../DK/DK.php");

session_start();
$link;

//////////////////////
function Query($query)
{
	if(!$query){ return; }
	global $link;
	
	if($link){
		$query = str_replace("\\", "", $query);
		$result = mysql_query($query, $link);
		if(!$result){
			echo "DKERROR: query result invalid \n";
			echo $query;
			return;
		}
		if(!mysql_num_fields($result)){
			echo "DKERROR: No fields returned \n";
			return;
		}
		echo mysql_num_fields($result); //FIXME: not all query results have mysql_num_fields
		echo ",";
		while ($row = mysql_fetch_row($result)) {
		
			for ($x = 0; $x < sizeof($row); $x++) {
				echo $row[$x];
				echo ",";
			} 
		}
	}
	else{
		echo "DKERROR: Unable to connect to mysql link. \n";
	}
}

///////////////////////////////////////////////////////
function ConnectToServer($server, $username, $password)
{
	if(!$server){ return; }
	if(!$username){ return; }
	if(!$password){ return; }
	
	global $link;
	if($link){
      return;
    }

	//$_SESSION['database'] = ""; //TODO: only do this if the session is expired
	$link = mysql_pconnect($server,$username,$password);

	if($link){
		return;;
	}
	
	echo "DKERROR: ConnectToServer failed. \n";
}

//////////////////////////////////
function SelectDatabase($database)
{
	global $link;
	if($link){
		if(!$database){ return; }
		if(mysql_select_db($database)){
			return;
		}
	}
	else{
		echo "DKERROR: Unable to connect to mysql link \n";
	}
	echo "DKERROR: SelectDatabase failed \n";
}

/////////////////
if($_GET["host"])
{
	$var = explode(",", $_GET["host"]);
	if(!$var[0]){ echo "DKERROR: server variable empty"; }
	if(!$var[1]){ echo "DKERROR: username variable empty"; }
	if(!$var[2]){ echo "DKERROR: password variable empty"; }
	$_SESSION['server'] = $var[0];
	$_SESSION['username'] = $var[1];
	$_SESSION['password'] = $var[2];	
	ConnectToServer($_SESSION['server'], $_SESSION['username'], $_SESSION['password']);
	die();
}

/////////////////////
if($_GET["database"])
{
	if(!$_GET["database"]){ echo "DKERROR: database variable empty"; }
	$_SESSION['database'] = $_GET["database"];	
	ConnectToServer($_SESSION['server'], $_SESSION['username'], $_SESSION['password']);
	SelectDatabase($_SESSION['database']);
	die();
}

//////////////////
if($_GET["Query"])
{
	if(!$_GET["Query"]){ echo "DKERROR: query variable empty"; die(); }
	$query = $_GET["Query"];
	if($query === "Info"){
		echo "******DKMySql.php******";
		echo "\n";
		echo "PHP_SELF: ";
		echo $_SERVER['PHP_SELF'];
		echo "\n";
		echo "SERVER_NAME: ";
		echo $_SERVER['SERVER_NAME'];
		echo "\n";
		echo "HTTP_HOST: ";
		echo $_SERVER['HTTP_HOST'];
		echo "\n";
		echo "HTTP_REFERER: ";
		echo $_SERVER['HTTP_REFERER'];
		echo "\n";
		echo "HTTP_USER_AGENT: ";
		echo $_SERVER['HTTP_USER_AGENT'];
		echo "\n";
		echo "SCRIPT_NAME: ";
		echo $_SERVER['SCRIPT_NAME'];
		echo "\n";
		echo "SESSION_DATABASE: ";
		echo $_SESSION['database'];
		echo "\n";
		die();
	}
	ConnectToServer($_SESSION['server'], $_SESSION['username'], $_SESSION['password']);
	if($_SESSION['database']){
		SelectDatabase($_SESSION['database']);
	}
	Query($_GET["Query"]);
	die();
}


?>