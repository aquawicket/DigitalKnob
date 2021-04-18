<?php
header_status(500);
header('Access-Control-Allow-Origin: *');
//header('Content-Type: application/json; charset=UTF-8');

function header_status($statusCode) {
    static $status_codes = null;

    if ($status_codes === null) {
        $status_codes = array (
            100 => 'Continue',
            101 => 'Switching Protocols',
            102 => 'Processing',
            200 => 'OK',
            201 => 'Created',
            202 => 'Accepted',
            203 => 'Non-Authoritative Information',
            204 => 'No Content',
            205 => 'Reset Content',
            206 => 'Partial Content',
            207 => 'Multi-Status',
            300 => 'Multiple Choices',
            301 => 'Moved Permanently',
            302 => 'Found',
            303 => 'See Other',
            304 => 'Not Modified',
            305 => 'Use Proxy',
            307 => 'Temporary Redirect',
            400 => 'Bad Request',
            401 => 'Unauthorized',
            402 => 'Payment Required',
            403 => 'Forbidden',
            404 => 'Not Found',
            405 => 'Method Not Allowed',
            406 => 'Not Acceptable',
            407 => 'Proxy Authentication Required',
            408 => 'Request Timeout',
            409 => 'Conflict',
            410 => 'Gone',
            411 => 'Length Required',
            412 => 'Precondition Failed',
            413 => 'Request Entity Too Large',
            414 => 'Request-URI Too Long',
            415 => 'Unsupported Media Type',
            416 => 'Requested Range Not Satisfiable',
            417 => 'Expectation Failed',
            422 => 'Unprocessable Entity',
            423 => 'Locked',
            424 => 'Failed Dependency',
            426 => 'Upgrade Required',
            500 => 'Internal Server Error',
            501 => 'Not Implemented',
            502 => 'Bad Gateway',
            503 => 'Service Unavailable',
            504 => 'Gateway Timeout',
            505 => 'HTTP Version Not Supported',
            506 => 'Variant Also Negotiates',
            507 => 'Insufficient Storage',
            509 => 'Bandwidth Limit Exceeded',
            510 => 'Not Extended'
        );
    }

    if ($status_codes[$statusCode] !== null) {
        $status_string = $statusCode . ' ' . $status_codes[$statusCode];
        header($_SERVER['SERVER_PROTOCOL'] . ' ' . $status_string, true, $statusCode);
    }
}

function error($string){
	//header_status(500);
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
    	echo $result;
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
		return error("An Error occured in Debug_Func!");
	}
	return $var2;
}

//https://www.php.net/manual/en/function.file-put-contents.php
function StringToFile($file, $data, $mode)
{   
    if($mode == "FILE_APPEND"){
        if(!file_put_contents($file, $data, FILE_APPEND)){
        	return error("StringToFile(): failed\n");
        }
    }
    else{
    	if(!file_put_contents($file, $data)){
    		return error("StringToFile(): failed\n");
    	}
    }
    header_status(200);
    return "File saved successfully";
}

//https://www.php.net/manual/en/function.file-get-contents.php
function FileToString($file)
{    
    $str = file_get_contents($file);
    if(!$str){
    	return error("FileToString() failed");
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
        return error("assetsPath does not contain an assets folder \n");
    }
    if(!is_dir($assetsPath)){
    	return error("assetsPath is an invalid directory \n");
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
    return error("could not find digitalknob path \n");
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
    return error("cound not find DKPlugins path");
}

function PushDKAssets()
{
	//Fist get all fot he paths
	$assetsPath = GetAssetsPath();
	if(!$assetsPath){
		return error("assetsPath is invalid");
	}
	
    $dkPath = GetDKPath();
    if(!$dkPath){
		return error("dkPath is invalid");
    }
    echo "dkPath = ".$dkPath."\n";
    
    $dkPluginsPath = $dkPath."\DK\DKPlugins";
    if(!is_dir($dkPluginsPath)){
    	return error("dkPluginsPath is invalid");
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