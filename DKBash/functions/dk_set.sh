#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard


##################################################################################
# dk_set()
#
#
dk_set() {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "Incorrect number of parameters"

	#eval "$1=$2"
	export $1=$2
}