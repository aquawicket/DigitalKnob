#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_todo(<message>)
#
#	Print a todo message to the console
#
#	@msg	- The message to print
#
dk_todo() {
	dk_debugFunc 0 1
	
	dk_call dk_log TODO "${1-}"
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_todo "test dk_todo message"
}
