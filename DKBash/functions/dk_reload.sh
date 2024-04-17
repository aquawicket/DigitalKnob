# dk_include_guard()

##################################################################################
# dk_reload()
#
#
dk_reload () {
	dk_verbose "dk_reload($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	dk_debug "reloading $SCRIPT_DIR/$SCRIPT_NAME"
	clear
	exec "$SCRIPT_DIR/$SCRIPT_NAME"
}