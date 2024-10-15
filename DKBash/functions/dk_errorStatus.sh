#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_errorStatus()
#
#
alias dk_errorStatus='{
	dk_call dk_echo "${BASH_SOURCE} ${LINENO}: ERROR_STATUS = ${?}"
}'







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_errorStatus
}
