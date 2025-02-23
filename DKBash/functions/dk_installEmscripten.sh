#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_installEmscripten()
#
#
dk_installEmscripten() {
	dk_debugFunc 0

	dk_call dk_cmakeEval "include('${DKIMPORTS_DIR}/emsdk/DKMAKE.cmake')" "EMSDK;EMSDK_ENV;EMSDK_GENERATOR;EMSDK_TOOLCHAIN_FILE;EMSDK_C_COMPILER;EMSDK_CXX_COMPILER"
	dk_call dk_printVar EMSDK
	dk_call dk_printVar EMSDK_ENV
	dk_call dk_printVar EMSDK_GENERATOR
	dk_call dk_printVar EMSDK_TOOLCHAIN_FILE
	dk_call dk_printVar EMSDK_C_COMPILER
	dk_call dk_printVar EMSDK_CXX_COMPILER
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_installEmscripten
}
