#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_info(<message>)
#
#	Print a info message to the console
#
#	@msg	- The message to print
#
dk_info() {
	dk_debugFunc 1
	
	dk_call dk_log INFO "$1"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_info "test message from dk_info"
}
