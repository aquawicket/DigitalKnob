# dk_include_guard()

##################################################################################
# dk_validate_msys2()
#
#
function dk_validate_msys2() {
	dk_debug "dk_validate_msys2($@)"
	dk_cmake_eval "include('$DKIMPORTS_DIR/msys2/DKMAKE.cmake')" "MSYS2"
	dk_print_var MSYS2
}