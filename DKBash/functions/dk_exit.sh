#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

[ -z ${PAUSE_ON_EXIT-} ] && PAUSE_ON_EXIT=0
##################################################################################
# dk_exit(exit_code)
#
#
dk_exit() {
	dk_debugFunc 0 1
	
	trap '' EXIT
	[ -z "${exit_code-}" ] && export exit_code=0
	[ $? -gt ${exit_code} ] && export exit_code=$?
	[ ${1-} -gt ${exit_code} ] && export exit_code=$1
	
	[ ${PAUSE_ON_EXIT} = 1 ] && dk_call dk_echo "*** PAUSE_ON_EXIT: exit_code:${exit_code} ***" && dk_call dk_pause
	
	exit ${exit_code}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	#Note: Only 'dk_exit 0' will turn the dk_onExit trap off
	
	#dk_call dk_exit
	#dk_call dk_exit 0
	#dk_call dk_exit 123
	dk_call dk_exit 13
}
