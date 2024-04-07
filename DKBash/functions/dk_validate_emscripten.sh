# dk_include_guard()

##################################################################################
# dk_validate_emscripten()
#
#
dk_validate_emscripten() {
	dk_debug "dk_validate_emscripten($@)"
	cmake_eval "include('$DKIMPORTS_DIR/emsdk/DKMAKE.cmake')" "EMSDK;EMSDK_ENV;EMSDK_GENERATOR;EMSDK_TOOLCHAIN_FILE;EMSDK_C_COMPILER;EMSDK_CXX_COMPILER"
	print_var EMSDK
	print_var EMSDK_ENV
	print_var EMSDK_GENERATOR
	print_var EMSDK_TOOLCHAIN_FILE
	print_var EMSDK_C_COMPILER
	print_var EMSDK_CXX_COMPILER
}