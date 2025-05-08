#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_test(args)
#
dk_test() {
	#dk_debugFunc 0 99
	
	echo "################ dk_test.sh ################"
	echo "                       test = ${test-}"
	echo "                          0 = ${0-}"
	echo "                          1 = ${1-}"
	echo "                          2 = ${2-}"
	echo "                          3 = ${3-}"
	echo "                          4 = ${4-}"
	echo "                          5 = ${5-}"
	echo "                          6 = ${6-}"
	echo "                          7 = ${7-}"
	echo "                          8 = ${8-}"
	echo "                          9 = ${9-}"
	echo "                          * = ${*-}"
	echo "                          ? = ${?-}"
	echo "                   __TIME__ = $(__TIME__)"
	echo "                 __CALLER__ = $(__CALLER__)"
	echo "                   __FILE__ = $(__FILE__)"
	echo "                   __LINE__ = $(__LINE__)"
	echo "               __FUNCTION__ = $(__FUNCTION__ 1)"
	echo "                   __ARGC__ = $(__ARGC__ 1)"
	echo "                   __ARGV__ = $(__ARGV__ 1)"
	echo "              DKSCRIPT_PATH = ${DKSCRIPT_PATH-}"
	echo "               DKSCRIPT_DIR = ${DKSCRIPT_DIR-}"
	echo "              DKSCRIPT_FILE = ${DKSCRIPT_FILE-}"
	echo "              DKSCRIPT_NAME = ${DKSCRIPT_NAME-}"
	echo "               DKSCRIPT_EXT = ${DKSCRIPT_EXT-}"
	echo "              DKSCRIPT_ARGS = ${DKSCRIPT_ARGS-}"
	echo "                 DKHOME_DIR = $(dk_call dk_DKHOME_DIR)"
	echo "                DKCACHE_DIR = ${DKCACHE_DIR-}"
	echo "              DKDESKTOP_DIR = ${DKDESKTOP_DIR-}"
	echo "                DIGITALKNOB = ${DIGITALKNOB-}"
	echo "            DIGITALKNOB_DIR = ${DIGITALKNOB_DIR-}"
	echo "             DKDOWNLOAD_DIR = ${DKDOWNLOAD_DIR-}"
	echo "                DKTOOLS_DIR = ${DKTOOLS_DIR-}"
	echo "                   DKBRANCH = ${DKBRANCH-}"
	echo "               DKBRANCH_DIR = ${DKBRANCH_DIR-}"
	echo "             DK3RDPARTY_DIR = ${DK3RDPARTY_DIR-}"
	echo "             DKCPP_APPS_DIR = ${DKCPP_APPS_DIR-}"
	echo "                 DKBASH_DIR = ${DKBASH_DIR-}"
	echo "       DKBASH_FUNCTIONS_DIR = ${DKBASH_FUNCTIONS_DIR-}"
	echo "      DKBASH_FUNCTIONS_DIR_ = ${DKBASH_FUNCTIONS_DIR_-}"
	echo "                DKBATCH_DIR = ${DKBATCH_DIR-}"
	echo "      DKBATCH_FUNCTIONS_DIR = ${DKBATCH_FUNCTIONS_DIR-}"
	echo "     DKBATCH_FUNCTIONS_DIR_ = ${DKBATCH_FUNCTIONS_DIR_-}"
	echo "                    DKC_DIR = ${DKC_DIR-}"
	echo "          DKC_FUNCTIONS_DIR = ${DKC_FUNCTIONS_DIR-}"
	echo "         DKC_FUNCTIONS_DIR_ = ${DKC_FUNCTIONS_DIR_-}"
	echo "                DKCMAKE_DIR = ${DKCMAKE_DIR-}"
	echo "      DKCMAKE_FUNCTIONS_DIR = ${DKCMAKE_FUNCTIONS_DIR-}"
	echo "     DKCMAKE_FUNCTIONS_DIR_ = ${DKCMAKE_FUNCTIONS_DIR_-}"
	echo "                  DKCPP_DIR = ${DKCPP_DIR-}"
	echo "        DKCPP_FUNCTIONS_DIR = ${DKCPP_FUNCTIONS_DIR-}"
	echo "       DKCPP_FUNCTIONS_DIR_ = ${DKCPP_FUNCTIONS_DIR_-}"
	echo "               DKCSHARP_DIR = ${DKCSHARP_DIR-}"
	echo "     DKCSHARP_FUNCTIONS_DIR = ${DKCSHARP_FUNCTIONS_DIR-}"
	echo "    DKCSHARP_FUNCTIONS_DIR_ = ${DKCSHARP_FUNCTIONS_DIR_-}"
	echo "                  DKHTA_DIR = ${DKHTA_DIR-}"
	echo "        DKHTA_FUNCTIONS_DIR = ${DKHTA_FUNCTIONS_DIR-}"
	echo "       DKHTA_FUNCTIONS_DIR_ = ${DKHTA_FUNCTIONS_DIR_-}"
	echo "                 DKHTML_DIR = ${DKHTML_DIR-}"
	echo "       DKHTML_FUNCTIONS_DIR = ${DKHTML_FUNCTIONS_DIR-}"
	echo "      DKHTML_FUNCTIONS_DIR_ = ${DKHTML_FUNCTIONS_DIR_-}"
	echo "                 DKJAVA_DIR = ${DKJAVA_DIR-}"
	echo "       DKJAVA_FUNCTIONS_DIR = ${DKJAVA_FUNCTIONS_DIR-}"
	echo "      DKJAVA_FUNCTIONS_DIR_ = ${DKJAVA_FUNCTIONS_DIR_-}"
	echo "           DKJAVASCRIPT_DIR = ${DKJAVASCRIPT_DIR-}"
	echo " DKJAVASCRIPT_FUNCTIONS_DIR = ${DKJAVASCRIPT_FUNCTIONS_DIR-}"
	echo "DKJAVASCRIPT_FUNCTIONS_DIR_ = ${DKJAVASCRIPT_FUNCTIONS_DIR_-}"
	echo "                  DKPHP_DIR = ${DKPHP_DIR-}"
	echo "        DKPHP_FUNCTIONS_DIR = ${DKPHP_FUNCTIONS_DIR-}"
	echo "       DKPHP_FUNCTIONS_DIR_ = ${DKPHP_FUNCTIONS_DIR_-}"
	echo "           DKPOWERSHELL_DIR = ${DKPOWERSHELL_DIR-}"
	echo " DKPOWERSHELL_FUNCTIONS_DIR = ${DKPOWERSHELL_FUNCTIONS_DIR-}"
	echo "DKPOWERSHELL_FUNCTIONS_DIR_ = ${DKPOWERSHELL_FUNCTIONS_DIR_-}"
	echo "               DKPYTHON_DIR = ${DKPYTHON_DIR-}"
	echo "     DKPYTHON_FUNCTIONS_DIR = ${DKPYTHON_FUNCTIONS_DIR-}"
	echo "    DKPYTHON_FUNCTIONS_DIR_ = ${DKPYTHON_FUNCTIONS_DIR_-}"
	echo "                   DKVB_DIR = ${DKVB_DIR-}"
	echo "         DKVB_FUNCTIONS_DIR = ${DKVB_FUNCTIONS_DIR-}"
	echo "        DKVB_FUNCTIONS_DIR_ = ${DKVB_FUNCTIONS_DIR_-}"

	#dk_call setGlobal GLOBAL_VAR "This is a global variable"
	export GLOBAL_VAR="This is a global variable"
	#dk_call setReturn RETURN_VAR "This is a return variable"
	export RETURN_VAR="This is a return variable"

	echo "GLOBAL_VAR = ${GLOBAL_VAR}"
	echo "RETURN_VAR = ${RETURN_VAR}"
	echo "? = ${?-}"
	return 0
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	#dk_call dk_debugFunc 0

	dk_call dk_test "from DKTEST()" "to dk_test()"
	echo ""
	echo "GLOBAL_VAR = ${GLOBAL_VAR}"
	echo "RETURN_VAR = ${RETURN_VAR}"

	dk_call Test/dk_test "from DKTEST()" "to Test/dk_test()"
	echo ""
	echo "GLOBAL_VAR = ${GLOBAL_VAR}"
	echo "RETURN_VAR = ${RETURN_VAR}"

#	dk_call Test/Test/dk_test "from DKTEST()" "to Test/Test/dk_test()"
#	echo ""
#	echo "GLOBAL_VAR = ${GLOBAL_VAR}"
#	echo "RETURN_VAR = ${RETURN_VAR}"
}
