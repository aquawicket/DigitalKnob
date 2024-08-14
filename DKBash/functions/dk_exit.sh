#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

[ -z ${PAUSE_ON_EXIT-} ] && PAUSE_ON_EXIT=1
##################################################################################
# dk_exit(rtn_code)
#
#
dk_exit() {
	dk_debugFunc 0 1

	# TODO: when open with icon, we can use exec to keep the window open
	#[ $SHLVL -gt 1 ] && dk_call dk_echo "exec ${SHELL}"
	#[ $SHLVL -eq 1 ] && dk_call dk_pause
	
	[ ${1-} -eq 0 ] && trap '' EXIT
	
	dk_call dk_echo "dk_exit ${1-}"
	[ ${PAUSE_ON_EXIT} = 1 ] && dk_call dk_echo "*** PAUSE_ON_EXIT ***" && dk_call dk_pause
	builtin exit ${1-}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	# Only 'dk_exit 0' will turn the dk_onExit trap off
	dk_call dk_exit 0
}
