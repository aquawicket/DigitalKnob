<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

##################################################################################
# dk_installClang()
#
#
dk_installClang() {
	dk_debugFunc 0

<<<<<<< HEAD
	dk_call dk_cmakeEval "include('${DKIMPORTS_DIR}/clang/DKMAKE.cmake')" "CLANG_C_COMPILER;CLANG_CXX_COMPILER"
=======
	dk_call dk_cmakeEval "include('${DKIMPORTS_DIR}/clang/DKINSTALL.cmake')" "CLANG_C_COMPILER;CLANG_CXX_COMPILER"
>>>>>>> Development
	dk_call dk_printVar CLANG_C_COMPILER
	dk_call dk_printVar CLANG_CXX_COMPILER
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_installClang
}
