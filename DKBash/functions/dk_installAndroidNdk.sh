#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_installAndroidNdk()
#
#
dk_installAndroidNdk() {
	dk_debugFunc 0

	dk_call dk_cmakeEval "include('${DKIMPORTS_DIR}/android-ndk/DKMAKE.cmake')" "ANDROID_NDK;ANDROID_GENERATOR;ANDROID_TOOLCHAIN_FILE;ANDROID_API;ANDROID_MAKE_PROGRAM;ANDROID_C_COMPILER;ANDROID_CXX_COMPILER"
	dk_call dk_printVar ANDROID_NDK
	dk_call dk_printVar ANDROID_GENERATOR
	dk_call dk_printVar ANDROID_TOOLCHAIN_FILE
	dk_call dk_printVar ANDROID_API
	dk_call dk_printVar ANDROID_MAKE_PROGRAM
	dk_call dk_printVar ANDROID_C_COMPILER
	dk_call dk_printVar ANDROID_CXX_COMPILER
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_installAndroidNdk
}
