#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_createCache()
#
#
dk_createCache() {
	dk_debugFunc 0

	dk_call dk_echo "creating cache..."
	
	# write variable values line by line
	dk_call dk_validate DKCACHE_DIR "dk_DKBRANCH_DIR"
	dk_call dk_fileWrite "${DKCACHE_DIR}/cache" "${APP-}"
	dk_call dk_fileAppend "${DKCACHE_DIR}/cache" "${triple-}"
	dk_call dk_fileAppend "${DKCACHE_DIR}/cache" "${TYPE-}"
	#dk_call dk_fileAppend "${DKCACHE_DIR}/cache" "${DKENV-}"
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_createCache
}
