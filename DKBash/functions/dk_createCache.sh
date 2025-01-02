#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_createCache()
#
#
dk_createCache() {
	dk_debugFunc 0

	dk_call dk_echo "creating cache..."
	dk_call dk_validate DKCACHE_DIR "dk_DKCACHE_DIR"
	dk_call dk_fileWrite "${DKCACHE_DIR}/cache" "${target_app-} ${target_triple-} ${target_type-}"
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	target_app="HelloWorld"
	target_triple="WIN_X86_64_CLANG"
	target_type="Debug"
	dk_call dk_createCache
}
