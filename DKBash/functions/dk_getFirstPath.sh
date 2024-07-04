#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_getFirstPath(<result>)
#
#
dk_getFirstPath (){
	dk_debugFunc
	[ $# -ne 1 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	eval "$1=${PATH%%:*}"
	dk_printVar $1
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_getFirstPath firstPath
	echo "firstPath = ${firstPath}"
}