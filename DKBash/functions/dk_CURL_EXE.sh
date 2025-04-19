#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"


####################################################################
# dk_CURL_EXE()
#
#
dk_CURL_EXE() {
	#dk_call dk_debugFunc 0

	[ -e "${CURL_EXE-}" ] && return

	CURL_EXE=$(command -v curl)
	dk_call dk_assertPath "${CURL_EXE}"
	export CURL_EXE="${CURL_EXE}"
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	#dk_call dk_debugFunc 0

	dk_call dk_CURL_EXE
	dk_call dk_echo "CURL_EXE = ${CURL_EXE-}"
	
	dk_call dk_CURL_EXE
	dk_call dk_echo "CURL_EXE = ${CURL_EXE-}"
}
