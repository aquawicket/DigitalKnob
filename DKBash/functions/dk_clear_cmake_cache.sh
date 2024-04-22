# dk_include_guard()

##################################################################################
# dk_clear_cmake_cache()
#
#
dk_clear_cmake_cache () {
	dk_verbose "dk_clear_cmake_cache($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	dk_info "Clearing CMake cache . . ."
	cd "$DIGITALKNOB_DIR" #|| dk_error "cd $$DIGITALKNOB_DIR failed!"
	find . -name "CMakeCache.*" -delete
	rm -rf $(find . -type d -name CMakeFiles)
}