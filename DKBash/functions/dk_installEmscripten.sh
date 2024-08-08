#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_installEmscripten()
#
#
dk_installEmscripten() {
	dk_debugFunc 0


	dk_cmakeEval "include('${DKIMPORTS_DIR}/emsdk/DKMAKE.cmake')" "EMSDK;EMSDK_ENV;EMSDK_GENERATOR;EMSDK_TOOLCHAIN_FILE;EMSDK_C_COMPILER;EMSDK_CXX_COMPILER"
	dk_printVar EMSDK
	dk_printVar EMSDK_ENV
	dk_printVar EMSDK_GENERATOR
	dk_printVar EMSDK_TOOLCHAIN_FILE
	dk_printVar EMSDK_C_COMPILER
	dk_printVar EMSDK_CXX_COMPILER
}



DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######

	dk_installEmscripten
}