#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_verbose(message)
#
#	Print a verbose message to the console
#
#	@msg	- The message to print
#
dk_verbose() {
	dk_debugFunc 1
	
	dk_call dk_log VERBOSE "$1"
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_verbose "test dk_verbose message"
}
