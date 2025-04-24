<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"


##################################################################################
# dk_readCache(rtn:APP, rtn:triple, rtn:TYPE)
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"


##################################################################################
# dk_readCache(rtn:target_app, rtn:target_triple, rtn:target_type)
>>>>>>> Development
#
#
dk_readCache() {
	dk_debugFunc 3

<<<<<<< HEAD
	dk_call dk_validate DKCACHE_DIR "dk_call dk_DKHOME_DIR"
	dk_call dk_pathExists "${DKCACHE_DIR-}"/cache || return 0
	#_APP_=
	#_triple_=
	#_TYPE_=
	
	dk_call dk_echo "reading cache..."
	count=0
	while read p; do
		[ "${count}" = "0" ] && _APP_=$(builtin echo "${p}" | tr -d '\r')
		[ "${count}" = "1" ] && _triple_=$(builtin echo "${p}" | tr -d '\r')
		[ "${count}" = "2" ] &&	_TYPE_=$(builtin echo "${p}" | tr -d '\r')
		#[ "${count}" = "3" ] && DKENV=$(echo ${p} | tr -d '\r')
		count=$((count + 1))
	done < "${DKCACHE_DIR}"/cache
	
	eval "${1}=${_APP_}"
	eval "${2}=${_triple_}"
	eval "${3}=${_TYPE_}"
=======
	dk_call dk_validate DKCACHE_DIR "dk_call dk_DKCACHE_DIR"
	dk_call dk_pathExists "${DKCACHE_DIR-}"/DKBuilder.cache || return 0
	
	dk_call dk_echo "reading DKBuilder.cache..."
	line=$(head -n 1 "${DKCACHE_DIR}"/DKBuilder.cache)
	IFS=', ' read -r -a array <<< "$line"
	
	eval "${1}=${array[0]-}"
	eval "${2}=${array[1]-}"
	eval "${3}=${array[2]-}"
>>>>>>> Development
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
<<<<<<< HEAD
	dk_call dk_readCache APP triple TYPE
	dk_call dk_printVar APP
	dk_call dk_printVar triple
	dk_call dk_printVar TYPE
=======
	dk_call dk_readCache target_app target_triple target_type
	dk_call dk_printVar target_app
	dk_call dk_printVar target_triple
	dk_call dk_printVar target_type
>>>>>>> Development
}
