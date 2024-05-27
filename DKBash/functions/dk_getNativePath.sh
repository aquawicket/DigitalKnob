#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_getFilename(<path> <output>)
#
#
dk_getNativePath () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	
	eval "$2=$(readlink -f "$1")"
	dk_printVar $2
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_getNativePath "/c/Windows/System32" nativePath
	echo "nativePath = ${nativePath}"
}