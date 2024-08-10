#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_debug(message)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
dk_debug() {
	dk_debugFunc 1
	dk_log DEBUG "${1-}"
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	dk_debug "test dk_debug message"
}