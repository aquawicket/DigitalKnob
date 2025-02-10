#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# Test/dk_test(args)
#
#Test/dk_test() {
dk_test() {
    #dk_debugFunc 0 99
    
    echo "################ Test/dk_test.sh ################"
    echo "                    0 = ${0-}"
	echo "                    1 = ${1-}"
	echo "                    2 = ${2-}"
	echo "                    3 = ${3-}"
	echo "                    4 = ${4-}"
	echo "                    5 = ${5-}"
	echo "                    6 = ${6-}"
	echo "                    7 = ${7-}"
	echo "                    8 = ${8-}"
	echo "                    9 = ${9-}"
    echo "                    * = ${*-}"
	echo "                    ? = ${?-}"
    echo "             __TIME__ = $(__TIME__)"
    echo "           __CALLER__ = $(__CALLER__)"
    echo "             __FILE__ = $(__FILE__)"
    echo "             __LINE__ = $(__LINE__)"
    echo "         __FUNCTION__ = $(__FUNCTION__ 1)"
    echo "             __ARGC__ = $(__ARGC__ 1)"
    echo "             __ARGV__ = $(__ARGV__ 1)"
    echo "        DKSCRIPT_PATH = ${DKSCRIPT_PATH-}"
    echo "         DKSCRIPT_DIR = ${DKSCRIPT_DIR-}"
    echo "        DKSCRIPT_FILE = ${DKSCRIPT_FILE-}"
    echo "        DKSCRIPT_NAME = ${DKSCRIPT_NAME-}"
    echo "         DKSCRIPT_EXT = ${DKSCRIPT_EXT-}"
    echo "        DKSCRIPT_ARGS = ${DKSCRIPT_ARGS-}"
    echo "           DKHOME_DIR = ${DKHOME_DIR-}"
    echo "          DKCACHE_DIR = ${DKCACHE_DIR-}"
    echo "        DKDESKTOP_DIR = ${DKDESKTOP_DIR-}"
    echo "          DIGITALKNOB = ${DIGITALKNOB-}"
    echo "      DIGITALKNOB_DIR = ${DIGITALKNOB_DIR-}"
    echo "       DKDOWNLOAD_DIR = ${DKDOWNLOAD_DIR-}"
    echo "          DKTOOLS_DIR = ${DKTOOLS_DIR-}"
    echo "             DKBRANCH = ${DKBRANCH-}"
    echo "         DKBRANCH_DIR = ${DKBRANCH_DIR-}"
    echo "       DK3RDPARTY_DIR = ${DK3RDPARTY_DIR-}"
    echo "           DKAPPS_DIR = ${DKAPPS_DIR-}"
    echo "           DKBASH_DIR = ${DKBASH_DIR-}"
    echo " DKBASH_FUNCTIONS_DIR = ${DKBASH_FUNCTIONS_DIR-}"
    echo "DKBASH_FUNCTIONS_DIR_ = ${DKBASH_FUNCTIONS_DIR_-}"
    
	#dk_call setGlobal GLOBAL_VAR "This is a global variable"
	export GLOBAL_VAR="This is a global variable"
	#dk_call setReturn RETURN_VAR "This is a return variable"
	export RETURN_VAR="This is a return variable"
	
	echo "GLOBAL_VAR = ${GLOBAL_VAR}"
	echo "RETURN_VAR = ${RETURN_VAR}"
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
    #dk_call dk_debugFunc 0

    dk_call dk_test "from Test/DKTEST()" "to dk_test"
	echo ""
	echo "GLOBAL_VAR = ${GLOBAL_VAR}"
	echo "RETURN_VAR = ${RETURN_VAR}"
	
	dk_call Test/dk_test "from Test/DKTEST()" "to Test/dk_test"
	echo ""
	echo "GLOBAL_VAR = ${GLOBAL_VAR}"
	echo "RETURN_VAR = ${RETURN_VAR}"
	
#	dk_call Test::Test::dk_test "from Test/DKTEST" "to Test/Test/dk_test"
#	echo ""
#	echo "GLOBAL_VAR = ${GLOBAL_VAR}"
#	echo "RETURN_VAR = ${RETURN_VAR}"
}
