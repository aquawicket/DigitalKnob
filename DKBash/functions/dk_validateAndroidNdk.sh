#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_validateAndroidNdk()
#
#
dk_validateAndroidNdk () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"

	dk_cmakeEval "include('$DKIMPORTS_DIR/android-ndk/DKMAKE.cmake')" "ANDROID_NDK;ANDROID_GENERATOR;ANDROID_TOOLCHAIN_FILE;ANDROID_API;ANDROID_MAKE_PROGRAM;ANDROID_C_COMPILER;ANDROID_CXX_COMPILER"
	dk_printVar ANDROID_NDK
	dk_printVar ANDROID_GENERATOR
	dk_printVar ANDROID_TOOLCHAIN_FILE
	dk_printVar ANDROID_API
	dk_printVar ANDROID_MAKE_PROGRAM
	dk_printVar ANDROID_C_COMPILER
	dk_printVar ANDROID_CXX_COMPILER
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_validateAndroidNdk
}