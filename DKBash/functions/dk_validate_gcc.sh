# dk_include_guard()

##################################################################################
# dk_validate_gcc()
#
#
#dk_validate_gcc () {
#	dk_verbose "dk_validate_gcc($*)"
#	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
#
#	dk_cmake_eval "include('$DKIMPORTS_DIR/gcc/DKMAKE.cmake')" "GCC_C_COMPILER;GCC_CXX_COMPILER"
#	dk_debug GCC_C_COMPILER
#	dk_debug GCC_CXX_COMPILER
#}