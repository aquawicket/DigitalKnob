<?php
header('Access-Control-Allow-Origin: *');
include("../DK/DK.php");

// Base PHP File Functions
function ValidatePath($path){
	if(substr_count($path, ":") > 1){
		echo $path."\n";
		echo "ERROR: the path contains more than 1 :";
	}
	return $path;
}

// https://www.php.net/manual/en/function.file-exists.php
function urlExists($path){
	return file_exists(ValidatPath($path));
}

// https://www.php.net/manual/en/function.unlink.php
function delete($path){
	return unlink(ValidatePath($path));
}

// https://www.php.net/manual/en/function.is-dir
function isDir($path){
	echo "isDir(".$path.")";
	return is_dir(ValidatePath($path));
}

// https://www.php.net/manual/en/function.mkdir.php
function makeDir($path, $mode = 0777, $recursive = false){
    if(!mkdir(ValidatePath($path), $mode, $recursive))
        return false;
    return true;
}

// https://www.php.net/manual/en/function.file-get-contents.php
function fileToString($path, $use_include_path = false){    
    $str = file_get_contents(ValidatePath($path), $use_include_path);
    if($str === false)
    	return error("fileToString() failed");
    return $str;
}

// https://www.php.net/manual/en/function.file-put-contents.php
function stringToFile($path, $data, $flags = 0){
    if($flags === "FILE_APPEND"){ $flags = FILE_APPEND; }
    if($flags === "FILE_USE_INCLUDE_PATH"){ $flags = FILE_USE_INCLUDE_PATH; }
    if($flags === "LOCK_EX"){ $flags = LOCK_EX; }
    $bytes = file_put_contents(ValidatePath($path), $data, $flags);
    if($bytes === false)
        return error("stringToFile(): failed\n");
    return $bytes;
}


// Extended PHP File Functions 

function getAbsolutePath($path){
	$root = substr($_SERVER['SCRIPT_FILENAME'], 0, -strlen($_SERVER['SCRIPT_NAME'])+1);
	if(strpos(ValidatePath($path), $root) !== false)
		$aPath = $path;
	else
		$aPath = $root.$path;
	//return pathinfo($aPath,PATHINFO_DIRNAME)."/".pathinfo($aPath,PATHINFO_BASENAME);
	return $aPath;
}

function getAssetsPath(){
    $assetsPath = dirname(__DIR__);
    if(basename($assetsPath) != "assets")
        return error("assetsPath does not contain an assets folder \n");
    if(!is_dir($assetsPath))
    	return error("assetsPath is an invalid directory \n");
    return $assetsPath;
}

function getDKPath(){
    $dkPath = dirname(__DIR__);
    $n = 1;
    while(is_dir($dkPath) && $n < 10){
        $dkPath = dirname(__DIR__, $n++);
        if(basename($dkPath) == "digitalknob")
        	return $dkPath;
    }
    return error("could not find digitalknob path \n");
}

function getDKPluginsPath(){
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

function getRelativePath($path){
	$aPath = GetAbsolutePath($path);
	$path = str_replace($aPath,"",ValidatePath($path));
	return $path;
}

function pushDKAssets(){
	//Fist get all of the paths
	$assetsPath = GetAssetsPath();
	if(!$assetsPath)
		return error("assetsPath is invalid");
    $dkPath = GetDKPath();
    if(!$dkPath)
		return error("dkPath is invalid");
    echo "dkPath = ".$dkPath."\n";
    $dkPluginsPath = $dkPath."\DK\DKPlugins";
    if(!is_dir($dkPluginsPath))
    	return error("dkPluginsPath is invalid");
    echo "dkPluginsPath = ".$dkPluginsPath."\n";

    //we may or may not have a second plugins path
    $dkPluginsPath2 = GetDKPluginsPath();
    if($dkPluginsPath2 == $dkPluginsPath)
		$dkPluginsPath2 = 0;
	else
		echo "dkPluginsPath2 = ".$dkPluginsPath2."\n";

    //Now copy matching matching folders to the DKPlugins path(s)
	$assetsList = scandir($assetsPath);
	for($n = 2; $n < count($assetsList); $n++){
		if(!is_dir($assetsPath."\\".$assetsList[$n])) 
		    continue;
		$assetFolder = $assetsPath."\\".$assetsList[$n];
		$assetFiles = scandir($assetFolder);
        for($nn = 2; $nn < count($assetFiles); $nn++){
            if(is_dir($assetFolder."\\".$assetFiles[$nn])) 
                continue; 
            $src = $assetFolder."\\".$assetFiles[$nn];
            //echo $src." -> ";
            if(is_dir($dkPluginsPath."\\".$assetsList[$n])){
            	$dest = $dkPluginsPath."\\".$assetsList[$n]."\\".$assetFiles[$nn];
			    //echo $dest."\n";
			    if (!copy($src, $dest))
                    echo "FAILED to copy $src\n";
                else
                	echo "copied to $dest\n";
		    }
		    if($dkPluginsPath2 && is_dir($dkPluginsPath2."\\".$assetsList[$n])){
			    $dest = $dkPluginsPath2."\\".$assetsList[$n]."\\".$assetFiles[$nn];
			    //echo $dest."\n";
			    if (!copy($src, $dest))
                    echo "failed to copy $src\n";
                else
                	echo "copied to $dest\n";
		    }
        }
	}
	return true;
}

function directoryContents($path){
	echo "directoryContents(".$path.")\n";
	$path = ValidatePath($path);
	//echo "dir = ".$dir."\n";
	$root = $_SERVER['DOCUMENT_ROOT']."\\";
	//echo "root = ".$root."\n";
	echo "opendir($root.$dir)\n";
	$myDirectory = opendir($root.$dir);
	while($entryName = readdir($myDirectory)){
		//echo "entryName = ".$entryName."\n";
		$dirArray[] = $entryName;
	}
	closedir($myDirectory);
	
	//Lets sort in alpha order with folders on top
	for ($i = 1; $i < count($dirArray); $i++) {
		//echo "if(dir == '.')\n";
		if($dir == "."){
            //echo "if(filetype($root.$dirArray[$i]) == 'dir'\n";
    		if(filetype($root.$dirArray[$i]) == "dir")
				$folders[] = $dirArray[$i];
			else
				$files[] = $dirArray[$i];
		}
		else{
	        //echo "else {\n";
            //echo "if(filetype(".$root.$dir.$dirArray[$i].") == 'dir')\n";
			if(filetype($root.$dir.$dirArray[$i]) == "dir")
				$folders[] = $dirArray[$i];
			else
				$files[] = $dirArray[$i];
		}
	}
	
	natcasesort($folders);	
	if(count($files) > 0){
		natcasesort($files);
		$final = array_merge ($folders, $files);
	}
	else{
		$final = $folders;
		$final = $files;
	}
	return implode(",", $final);
}


/*
function Upload($src, $dest){
	//$target_dir //example /home/user/www/";
	//$dest = $target_dir + $target_file;
	//$fileType = pathinfo($target_file,PATHINFO_EXTENSION);
	// Check if image file is a actual image or fake image
	//if(!isset($_POST["submit"])){
		//return "submit not set.";
	//}
		
	//$check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
	//if($check == false){
	//	return; "File is not an image.";
	//}
    
	// Check if file already exists
	if(file_exists($dest)){
		return "Sorry, file ".$dest." already exists.";
	}
	// Check file size
	if($_FILES["fileToUpload"]["size"] > 5000000){
		return "Sorry, your file is too large.";
	}
	if(move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
		return "The file ". basename( $_FILES["fileToUpload"]["name"]). " has been uploaded.";
	}
	else{
		return "Sorry, there was an error uploading your file.";
	}
	return "ERROR";
}
*/

/*	
//////////////////////////////////////
if($printFiles = $_GET["PrintFiles"]){
	if($_SERVER["SERVER_NAME"] == "127.0.0.1"){
		$root = $_SERVER['DOCUMENT_ROOT']."/";
	}
	else{
		$root = $_SERVER['DOCUMENT_ROOT']."/".$_SERVER["SERVER_NAME"]."/";
	}
	$dirArray = ListFiles($printFiles);
	$indexCount	= count($dirArray);
	
	for($index=0; $index < $indexCount; $index++) {
        if (substr("$dirArray[$index]", 0, 1) != "."){ // don't list hidden files
			if($printFiles == "."){
				if(filetype($root.$dirArray[$index]) == "dir"){
					print("<img src=\"folder.png\" width=\"16\" height=\"16\" style=\"cursor:pointer;\" onclick=\"Clicked('$dirArray[$index]')\" />");
					print("<a id=\"$dirArray[$index]\" style=\"cursor:pointer;\" value=\"0\" onclick=\"Clicked('$dirArray[$index]')\">$dirArray[$index]</a>");
				}
				else{
					print("<img src=\"file.png\" width=\"16\" height=\"16\" style=\"cursor:pointer;\" onclick=\"OpenFile('$root$dirArray[$index]')\" />");
					print("<a id=\"$dirArray[$index]\" style=\"cursor:pointer;\" onclick=\"OpenFile('$root$dirArray[$index]')\">$dirArray[$index]</a>");
				}
			//print(filetype($dirArray[$index]));
			}
			else{
			    //get the number of /'s in $printFiles
				$levels = substr_count($printFiles, "/");
				$levels = 15+ ($levels * 15);
				if(filetype($root.$printFiles."/".$dirArray[$index]) == "dir"){
					print("<img src=\"folder.png\" width=\"16\" height=\"16\" style=\"padding-left:".$levels."px; cursor:pointer;\" onclick=\"Clicked('$printFiles/$dirArray[$index]');stopPropagation(event);\" />");
					print("<a id=\"$printFiles/$dirArray[$index]\" style=\"cursor:pointer;\" onclick=\"Clicked('$printFiles/$dirArray[$index]');top.stopPropagation(event);\">$dirArray[$index]</a>");
				}
				else{
					print("<img src=\"file.png\" width=\"16\" height=\"16\" style=\"padding-left:".$levels."px; cursor:pointer;\" onclick=\"OpenFile('$printFiles/$dirArray[$index]');stopPropagation(event);\" />");
					print("<a id=\"$root$printFiles/$dirArray[$index]\" style=\"cursor:pointer;\" onclick=\"OpenFile('$root$printFiles/$dirArray[$index]');top.stopPropagation(event);\">$dirArray[$index]</a>");
				}
			}
			if($index < $indexCount - 1){print("<br>");}
		}
	}
}
*/

/*
function ReadTheFile($readFile){ 
    if(file_exists($readFile)){
		if(filesize($readFile) > 0){
			//now lets load the file
			$fh = fopen($readFile, 'r') or die("can't open file");
			$code = fread($fh, filesize($readFile));
			fclose($fh);
			echo $code;
		}
		else{
	        echo "file ".$readFile." is blank";
		}
	}
	else{
		echo "file ".$readFile." does not exist";
	}
}
*/

/*
function saveFile($file, $data){
	echo "SaveFile($file,$data)";
	$data=stripslashes($data); //FIXME  don't do this if server is local
	if(file_exists($file)){ //Update the file
		//Make sure there are changes
		$fp = fopen($file, 'r');
		if(!$fp){ return "MESSAGE:can't open file"; }
		$oldcode = fread($fp, filesize($file));
		if(!$oldcode){ return "MESSAGE:can't read file"; }
		if(!fclose($fp)){ return "MESSAGE:can't close file"; }
		if($data == $oldcode){ return "MESSAGE: No changes have been made to ".$file; }
		
		//Save the file
		$fh = fopen($file, 'w');
		if(!$fh){ return "MESSAGE:can't open file"; }
		if(!fwrite($fh, $data)){ return "MESSAGE:can't write file"; }
		if(!fclose($fh)){ return "MESSAGE:can't close file"; }
	}
	else{ //Create the file
		$fh = fopen($file, 'w');
		if(!$fh){ return "MESSAGE:can't create file"; }
		if(!fwrite($fh, $data)){ return "MESSAGE:can't write file"; }
		if(!fclose($fh)){ return "MESSAGE:can't close file"; }
	}
	return "No Error";
}
*/

/*
////////////////////////////////////////
if($publishFile = $_POST["PublishFile"]){
	$data = $_POST["data"];
	$data=stripslashes($data); //FIXME  don't do this is server is local
	if(file_exists($publishFile)){  //make sure the file exists
		
		//Make sure the file has been saved first
		$fp = fopen($publishFile, 'r') or die("can't open file");
		$oldcode = fread($fp, filesize($publishFile));
		fclose($fp);
		if($data != $oldcode){
			echo "MESSAGE:You must save the file here and test it before you can publish it.";
			return;
		}
		
		$domain = str_replace("debug.snaptis.com", "snaptis.com", $publishFile);
		if(file_exists($domain)){
			//Make sure there are changes
			$fp = fopen($domain, 'r') or die("MESSGAE:can't open file");
			$oldcode = fread($fp, filesize($domain));
			fclose($fp);
			if($data == $oldcode){
				echo "MESSAGE:There are no changes between ".$publishFile." and the published version";
				return;
			}
		}
		
		$fh = fopen($domain, 'w') or die("MESSAGE:can't create file");
		fwrite($fh, $data);
		fclose($fh);
		echo $data;
	}
	die;
}
*/
?>