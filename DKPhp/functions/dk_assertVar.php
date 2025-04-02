<?php

##################################################################################
# dk_assertVar()
#
function dk_assertVar() {
	if(!isset($argv)){
		$argv = func_get_args();
	}
	
    if (isset($argv[0])) {
		return 0;
    }
	
	echo "dk_fatal(ASSERTION: dk_assertVar(): variable not defined)\n";
	return -1;
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(!function_exists('DKTEST')){ function DKTEST() {
	#dk_debugFunc 0

	$testVar = "abc123";
	dk_assertVar($testVar);
	dk_assertVar("testVar");
	dk_assertVar($nonexistent);
}}


include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");
?>
