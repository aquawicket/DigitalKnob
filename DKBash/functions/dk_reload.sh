# dk_includeGuard()

##################################################################################
# dk_reload()
#
#
dk_reload () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	dk_debug "reloading $SCRIPT_PATH"
	clear
	
	if [ -n "$(command -v bash)" ]; then
		exec /bin/bash "$SCRIPT_PATH"
	else
		exec "$SCRIPT_PATH"
	fi
}