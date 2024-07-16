#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_commandExists(<command>)
#
#
dk_commandExists() {
	dk_debugFunc
	[ ${#} -ne 1 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"

	[ -n "$(command -v "${1}")" ]
}




DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	if dk_commandExists bash; then
		dk_echo "bash command exists"
	else
		dk_echo "bash command does NOT exist"
	fi
	
	if dk_commandExists dummy; then
		dk_echo "dummy command exists"
	else
		dk_echo "dummy command does NOT exist"
	fi
}