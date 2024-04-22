# dk_includeGuard()

##################################################################################
# dk_validateAndroidNdk()
#
#
#dk_validateAndroidNdk () {
#	dk_verbose "dk_validateAndroidNdk($*)"
#	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
#
#	dk_cmakeEval "include('$DKIMPORTS_DIR/android-ndk/DKMAKE.cmake')" "ANDROID_NDK;ANDROID_GENERATOR;ANDROID_TOOLCHAIN_FILE;ANDROID_API;ANDROID_MAKE_PROGRAM;ANDROID_C_COMPILER;ANDROID_CXX_COMPILER"
#	dk_debug ANDROID_NDK
#	dk_debug ANDROID_GENERATOR
#	dk_debug ANDROID_TOOLCHAIN_FILE
#	dk_debug ANDROID_API
#	dk_debug ANDROID_MAKE_PROGRAM
#	dk_debug ANDROID_C_COMPILER
#	dk_debug ANDROID_CXX_COMPILER
#}