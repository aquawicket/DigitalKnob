#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_getFuncName(<output>)
#
#
dk_getFuncName() {
	dk_debugFunc
	[ ${#} -ne 1 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	eval "${1}=${FUNCNAME[1]}"
	dk_printVar "${1}"
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_getFuncName funcName
	dk_echo "funcName = ${funcName}"
}
