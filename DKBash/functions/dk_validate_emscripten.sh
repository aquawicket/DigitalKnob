# dk_include_guard()

##################################################################################
# dk_validate_emscripten()
#
#
#dk_validate_emscripten () {
#	dk_verbose "dk_validate_emscripten($*)"
#	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
#
#	dk_cmake_eval "include('$DKIMPORTS_DIR/emsdk/DKMAKE.cmake')" "EMSDK;EMSDK_ENV;EMSDK_GENERATOR;EMSDK_TOOLCHAIN_FILE;EMSDK_C_COMPILER;EMSDK_CXX_COMPILER"
#	dk_debug EMSDK
#	dk_debug EMSDK_ENV
#	dk_debug EMSDK_GENERATOR
#	dk_debug EMSDK_TOOLCHAIN_FILE
#	dk_debug EMSDK_C_COMPILER
#	dk_debug EMSDK_CXX_COMPILER
#}