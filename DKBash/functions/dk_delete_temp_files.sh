# dk_include_guard()

##################################################################################
# dk_delete_temp_files()
#
#
dk_delete_temp_files () {
	dk_verbose "dk_delete_temp_files($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"

	dk_info "Deleting .TMP files . . ."
	cd "$DIGITALKNOB_DIR" #|| dk_error "cd $$DIGITALKNOB_DIR failed!"
	rm -rf $(find . -type d -name *.tmp)
	rm -rf $(find . -type d -name *.TMP)
	find . -name "*.tmp" -delete
	find . -name "*.TMP" -delete
}