#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_errorStatus()
#
#
alias dk_errorStatus='{
	dk_echo "${BASH_SOURCE} ${LINENO}: ERROR_STATUS = ${?}"
}'



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_errorStatus
}
