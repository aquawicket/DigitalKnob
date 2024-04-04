#include_guard()

##################################################################################
# dk_validate_clang()
#
#
function dk_validate_clang() {
	dk_debug "dk_validate_clang("$@")"
	cmake_eval "include('$DKIMPORTS_DIR/clang/DKMAKE.cmake')" "CLANG_C_COMPILER;CLANG_CXX_COMPILER"
	print_var CLANG_C_COMPILER
	print_var CLANG_CXX_COMPILER
}