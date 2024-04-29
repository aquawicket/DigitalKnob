#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh && DKTEST=1
dk_includeGuard

##################################################################################
# dk_test(<args>)
#
#
dk_test () {
	dk_debugFunc
	[ $# -ne 1 ] && dk_error "incorrect number of parameters"
	
	echo "$1"
}



################################ TEST_dk_test() ##################################
if [ -n "${DKTEST}" ]; then
	dk_test "called from TEST portion of the script"
	dk_exit
fi