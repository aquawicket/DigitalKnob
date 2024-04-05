# dk_include_guard()

##################################################################################
# dk_validate_gcc()
#
#
function dk_validate_gcc() {
	dk_debug "dk_validate_gcc($@)"
	cmake_eval "include('$DKIMPORTS_DIR/gcc/DKMAKE.cmake')" "GCC_C_COMPILER;GCC_CXX_COMPILER"
	print_var GCC_C_COMPILER
	print_var GCC_CXX_COMPILER
}