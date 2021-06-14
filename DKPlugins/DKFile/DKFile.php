<?php
header('Access-Control-Allow-Origin: *');
include("../DK/DK.php");

// Base PHP File Functions
function ValidatePath($path){
	//echo "php.ValidatePath(".$path.")\n";
	//if($path && $path[0] === "/"){
		//echo $path."  path has / as the first character \n";
	//	$path = str_replace("/", "", $path, 1);
		//echo "AFTER: ".$path."\n";
	//}
    if(str_contains($path, "\\")){
        //echo $path."  path contains \\ \n";
    	$path = str_replace("\\", "/", $path);
    	//echo "AFTER: ".$path."\n";
    }
	if(!str_contains($path, "://") && (substr_count($path, "//") > 0)){
		//echo $path."  path contains // seperator\n";
		$path = str_replace("//", "/", $path);
		//echo "AFTER: ".$path."\n";
	}
	if(str_contains($path, "://") && (substr_count($path, "//") > 1)){
		//echo $path."  path contains // seperator\n";
		$path = str_replace("//", "/", $path);
		$path = str_replace(":/", "://", $path);
		//echo "AFTER: ".$path."\n";
	}
	if(is_dir($path) && substr($path, -1) !== "/"){
		//echo $path." path is dirctory without trailing / \n";
		$path = $path."/";
		//echo "AFTER: ".$path."\n";
	}
	return $path;
}

// https://www.php.net/manual/en/function.unlink.php
function delete($path){
	$path = ValidatePath($path);
	return unlink($path);
}

// https://www.php.net/manual/en/function.file-exists.php
function exists($path){
	$path = ValidatePath($path);
	return file_exists($path);
}

// https://www.php.net/manual/en/function.is-dir
function isDir($path){
	$path = ValidatePath($path);
	return is_dir($path);
}

// https://www.php.net/manual/en/function.mkdir.php
function makeDir($path, $mode = 0777, $recursive = false){
	$path = ValidatePath($path);
    if(!mkdir($path, $mode, $recursive))
        return false;
    return true;
}

// https://www.php.net/manual/en/function.file-get-contents.php
function fileToString($path, $use_include_path = false){
	$path = ValidatePath($path);    
    $str = file_get_contents($path, $use_include_path);
    if($str === false)
    	return error("fileToString() failed");
    return $str;
}

// https://www.php.net/manual/en/function.file-put-contents.php
function stringToFile($path, $data, $flags = 0){
	$path = ValidatePath($path);
    if($flags === "FILE_APPEND"){ $flags = FILE_APPEND; }
    if($flags === "FILE_USE_INCLUDE_PATH"){ $flags = FILE_USE_INCLUDE_PATH; }
    if($flags === "LOCK_EX"){ $flags = LOCK_EX; }
    $bytes = file_put_contents($path, $data, $flags);
    //$data = binaryToString($data);
    //$ptr = fopen($path, 'wb');
    //$bytes = fwrite($ptr, $data);
    //fclose($ptr);
    if($bytes === false)
        return error("stringToFile(): failed\n");
    return $bytes;
}

function getPath($path){
	if(!$path || $path === "/" || $path === ".")
	    $path = getRootPath();
	$path = realpath($path);
    return ValidatePath($path);
}

function getAbsolutePath($path){
	$path = ValidatePath($path);
	$root = getRootPath();
	$rPath = getRelativePath($path);
	$aPath = realpath($root.$rPath);
	return ValidatePath($aPath);
}

function getRootPath(){
	$root = dirname(__FILE__, 2)."/";
	return ValidatePath($root);
}

function getRelativePath($path){
	$root = getRootPath();
	$rPath = relativePath($root, $path);
	//$rPath = "none";
	return ValidatePath($rPath);
}

/**
 * Return relative path between two sources
 * @param $from
 * @param $to
 * @param string $separator
 * @return string
 */
function relativePath($from, $to, $separator = DIRECTORY_SEPARATOR){
    $from   = str_replace(array('/', '\\'), $separator, $from);
    $to     = str_replace(array('/', '\\'), $separator, $to);

    $arFrom = explode($separator, rtrim($from, $separator));
    $arTo = explode($separator, rtrim($to, $separator));
    while(count($arFrom) && count($arTo) && ($arFrom[0] == $arTo[0]))
    {
        array_shift($arFrom);
        array_shift($arTo);
    }

    return str_pad("", count($arFrom) * 3, '..'.$separator).implode($separator, $arTo);
}

function directoryContents($path){
	//echo "php.directoryContents(".$path.")\n";
	$path = ValidatePath($path);
	$directory = opendir($path);
	$folders = [];
	$files = [];
	while($entryName = readdir($directory)){
		if(filetype($path.$entryName) == "dir")
		    $folders[] = $entryName;
		else
			$files[] = $entryName;
	}
	closedir($directory);
	
	//sort in alpha order with folders on top
	if($folders)
	    natcasesort($folders);	
	if($files)
	    natcasesort($files);
	$final = array_merge ($folders, $files);
	return implode(",", $final);
}

// https://stackoverflow.com/a/18850550/688352
function compareFiles($file_a, $file_b){

	if(filesize($file1) !== filesize($file2)) return false;
    if(sha1_file($file1) == sha1_file($file2)) return true;
    return false;

    /*
	if (filesize($file_a) == filesize($file_b)){
        $fp_a = fopen($file_a, 'rb');
        $fp_b = fopen($file_b, 'rb');
        while (!feof($fp_a) && ($b = fread($fp_a, 4096)) !== false){
            $b_b = fread($fp_b, 4096);
            if ($b !== $b_b){
                fclose($fp_a);
                fclose($fp_b);
                return false;
            }
        }
        fclose($fp_a);
        fclose($fp_b);
        return true;
    }
    return false;
    */
}







///////////////////////////////////////////////////
// digitalknob specific functions
// Get DK Paths
function getPaths($path){
	$path = getPath($path);
	$aPath = getAbsolutePath($path);
	$root = getRootPath();
	$rPath = getRelativePath($aPath);
	$realpath = realpath($aPath);
	$realpath = ValidatePath($realpath);
	$pathParts = pathinfo($aPath);
	$dir = $pathParts['dirname'];
	$dir = ValidatePath($dir);
    $basename = $pathParts['basename'];
    $extension = "";
    if(isset($pathParts['extension']))
        $extension = $pathParts['extension'];
    $filename = $pathParts['filename'];
    $arr = array(
        "path" => $path,
        "aPath" => $aPath,
        "root" => $root,
        "rPath" => $rPath,
        "realpath" => $realpath,
        "dir" => $dir,
        "basename" => $basename,
        "extention" => $extension,
        "filename" => $filename,    
    );
    //return json_encode($arr);
	return $path.",".$aPath.",".$root.",".$rPath.",".$realpath.",".$dir.",".$basename.",".$extension.",".$filename;
}

function getAssetsPath(){
    $assetsPath = dirname(__DIR__)."/";
    //if(basename($assetsPath) != "assets")
        //return error("assetsPath does not contain an assets folder \n");
    if(!is_dir($assetsPath))
    	return error("assetsPath is an invalid directory \n");
    $assetsPath = str_replace("\\", "/", $assetsPath);
    $assetsPath = ValidatePath($assetsPath);
    //echo "assetsPath = ".$assetsPath."\n";
    return $assetsPath;
}

function getDKPath(){
    $dkPath = dirname(__DIR__)."/";
    $n = 1;
    while(is_dir($dkPath) && $n < 10){
        $dkPath = dirname(__DIR__, $n++);
        if(basename($dkPath) === "digitalknob"){
            $dkPath = ValidatePath($dkPath);
            echo "dkPath = ".$dkPath."\n";
        	return $dkPath;
        }
    }
    //Try defaults
    if(file_exists("C:/Users/aquawicket/digitalknob/")){
    	$dkPath = "C:/Users/aquawicket/digitalknob/";
    	$dkPath = ValidatePath($dkPath);
    	echo "dkPath = ".$dkPath."\n";
    	return $dkPath;
    }
    return error("could not find digitalknob path \n");
}

function getDKPluginsPath(){
    $dkPath = getDKPath();
	$dkPluginsPath = $dkPath."DK/DKPlugins/";
    if(!$dkPluginsPath)
        return error("dkPluginsPath invalid");
    $dkPluginsPath = ValidatePath($dkPluginsPath);
    echo "dkPluginsPath = ".$dkPluginsPath."\n";
    return $dkPluginsPath;
}

function getRelativeDKPluginsPath(){
    $relativeDKPluginsPath = dirname(__DIR__)."/";
    $n = 1;
    while(is_dir($relativeDKPluginsPath) && $n < 10){
        $relativeDKPluginsPath = dirname(__DIR__, $n++)."/";
        if(is_dir($relativeDKPluginsPath."DKPlugins/")){
        	$relativeDKPluginsPath = $relativeDKPluginsPath."DKPlugins/";
        	$relativeDKPluginsPath = ValidatePath($relativeDKPluginsPath);
        	echo "relativeDKPluginsPath = ".$relativeDKPluginsPath."\n";
        	return $relativeDKPluginsPath;
        }
    }
    //FIXME: temporarily using raw user defaults paths
    if(file_exists("C:/Users/aquawicket/digitalknob/DKTasmota/DKPlugins/")){
    	$relativeDKPluginsPath = "C:/Users/aquawicket/digitalknob/DKTasmota/DKPlugins/";
    	$relativeDKPluginsPath = ValidatePath($relativeDKPluginsPath);
    	echo "relativeDKPluginsPath = ".$relativeDKPluginsPath."\n";
    	return $relativeDKPluginsPath;
    }
    return error("cound not find realative DKPlugins path");
}

function getDKAppAssetsPath(){
    //FIXME: temporarily using raw user defaults paths
    if(file_exists("C:/Users/aquawicket/digitalknob/DKTasmota/DKApps/DKTasmota/assets/")){
    	$dkAppAssetsPath = "";
    	$dkAppAssetsPath = "C:/Users/aquawicket/digitalknob/DKTasmota/DKApps/DKTasmota/assets/";
    	$dkAppAssetsPath = ValidatePath($dkAppAssetsPath);
    	echo "dkAppsAssetsPath = ".$dkAppAssetsPath."\n";
    	return $dkAppAssetsPath;
    }
	return error("cound not find DKApp path");
}

function pushDKAssets(){
	$ignoreFolders = array("USER");
    $ignoreFiles = array("*.h","*.cpp","*/DKCMake.txt");
    $filemap = [];

    //Fist get all of the paths
	$assetsPath = getAssetsPath();
    $dkPluginsPath = getDKPluginsPath();
    //we may or may not have a second plugins path
    $dkPluginsPath2 = getRelativeDKPluginsPath();
    $dkAppAssetsPath = getDKAppAssetsPath();

    //Now copy matching folders to the DKPlugins path(s)
	$assetsList = scandir($assetsPath);
	//remove all Folders and Files on the ignore list    
    $assetsList = array_values(array_diff($assetsList, $ignoreFolders));
    $assetsList = array_values(array_diff($assetsList, $ignoreFiles));

	for($n = 2; $n < count($assetsList); $n++){
		if(!is_dir($assetsPath.$assetsList[$n])){
			if($assetsPath != $dkAppAssetsPath){
		        $filesrc = $assetsPath.$assetsList[$n];
                
		        $skip = false;
                foreach ($ignoreFiles as $item) {
			        if(fnmatch($item, $filesrc)){
					    //skip if $src matches the ignore list
					    $skip = true;
					    echo "IGNORING: ".$src."\n";
					    break;
			        }
                }
                if($skip)
                    continue;

		        //echo "filesrc = ".$filesrc."\n";
		        $filedest = $dkAppAssetsPath.$assetsList[$n];
		        //echo "filedest = ".$filedest."\n";
		        $files_map[$filesrc]=$filedest; //unused
		        if (!copy($filesrc, $filedest))
                    echo "FAILED to copy $filesrc\n";
                else
                	echo "copied to $filedest\n";
	        }
		    continue;
		}
		$assetFolder = $assetsPath.$assetsList[$n]."/";
		$assetFiles = scandir($assetFolder);

        for($nn = 2; $nn < count($assetFiles); $nn++){
            if(is_dir($assetFolder.$assetFiles[$nn])) 
                continue;
            $src = $assetFolder.$assetFiles[$nn];
            
            $skip = false;
            foreach ($ignoreFiles as $item) {
			    if(fnmatch($item, $src)){
					//skip if $src matches the ignore list
					$skip = true;
					echo "IGNORING: ".$src."\n";
					break;
			    }
            }
            if($skip)
                continue;

            //echo "src = ".$src."\n";
            if(is_dir($dkPluginsPath.$assetsList[$n])){
            	$dest = $dkPluginsPath.$assetsList[$n]."/".$assetFiles[$nn];
            	//echo "dest = ".$dest."\n";
            	$filemap[$src]=$dest; //unused
			    if (!copy($src, $dest))
                    echo "FAILED to copy $src\n";
                else
                	echo "copied to $dest\n";
		    }
		    if($dkPluginsPath2 && is_dir($dkPluginsPath2.$assetsList[$n])){
			    $dest = $dkPluginsPath2.$assetsList[$n]."/".$assetFiles[$nn];
			    //echo "dest = ".$dest."\n";
			    $filemap[$src]=$dest; //unused
			    if (!copy($src, $dest))
                    echo "failed to copy $src\n";
                else
                	echo "copied to $dest\n";
		    }
        }
	}

	//echo "\n***** filemap ***\n";
	//echo json_encode($filemap); 
	//return json_encode($filemap);
	return true;
}

function pullDKAssets(){
	$ignoreFolders = array(".","..");
    $ignoreFiles = array("*.h","*.cpp","*/DKCMake.txt");

    //Fist get all of the paths
	$assetsPath = getAssetsPath();
    $dkPluginsPath = getDKPluginsPath();
    //we may or may not have a second plugins path
    $dkPluginsPath2 = getRelativeDKPluginsPath();
    $dkAppAssetsPath = getDKAppAssetsPath();
    
    if($assetsPath != $dkAppAssetsPath){
    	$dkAppAssetsPathList = scandir($dkAppAssetsPath);
    	for($n = 2; $n < count($dkAppAssetsPathList); $n++){
			if(!is_dir($dkAppAssetsPath.$dkAppAssetsPathList[$n])){
				$filesrc = $dkAppAssetsPath.$dkAppAssetsPathList[$n];
				$filedest = $assetsPath.$dkAppAssetsPathList[$n];
				if (!copy($filesrc, $filedest))
					echo "FAILED to copy $filesrc\n";
				else
					echo "copied to $filedest\n";
			}
		}
	}

    $dkPluginsList = scandir($dkPluginsPath);
    if($dkPluginsPath2){
        $dkPluginsList2 = scandir($dkPluginsPath2);
        $dkPluginsList = array_merge($dkPluginsList, $dkPluginsList2);
    }

    //remove all Folders on the ignore list    
    $dkPluginsList = array_values(array_diff($dkPluginsList, $ignoreFolders));

    for($n = 0; $n < count($dkPluginsList); $n++){
		if(is_dir($dkPluginsPath.$dkPluginsList[$n]))
			$dkPluginsFolder = $dkPluginsPath.$dkPluginsList[$n]."/";
		else if(is_dir($dkPluginsPath2.$dkPluginsList[$n]))
			$dkPluginsFolder = $dkPluginsPath2.$dkPluginsList[$n]."/";
		else
			continue;
		
        $dkPluginsFiles = scandir($dkPluginsFolder);
        for($nn = 0; $nn < count($dkPluginsFiles); $nn++){
            if(is_dir($dkPluginsFolder.$dkPluginsFiles[$nn])) 
                continue; 
            $src = $dkPluginsFolder.$dkPluginsFiles[$nn];
            
            $skip = false;
            foreach ($ignoreFiles as $item) {
			    if(fnmatch($item, $src)){
					//skip if $src matches the ignore list
					$skip = true;
					echo "IGNORING: ".$src."\n";
					break;
			    }
            }
            if($skip)
                continue;

            if(is_dir($assetsPath.$dkPluginsList[$n])){
                $dest = $assetsPath.$dkPluginsList[$n]."/".$dkPluginsFiles[$nn];
			    //echo $src."->".$dest."\n";
    	        if (!copy($src, $dest))
                    echo "FAILED to copy: $src\n";
                else
                    echo "copied to $dest\n";
		     }
        }
    }
    return true;
}


///// Old functions

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