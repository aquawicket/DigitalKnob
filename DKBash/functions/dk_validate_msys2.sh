# dk_include_guard()

##################################################################################
# dk_validate_msys2()
#
#
#dk_validate_msys2 () {
#	dk_verbose "dk_validate_msys2($*)"
#	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
#
#	dk_cmake_eval "include('$DKIMPORTS_DIR/msys2/DKMAKE.cmake')" "MSYS2"
#	dk_debug MSYS2
#}