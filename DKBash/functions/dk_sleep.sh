#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


#####################################################################
# dk_sleep(<seconds>)
#
#
dk_sleep() {
	dk_debugFunc
	[ ${#} -ne 1 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	sleep ${1}
}



DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######

	echo "sleeping for 5 seconds . . ."
	dk_sleep 5
	echo "done"
}