#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_fileAppend(file, string)
#
#
dk_fileAppend() {
	dk_debugFunc 2

	
	[ -e "${1}" ] && builtin echo "${2}" >> "${1}" || builtin echo "${2}" > "${1}"
}




DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc 0
	
	dk_fileAppend "dk_fileAppend_TEST.txt" "string appended from dk_fileAppend"
}