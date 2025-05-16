#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################



##################################################################################
# dk_readCache(rtn:target_app, rtn:Target_Tuple, rtn:target_type)
#
#
dk_readCache() {
	dk_debugFunc 3

	dk_call dk_validate DKCACHE_DIR "dk_call dk_DKCACHE_DIR"
	dk_call dk_pathExists "${DKCACHE_DIR-}"/DKBuilder.cache || return 0
	
	dk_call dk_echo "reading DKBuilder.cache..."
	line=$(head -n 1 "${DKCACHE_DIR}"/DKBuilder.cache)
	IFS=', ' read -r -a array <<< "$line"
	
	eval "${1}=${array[0]-}"
	eval "${2}=${array[1]-}"
	eval "${3}=${array[2]-}"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_readCache target_app Target_Tuple target_type
	dk_call dk_printVar target_app
	dk_call dk_printVar Target_Tuple
	dk_call dk_printVar target_type
}
