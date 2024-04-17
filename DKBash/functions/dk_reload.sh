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
	
	if [ -n "$(command -v bash)" ]; then
		exec /bin/bash "$SCRIPT_DIR/$SCRIPT_NAME"
	else
		exec "$SCRIPT_DIR/$SCRIPT_NAME"
	fi
}