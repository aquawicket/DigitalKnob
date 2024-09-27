#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_warning(message)
#
#	Print a warning message to the console
#
#	@msg	- The message to print
#
dk_warning() {
	dk_debugFunc 1
	
	dk_call dk_log WARNING "$1"
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_warning "test dk_warning message"
}
