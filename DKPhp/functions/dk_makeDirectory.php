<?php

####################################################################
# dk_makeDirectory(path)
#
#
function dk_makeDirectory() {
    #dk_debugFunc(1);

	if(!isset($argv)){
		$argv = func_get_args();
	}
	
	$_path_=$argv[0];
    if(file_exists("$_path_")) {
		dk_warning("$_path_ already exists");
		return 0;
	}
	
    mkdir("$_path_");
}












###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc 0

    dk_makeDirectory("CreatedDirectory");
}}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");
?>
