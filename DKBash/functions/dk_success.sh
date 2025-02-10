#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_success(message)
#
#	Print a dk_success message to the console
#
#	@msg	- The message to print
#
dk_success() {
	dk_debugFunc 1
	
	dk_call dk_log SUCCESS "$1"
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_success "test dk_success message"
}
