# dk_include_guard()

##################################################################################
# dk_validate_make()
#
#
dk_validate_make() {
	dk_debug "dk_validate_make($@)"
	dk_cmake_eval "include('$DKIMPORTS_DIR/make/DKMAKE.cmake')" "MAKE_PROGRAM"
	dk_print_var MAKE_PROGRAM
}