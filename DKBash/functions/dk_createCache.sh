#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_createCache()
#
#
dk_createCache() {
	dk_debugFunc
	[ ${#} -ne 0 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	dk_echo "creating cache..."
	
	# write variable values line by line
	dk_fileWrite "${DKBRANCH_DIR}/cache" "${APP}"
	dk_fileAppend "${DKBRANCH_DIR}/cache" "${TARGET_OS}"
	dk_fileAppend "${DKBRANCH_DIR}/cache" "${TYPE}"
	#dk_fileAppend "${DKBRANCH_DIR}/cache" "${DKENV}"
}




DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc
	
	dk_createCache
}