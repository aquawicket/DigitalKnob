#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_readCache()
#
#
dk_readCache (){
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	if ! dk_pathExists "${DKBRANCH_DIR-}"/cache; then
		return 0
	fi
	_APP_=
	_TARGET_OS_=
	_TYPE_=
	
	dk_echo "reading cache..."
	count=0
	while read p; do
		if [ "${count}" = "0" ]; then 
			_APP_=$(builtin echo "${p}" | tr -d '\r')
			#dk_printVar _APP_
		fi
		if [ "${count}" = "1" ]; then
			_TARGET_OS_=$(builtin echo "${p}" | tr -d '\r')
			#dk_printVar _TARGET_OS_ 
		fi
		if [ "${count}" = "2" ]; then
			_TYPE_=$(builtin echo "${p}" | tr -d '\r')
			#dk_printVar _TYPE_
		fi
		#if [ "${count}" = "3" ]; then
		#	_DKENV_=$(echo ${p} | tr -d '\r')
		#	#dk_printVar _DKENV_
		#fi
		count=$((count + 1))
	done < "${DKBRANCH_DIR}"/cache
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_readCache
}