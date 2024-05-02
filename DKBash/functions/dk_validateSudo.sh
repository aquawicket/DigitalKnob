#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard


##################################################################################
# dk_validateSudo()
#
#
dk_validateSudo () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	if command -v "sudo" >/dev/null 2>&1; then
		SUDO="sudo"
	fi
	${SUDO-} echo
}