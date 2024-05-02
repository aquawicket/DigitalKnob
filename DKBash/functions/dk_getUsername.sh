#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard


##################################################################################
# dk_getUsername()
#
#
dk_getUsername () {
	dk_debugFunc
	
	if [ -n "${USER-}" ]; then
		dk_debug USER
		DKUSERNAME=$USER
	elif [ -n "${USERNAME-}" ]; then
		dk_debug USERNAME
		DKUSERNAME=$USERNAME
	fi
	dk_debug DKUSERNAME
}