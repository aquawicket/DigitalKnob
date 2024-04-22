# dk_include_guard()

##################################################################################
# dk_validate_clang()
#
#
#dk_validate_clang () {
#	dk_verbose "dk_validate_clang($*)"
#	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
#
#	dk_cmake_eval "include('$DKIMPORTS_DIR/clang/DKMAKE.cmake')" "CLANG_C_COMPILER;CLANG_CXX_COMPILER"
#	dk_debug CLANG_C_COMPILER
#	dk_debug CLANG_CXX_COMPILER
#}