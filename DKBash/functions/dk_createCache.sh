#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_createCache()
#
#
dk_createCache() {
	dk_debugFunc 0

	dk_call dk_echo "creating cache..."
	
	# write variable values line by line
	dk_call dk_fileWrite "${DKBRANCH_DIR}/cache" "${APP}"
	dk_call dk_fileAppend "${DKBRANCH_DIR}/cache" "${TARGET_OS}"
	dk_call dk_fileAppend "${DKBRANCH_DIR}/cache" "${TYPE}"
	#dk_call dk_fileAppend "${DKBRANCH_DIR}/cache" "${DKENV}"
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_createCache
}
