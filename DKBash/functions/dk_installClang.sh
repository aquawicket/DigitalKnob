#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_installClang()
#
#
dk_installClang() {
	dk_debugFunc 0

	dk_call dk_cmakeEval "include('${DKIMPORTS_DIR}/clang/DKINSTALL.cmake')" "CLANG_C_COMPILER;CLANG_CXX_COMPILER"
	dk_call dk_printVar CLANG_C_COMPILER
	dk_call dk_printVar CLANG_CXX_COMPILER
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_installClang
}
