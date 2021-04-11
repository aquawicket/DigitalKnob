<?php

header('Access-Control-Allow-Origin: *');
include("../DK/DK.php");

/////////////////////////
function PathExists($path)
{
	$file_headers = @get_headers($path);
	return $file_headers[0];
}
if($_GET["PathExists"])
{
	echo PathExists($_GET["PathExists"]);
}

//////////////////////
function Upload($path)
{
	$target_dir = $path; //example /home/user/www/";
	$target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);
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
	if(file_exists($target_file)){
		return "Sorry, file ".$target_file." already exists.";
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
if($_GET["Upload"])
{
	Upload($_GET["Upload"]);
	header('Location: '.$_GET["Redirect"].'');
	die;
}

//////////////////////
function Delete($file)
{
	if(unlink($file)){
		return "file deleted";
	}
	return "could not delete file";
}
if($_GET["Delete"])
{
	echo Delete($_GET["Delete"]);
}

//////////////////////////////
function GetRelativePath($dir)
{
	$aPath = GetAbsolutePath($dir);
	$dir = str_replace($aPath,"",$dir);
	return $dir;
}
if($_GET["GetRelativePath"])
{
	echo GetRelativePath($_GET["GetRelativePath"]);
}

//////////////////////////////
function GetAbsolutePath($dir)
{
	$root = substr($_SERVER['SCRIPT_FILENAME'], 0, -strlen($_SERVER['SCRIPT_NAME'])+1);
	if(strpos($dir, $root) !== FALSE){
		$aPath = $dir;
	}
	else{
		$aPath = $root.$dir;
	}
	//return pathinfo($aPath,PATHINFO_DIRNAME)."/".pathinfo($aPath,PATHINFO_BASENAME);
	return $aPath;
}
if($_GET["GetAbsolutePath"])
{
	echo GetAbsolutePath($_GET["GetAbsolutePath"]);
}

//////////////////////////
function IsDirectory($dir)
{
	if(is_dir($dir)){
		return "1";
	}
	else{
		return "0";
	}
}
if($_GET["IsDirectory"])
{
	echo IsDirectory($_GET["IsDirectory"]);
}

////////////////////////////////
function DirectoryContents($dir)
{
	//echo "php: DirectoryContents";
	$myDirectory = opendir($dir);
	while($entryName = readdir($myDirectory)){
		$dirArray[] = $entryName;
	}
	closedir($myDirectory);
	
	//Lets sort in alpha order with folders on top
	for ($i = 1; $i < count($dirArray); $i++) {
		if($dir == "."){
    		if(filetype($root.$dirArray[$i]) == "dir"){
				$folders[] = $dirArray[$i];
			}
			else{
				$files[] = $dirArray[$i];
			}
		}
		else{
			if(filetype($root.$dir."/".$dirArray[$i]) == "dir"){
				$folders[] = $dirArray[$i];
			}
			else{
				$files[] = $dirArray[$i];
			}
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
	return implode(",",$final);
}
if($_GET["DirectoryContents"]){
	echo DirectoryContents($_GET["DirectoryContents"]);
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
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

//////////////////////////////////
if($readFile = $_GET["ReadFile"]){
	if(file_exists($readFile)){
		if(filesize($readFile) > 0){
			//now lets load the file
			$fh = fopen($readFile, 'r') or die("MESSAGE:can't open file");
			$code = fread($fh, filesize($readFile));
			fclose($fh);
			echo $code;
		}
		else{
			//file is blank
		}
	}
	else{
		echo "MESSAGE:file ".$readFile." does not exist";
	}
	die;
}

////////////////////////////////
function SaveFile($file, $data){
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

/////////////////////
if($_GET["SaveFile"])
{
	if(!$_GET["data"]){ echo "DKERROR: data variable empty"; }
	echo SaveFile($_GET["SaveFile"], $_GET["data"]);
	die();
}

/*
//////////////////////////////////
if($saveFile = $_POST["SaveFile"]){
	$data = $_POST["data"];
	echo SaveFile($saveFile, $data);
	die();
}
*/

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

?>