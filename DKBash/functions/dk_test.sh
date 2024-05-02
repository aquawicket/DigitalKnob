#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard


##################################################################################
# dk_test(<args>)
#
#
dk_test () {
	dk_debugFunc
	
	echo "$1"
}


################################ DKTEST #########################################
[ -n "$DKTEST" ] && {

	dk_test "called from TEST portion of the script"	
	
} && exec $SHELL
