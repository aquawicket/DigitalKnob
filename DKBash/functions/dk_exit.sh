#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_exit()
#
#
dk_exit (){
	dk_debugFunc
	
	# TODO: when open with icon, we can use exec to keep the window open
	#[ $SHLVL -gt 1 ] && dk_echo "exec ${SHELL}" || dk_echo "exit ${*}"
	#[ $SHLVL -eq 1 ] && read -rp 'Press enter to exit...' key
	
	[ ${1} = 0 ] && trap '' EXIT
	builtin exit ${*}
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_exit 0
}