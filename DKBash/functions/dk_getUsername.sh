#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_getUsername(<output>)
#
#
dk_getUsername (){
	dk_debugFunc
	[ $# -ne 1 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	if [ -n "${USER-}" ]; then
		DKUSERNAME=$USER
	elif [ -n "${USERNAME-}" ]; then
		DKUSERNAME=$USERNAME
	fi
	
	eval "$1=${DKUSERNAME}"
	dk_printVar "${1}"
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_getUsername _username
	echo "_username = ${_username}"
}