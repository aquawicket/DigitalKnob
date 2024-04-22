# dk_includeGuard()

##################################################################################
# dk_deleteTempFiles()
#
#
dk_deleteTempFiles () {
	dk_verbose "dk_deleteTempFiles($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"

	dk_info "Deleting .TMP files . . ."
	cd "$DIGITALKNOB_DIR" #|| dk_error "cd $$DIGITALKNOB_DIR failed!"
	rm -rf $(find . -type d -name *.tmp)
	rm -rf $(find . -type d -name *.TMP)
	find . -name "*.tmp" -delete
	find . -name "*.TMP" -delete
}