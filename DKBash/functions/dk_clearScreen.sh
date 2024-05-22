#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# dk_clearScreen()
#
#
dk_clearScreen () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	
	clear
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_clearScreen
}