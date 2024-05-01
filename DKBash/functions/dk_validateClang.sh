dk_includeGuard

##################################################################################
# dk_validateClang()
#
#
dk_validateClang () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"

	dk_cmakeEval "include('$DKIMPORTS_DIR/clang/DKMAKE.cmake')" "CLANG_C_COMPILER;CLANG_CXX_COMPILER"
	dk_debug CLANG_C_COMPILER
	dk_debug CLANG_CXX_COMPILER
}