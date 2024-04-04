#include_guard()

##################################################################################
# dk_function()
#
#
function dk_clear_cmake_cache() {
	dk_debug "dk_clear_cmake_cache("$@")"
	echo "Clearing CMake cache . . ."
	cd $DIGITALKNOB_DIR
	find . -name "CMakeCache.*" -delete
	rm -rf `find . -type d -name CMakeFiles`
}