# dk_include_guard()

##################################################################################
# dk_validate_android_ndk()
#
#
dk_validate_android_ndk() {
	dk_debug "dk_validate_android_ndk($@)"
	cmake_eval "include('$DKIMPORTS_DIR/android-ndk/DKMAKE.cmake')" "ANDROID_NDK;ANDROID_GENERATOR;ANDROID_TOOLCHAIN_FILE;ANDROID_API;ANDROID_MAKE_PROGRAM;ANDROID_C_COMPILER;ANDROID_CXX_COMPILER"
	print_var ANDROID_NDK
	print_var ANDROID_GENERATOR
	print_var ANDROID_TOOLCHAIN_FILE
	print_var ANDROID_API
	print_var ANDROID_MAKE_PROGRAM
	print_var ANDROID_C_COMPILER
	print_var ANDROID_CXX_COMPILER
}