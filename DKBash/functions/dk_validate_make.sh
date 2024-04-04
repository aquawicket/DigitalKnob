#include_guard()

##################################################################################
# dk_validate_make()
#
#
function dk_validate_make() {
	dk_debug "dk_validate_make("$@")"
	cmake_eval "include('$DKIMPORTS_DIR/make/DKMAKE.cmake')" "MAKE_PROGRAM"
	print_var MAKE_PROGRAM
}