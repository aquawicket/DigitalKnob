<?php
header('Access-Control-Allow-Origin: *');
include_once(str_replace("\\","/",$_SERVER['USERPROFILE'])."/digitalknob/Development/DKPhp/functions/DK.php");

##################################################################################
# dk_test()
#
function dk_test(){
	#dk_debugFunc 0 99
	echo "###### ".__FUNCTION__."(".implode(";", func_get_args()).") ######\n";
	
	$argv = func_get_args();
	$argv_str = implode(";", $argv);

	if(isset($test))	{	echo "                 test = $test\n";}
	if(isset($argv[0]))	{	echo "              argv[0] = $argv[0]\n";}
	if(isset($argv[1]))	{	echo "              argv[1] = $argv[1]\n";}
	if(isset($argv[2]))	{	echo "              argv[2] = $argv[2]\n";}
	if(isset($argv[3]))	{	echo "              argv[3] = $argv[3]\n";}
	if(isset($argv[4]))	{	echo "              argv[4] = $argv[4]\n";}
	if(isset($argv[5]))	{	echo "              argv[5] = $argv[5]\n";}
	if(isset($argv[6]))	{	echo "              argv[6] = $argv[6]\n";}
	if(isset($argv[7]))	{	echo "              argv[7] = $argv[7]\n";}
	if(isset($argv[8]))	{	echo "              argv[8] = $argv[8]\n";}
	if(isset($argv[9]))	{	echo "              argv[9] = $argv[9]\n";}
	if(isset($argv_str)){	echo "                 argv = $argv_str\n";}
							echo "                 time = ".time()."\n";
							echo "                 argv = ".implode(";", $argv)."\n";
							echo "             __LINE__ = ".__LINE__."\n";
							echo "             __FILE__ = ".__FILE__."\n";
							echo "              __DIR__ = ".__DIR__."\n";
							echo "         __FUNCTION__ = ".__FUNCTION__."\n";
							echo "            __CLASS__ = ".__CLASS__."\n";
							echo "            __TRAIT__ = ".__TRAIT__."\n";
							echo "           __METHOD__ = ".__METHOD__."\n";
							#echo "         __PROPERTY__ = ".__PROPERTY__."\n";
							echo "        __NAMESPACE__ = ".__NAMESPACE__."\n";

#	echo "        DKSCRIPT_PATH = ${DKSCRIPT_PATH-}\n";
#	echo "         DKSCRIPT_DIR = ${DKSCRIPT_DIR-}\n";
#	echo "        DKSCRIPT_FILE = ${DKSCRIPT_FILE-}\n";
#	echo "        DKSCRIPT_NAME = ${DKSCRIPT_NAME-}\n";
#	echo "         DKSCRIPT_EXT = ${DKSCRIPT_EXT-}\n";
#	echo "        DKSCRIPT_ARGS = ${DKSCRIPT_ARGS-}\n";
#	echo "           DKHOME_DIR = $(DKHOME_DIR)\n";
#	echo "          DKCACHE_DIR = ${DKCACHE_DIR-}\n";
#	echo "        DKDESKTOP_DIR = ${DKDESKTOP_DIR-}\n";
#	echo "          DIGITALKNOB = ${DIGITALKNOB-}\n";
#	echo "      DIGITALKNOB_DIR = ${DIGITALKNOB_DIR-}\n";
#	echo "       DKDOWNLOAD_DIR = ${DKDOWNLOAD_DIR-}\n";
#	echo "          DKTOOLS_DIR = ${DKTOOLS_DIR-}\n";
#	echo "             DKBRANCH = ${DKBRANCH-}\n";
#	echo "         DKBRANCH_DIR = ${DKBRANCH_DIR-}\n";
#	echo "       DK3RDPARTY_DIR = ${DK3RDPARTY_DIR-}\n";
#	echo "       DKCPP_APPS_DIR = ${DKCPP_APPS_DIR-}\n";
#	echo "           DKBASH_DIR = ${DKBASH_DIR-}\n";
#	echo " DKBASH_FUNCTIONS_DIR = ${DKBASH_FUNCTIONS_DIR-}\n";
#	echo "DKBASH_FUNCTIONS_DIR_ = ${DKBASH_FUNCTIONS_DIR_-}\n";

#	#dk_call setGlobal GLOBAL_VAR "This is a global variable"
#	export GLOBAL_VAR="This is a global variable"
#	#dk_call setReturn RETURN_VAR "This is a return variable"
#	export RETURN_VAR="This is a return variable"
#	
#	echo "GLOBAL_VAR = ${GLOBAL_VAR}"
#	echo "RETURN_VAR = ${RETURN_VAR}"
#	echo "? = ${?-}"
	return 0;
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function DKTEST() { 
	#dk_call dk_debugFunc 0

	dk_test("from DKTEST()", "to dk_test()");
#	echo "GLOBAL_VAR = ${GLOBAL_VAR}";
#	echo "RETURN_VAR = ${RETURN_VAR}";

#	Test/dk_test("from DKTEST()", "to Test/dk_test()");
#	echo "";
#	echo "GLOBAL_VAR = ${GLOBAL_VAR}";
#	echo "RETURN_VAR = ${RETURN_VAR}";

#	dk_call Test/Test/dk_test "from DKTEST()" "to Test/Test/dk_test()";
#	echo "";
#	echo "GLOBAL_VAR = ${GLOBAL_VAR}";
#	echo "RETURN_VAR = ${RETURN_VAR}";
}
