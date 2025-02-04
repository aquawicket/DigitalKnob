#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_fatal(message)
#
#	Print a dk_fatal message to the console
#
#	@msg	- The message to print
#
dk_fatal() {
	dk_debugFunc 1
	
	dk_call dk_log FATAL "$1"
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_fatal "test dk_fatal message"
}
