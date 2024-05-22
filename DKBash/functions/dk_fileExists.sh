#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_fileExists(<file>)
#
#
dk_fileExists () {
	dk_debugFunc
	[ $# -ne 1 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"

	[ -e "$1" ]
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	if dk_fileExists "dk_debug"; then
		echo "The file exists"
	else
		echo "The file does NOT exist"
	fi
	
	if dk_fileExists "nofile.ext"; then
		echo "The file exists"
	else
		echo "The file does NOT exist"
	fi
}