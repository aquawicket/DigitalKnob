#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_getFullPath(<path> <output>)
#
#
dk_getFullPath () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	
	eval "$2=$(realpath "$1")"
	dk_printVar "${2}"
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_getFullPath "bash" fullPath
	echo "fullPath = ${fullPath}"
}