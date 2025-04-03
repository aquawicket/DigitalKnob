<?php

##################################################################################
# dk_copy(from, to)
#
# copy a file or directory to another location
#
# @from       - The source path to copy
# @to         - The destination path to copy to
# OVERWRITE   - if any of the parameters equals OVERWRITE, overwritting existing file or folder is enabled
#
function dk_copy() {
	#dk_debugFunc(2, 3);
	include_once(str_replace("\\", "/", $_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/dk_info.php");
	include_once(str_replace("\\", "/", $_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/dk_warning.php");
	include_once(str_replace("\\", "/", $_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/dk_error.php");
	include_once(str_replace("\\", "/", $_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/dk_dirname.php");
	include_once(str_replace("\\", "/", $_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/dk_makeDirectory.php");
	
	if(!isset($argv)){
		$argv = func_get_args();
	}
	
	$_from_="$argv[0]";	
	$_to_="$argv[1]";
	if($argv[2] == "OVERWRITE"){
		$OVERWRITE=1;
	} else {
		$OVERWRITE=0;
	}

	dk_info("Copying $_from_ to $_to_\n");

	if(!file_exists("$_from_")){
		dk_error("dk_copy:'$_from_' not found\n");
	}

	if(file_exists("$_to_")){
		if($OVERWRITE != 1) {
			dk_error("dk_copy Cannot copy file. Destiantion already exists and OVERWRITE is not set\n");
		}
#		dk_delete($_to_);
	}

	# the base directory of the %$_to_ path must exist.    
	$dk_dirname = dk_dirname("$_to_");
	if(!file_exists("$dk_dirname")){
		dk_makeDirectory("$dk_dirname");
	}

	copy($argv[0], $argv[1]);
	
	if(!file_exists("$argv[1]")){
		include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/dk_fatal.php");
		dk_fatal("dk_copy failed: %_to_% does not exist\n");
	}
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc 0
	
	dk_copy("C:/test.txt", "C:/Windows/test.txt", "OVERWRITE");
	
#	dk_validate($DKCACHE_DIR, "dk_DKCACHE_DIR");

#	dk_fileWrite("$DKCACHE_DIR/copyMe.file", "dk_copy test");
#	dk_copy("$DKCACHE_DIR/copyMe.file", "$DKCACHE_DIR/iWasCopied.txt", "OVERWRITE");

#	dk_makeDirectory("%DKCACHE_DIR%/copyMe");
#	dk_copy("$DKCACHE_DIR/copyMe", "$DKCACHE_DIR/iWasCopied", OVERWRITE);
}}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");
?>
