#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_commandExists(<command>)
#
#
dk_commandExists (){
	dk_debugFunc
	[ ${#} -ne 1 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"

	[ -n "$(command -v "${1}")" ]
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	if dk_commandExists bash; then
		echo "bash command exists"
	else
		echo "bash command does NOT exist"
	fi
	
	if dk_commandExists dummy; then
		echo "dummy command exists"
	else
		echo "dummy command does NOT exist"
	fi
}