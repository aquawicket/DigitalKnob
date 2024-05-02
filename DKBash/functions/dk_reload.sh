#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard


##################################################################################
# dk_reload()
#
#
dk_reload () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	dk_debug "reloading $DKSCRIPT_PATH"
	clear
	
	if [ -n "$(command -v bash)" ]; then
		exec /bin/bash "$DKSCRIPT_PATH"
	else
		exec "$DKSCRIPT_PATH"
	fi
}