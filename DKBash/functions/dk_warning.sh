#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

#dk_set ENABLE_dk_warning 0
#dk_set TRACE_ON_WARNING 1
#dk_set LINE_ON_WARNING 1
#dk_set PAUSE_ON_WARNING 1
#dk_set HALT_ON_WARNING 1
#dk_set WARNING_TAG " WARNING: "
##################################################################################
# dk_warning(message)
#
#	Print a warning message to the console
#
#	@msg	- The message to print
#
dk_warning() {
	dk_debugFunc 1
	dk_log WARNING "$1"
}








DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc 0
	
	dk_warning "test dk_warning message"
}