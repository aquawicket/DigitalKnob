#!/usr/bin/env sh
DKBASH_FUNCTIONS_DIR_="${PWD}/"
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_wslInit.sh()
#
#    https://github.com/microsoft/WSL/issues/5420#issuecomment-646479747
#
dk_wslInit() {
	dk_debugFunc 0
	echo "dk_wslInit()"

	echo "######## WSL Init #######"
	[ ! -e "/etc" ] && echo "ERROR: /etc directory does not exist"
	echo "WSLENV = ${WSLENV}"
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_wslInit
}
