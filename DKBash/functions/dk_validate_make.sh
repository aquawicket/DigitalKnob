# dk_include_guard()

##################################################################################
# dk_validate_make()
#
#
#dk_validate_make () {
#	dk_verbose "dk_validate_make($*)"
#	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
#
#	dk_cmake_eval "include('$DKIMPORTS_DIR/make/DKMAKE.cmake')" "MAKE_PROGRAM"
#	dk_debug MAKE_PROGRAM
#}