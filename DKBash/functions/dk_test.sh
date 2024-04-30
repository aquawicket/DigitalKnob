#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh && DKTEST=1
dk_includeGuard

##################################################################################
# dk_test(<args>)
#
#
dk_test () {
	dk_debugFunc
	
	echo "$1"
}



################################ DKTEST #########################################
TEST_dk_test () {
	dk_test "called from TEST portion of the script"
	dk_exit
}
[ -n "$DKTEST" ] && TEST_dk_test