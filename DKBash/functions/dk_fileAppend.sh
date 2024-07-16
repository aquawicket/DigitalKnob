#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_fileAppend(file, string)
#
#
dk_fileAppend() {
	dk_debugFunc
	[ ${#} -ne 2 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	[ -e "${1}" ] && builtin echo "${2}" >> "${1}" || builtin echo "${2}" > "${1}"
}




DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_fileAppend "dk_fileAppend_TEST.txt" "string appended from dk_fileAppend"
}