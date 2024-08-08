#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_readCache()
#
#
dk_readCache() {
	dk_debugFunc
	[ ${#} -ne 0 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	dk_pathExists "${DKBRANCH_DIR-}"/cache || return 0
	_APP_=
	_TARGET_OS_=
	_TYPE_=
	
	dk_echo "reading cache..."
	count=0
	while read p; do
		[ "${count}" = "0" ] && _APP_=$(builtin echo "${p}" | tr -d '\r')
		[ "${count}" = "1" ] && _TARGET_OS_=$(builtin echo "${p}" | tr -d '\r')
		[ "${count}" = "2" ] &&	_TYPE_=$(builtin echo "${p}" | tr -d '\r')
		#[ "${count}" = "3" ] && _DKENV_=$(echo ${p} | tr -d '\r')
		count=$((count + 1))
	done < "${DKBRANCH_DIR}"/cache
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc
	
	dk_readCache
}