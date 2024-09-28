#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"


##################################################################################
# dk_readCache(rtn:APP, rtn:TARGET_OS, rtn:TYPE)
#
#
dk_readCache() {
	dk_debugFunc 3

	dk_call dk_validate DKBRANCH_DIR "dk_DKBRANCH_DIR"
	dk_call dk_pathExists "${DKBRANCH_DIR-}"/cache || return 0
	#_APP_=
	#_TARGET_OS_=
	#_TYPE_=
	
	dk_call dk_echo "reading cache..."
	count=0
	while read p; do
		[ "${count}" = "0" ] && _APP_=$(builtin echo "${p}" | tr -d '\r')
		[ "${count}" = "1" ] && _TARGET_OS_=$(builtin echo "${p}" | tr -d '\r')
		[ "${count}" = "2" ] &&	_TYPE_=$(builtin echo "${p}" | tr -d '\r')
		#[ "${count}" = "3" ] && DKENV=$(echo ${p} | tr -d '\r')
		count=$((count + 1))
	done < "${DKBRANCH_DIR}"/cache
	
	eval "${1}=${_APP_}"
	eval "${2}=${_TARGET_OS_}"
	eval "${3}=${_TYPE_}"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_readCache APP TARGET_OS TYPE
	dk_call dk_printVar APP
	dk_call dk_printVar TARGET_OS
	dk_call dk_printVar TYPE
}
