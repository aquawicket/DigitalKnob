<?php
header('Access-Control-Allow-Origin: *');
header("Content-Type: application/json; charset=UTF-8");

function ERROR($string){
	header('HTTP/1.1 500 Internal Server Error');
    header('Content-Type: application/json; charset=UTF-8');
    die($string);
}

////////////////////////
function DKINFO($string){
	return $string;
}

if($_REQUEST["x"]){
	$json = urldecode($_REQUEST["x"]);
	$obj = json_decode($json);
    $func = $obj->func;
    $args = $obj->args;
    $args_length = count($args);
    $values = [];
    for($i=0; $i<$args_length; $i++){
        foreach($args[$i] as $key => $value){
            $values[$i] = $value;
        }
    }

    $result = call_user_func_array($func,$values);
    if(!empty($result)){

    	print $result;
    	//print json_encode($result);
    }

    //echo "\n_REQUEST[x] json = \n".$json."\n\n";

    /*
    //Show the function prototype
    $funcProto = $func."(";
    for($i=0; $i<$args_length; $i++){
        $arg = $args[$i];
        foreach($arg as $key => $value){
            $funcProto = $funcProto.$key;
            if($i<($args_length-1)){
            	$funcProto = $funcProto.",";
            }
        }
    }
    $funcProto = $funcProto.")";
    echo "\n".$funcProto."\n";
    */

    /*
    //Show the function call 
    $funcCall = $func."(";
    $values = [];
    for($i=0; $i<$args_length; $i++){
        $arg = $args[$i];
        foreach($arg as $key => $value){
            $funcCall = $funcCall.$value;
            $values[$i] = $value;
            if($i<($args_length-1)){
            	$funcCall = $funcCall.",";
            }
        }
    }
    $funcCall = $funcCall.")";
    echo "\n".$funcCall."\n";
    */
}

function Debug_Func($var1, $var2, $var3)
{
	if(1){
		ERROR("An Error occured in Debug_Func!");
	    return false;
	}
	return $var1;
}

//https://www.php.net/manual/en/function.file-put-contents.php
function StringToFile($file, $data, $mode)
{   
    if($mode == "FILE_APPEND"){
        if(!file_put_contents($file, $data, FILE_APPEND)){
        	ERROR("StringToFile(): failed\n");
        	return false;
        }
    }
    else{
    	if(!file_put_contents($file, $data)){
    		ERROR("StringToFile(): failed\n");
    		return false;
    	}
    }
}

//https://www.php.net/manual/en/function.file-get-contents.php
function FileToString($file)
{    
    $str = file_get_contents($file);
    if(!$str){
    	ERROR("FileToString() failed");
    	return false;
    }
    return $str;
}

function GetTime()
{
	$str = "Today is " . date("Y/m/d") . "<br>";
    $str .= "Today is " . date("Y.m.d") . "<br>";
    $str .= "Today is " . date("Y-m-d") . "<br>";
    $str .= "Today is " . date("l");
    return $str;
}

function GetRemoteAddress()
{
	$ipaddress = '';
    if (isset($_SERVER['REMOTE_ADDR']))
        $ipaddress = $_SERVER['REMOTE_ADDR'];
    else if(isset($_SERVER['HTTP_X_FORWARDED_FOR']))
        $ipaddress = $_SERVER['HTTP_X_FORWARDED_FOR'];
    else if(isset($_SERVER['HTTP_X_FORWARDED']))
        $ipaddress = $_SERVER['HTTP_X_FORWARDED'];
    else if(isset($_SERVER['HTTP_FORWARDED_FOR']))
        $ipaddress = $_SERVER['HTTP_FORWARDED_FOR'];
    else if(isset($_SERVER['HTTP_FORWARDED']))
        $ipaddress = $_SERVER['HTTP_FORWARDED'];
    else if(isset($_SERVER['HTTP_CLIENT_IP']))
        $ipaddress = $_SERVER['HTTP_CLIENT_IP'];
    return $ipaddress;
}

function GetRemoteUser()
{
	return $_SERVER["REMOTE_USER"];
}

function GetAssetsPath()
{
    $assetsPath = dirname(__DIR__);
    if(basename($assetsPath) != "assets"){
        ERROR("assetsPath does not contain an assets folder \n");
        return false;
    }
    if(!is_dir($assetsPath)){
    	ERROR("assetsPath is an invalid directory \n");
    	return false;
    }
    return $assetsPath;
}

function GetDKPath()
{
    $dkPath = dirname(__DIR__);
    $n = 1;
    while(is_dir($dkPath) && $n < 10){
        $dkPath = dirname(__DIR__, $n++);
        if(basename($dkPath) == "digitalknob"){
        	return $dkPath;
        }
    }
    ERROR("could not find digitalknob path \n");
    return false;
}

function GetDKPluginsPath()
{
    $dkPluginsPath = dirname(__DIR__);
    $n = 1;
    while(is_dir($dkPluginsPath) && $n < 10){
        $dkPluginsPath = dirname(__DIR__, $n++);
        if(is_dir($dkPluginsPath."\DKPlugins")){
        	$dkPluginsPath = $dkPluginsPath."\DKPlugins";
        	return $dkPluginsPath;
        }
    }
    ERROR("cound not find DKPlugins path");
    return false;
}

function PushDKAssets()
{
	//Fist get all fot he paths
	$assetsPath = GetAssetsPath();
	if(!$assetsPath){
		ERROR("assetsPath is invalid");
		return false;
	}
	
    $dkPath = GetDKPath();
    if(!$dkPath){
		ERROR("dkPath is invalid");
		return false;
    }
    echo "dkPath = ".$dkPath."\n";
    
    $dkPluginsPath = $dkPath."\DK\DKPlugins";
    if(!is_dir($dkPluginsPath)){
    	ERROR("dkPluginsPath is invalid");
    }
    echo "dkPluginsPath = ".$dkPluginsPath."\n";

    //we may or may not have a second plugins path
    $dkPluginsPath2 = GetDKPluginsPath();
    if($dkPluginsPath2 == $dkPluginsPath){
		$dkPluginsPath2 = 0;
	}
	else{
		echo "dkPluginsPath2 = ".$dkPluginsPath2."\n";
	}

    //Now copy matching matching folders to the DKPlugins path(s)
	$assetsList = scandir($assetsPath);
	for($n = 2; $n < count($assetsList); $n++){
		if(!is_dir($assetsPath."\\".$assetsList[$n])){ continue; }
		$assetFolder = $assetsPath."\\".$assetsList[$n];
		$assetFiles = scandir($assetFolder);
        for($nn = 2; $nn < count($assetFiles); $nn++){
            if(is_dir($assetFolder."\\".$assetFiles[$nn])){ continue; }
            $src = $assetFolder."\\".$assetFiles[$nn];
            //echo $src." -> ";
            if(is_dir($dkPluginsPath."\\".$assetsList[$n])){
            	$dest = $dkPluginsPath."\\".$assetsList[$n]."\\".$assetFiles[$nn];
			    //echo $dest."\n";
			    if (!copy($src, $dest)) {
                    echo "failed to copy $src\n";
                    //return false;
                }else{
                	echo "copied to $dest\n";
                	//return true;
                }
		    }
		    if($dkPluginsPath2 && is_dir($dkPluginsPath2."\\".$assetsList[$n])){
			    $dest = $dkPluginsPath2."\\".$assetsList[$n]."\\".$assetFiles[$nn];
			    //echo $dest."\n";
			    if (!copy($src, $dest)) {
                    echo "failed to copy $src\n";
                    //return false;
                }
                else{
                	echo "copied to $dest\n";
                	//return true;
                }
		    }
        }
	}
}

?>