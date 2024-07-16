#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_export(variable, value)
#
#
dk_export() {
	dk_debugFunc
	[ ${#} -lt 1 ] && dk_error "${FUNCNAME}(${#}): not enough arguments"
	
	export ${1}="${2-}"
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_export myVar "the string value of myVar"
	dk_echo "myVar = ${myVar}"
}
