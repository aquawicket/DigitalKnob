#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_createCache()
#
#
dk_createCache (){
	dk_debugFunc
	[ ${#} -ne 0 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	dk_echo "creating cache..."
	
	# write variable values line by line
	echo "$APP">"${DKBRANCH_DIR}/cache"
	echo "$TARGET_OS">>"${DKBRANCH_DIR}/cache"
	echo "$TYPE">>"${DKBRANCH_DIR}/cache"
	#echo "$DKENV">>"${DKBRANCH_DIR}/cache"
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_createCache
}