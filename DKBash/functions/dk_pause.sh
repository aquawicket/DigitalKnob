#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_pause()
#
#	Pause execution and wait for keypress to continue
#
dk_pause (){
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	
	read -rp 'Press enter to continue...' key     #; echo ${key}
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_pause
}