#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_error(<message>)
#
#	Print a error message to the console
#
#	@msg	- The message to print
#
dk_error() {
	dk_debugFunc 1
	
	dk_call dk_log ERROR "$1"
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	dk_call dk_error "test dk_error message"
}
