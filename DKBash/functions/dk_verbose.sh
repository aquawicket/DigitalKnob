#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

#dk_set ENABLE_dk_verbose 1
#dk_set TRACE_ON_VERBOSE 1
#dk_set LINE_ON_VERBOSE 1
#dk_set PAUSE_ON_VERBOSE 1
#dk_set HALT_ON_VERBOSE 1
#dk_set VERBOSE_TAG " VERBOSE: "
##################################################################################
# dk_verbose(message)
#
#	Print a verbose message to the console
#
#	@msg	- The message to print
#
dk_verbose() {
	dk_debugFunc 1
	dk_log VERBOSE "$1"
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_verbose "test dk_verbose message"
}