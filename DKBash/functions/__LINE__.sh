#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# __LINE__(<frame>)
#
__LINE__() {
	#dk_debugFunc 0 1
	
	[ -z ${1-} ] && _FRAME_=0 || _FRAME_=${1}
	dk_return "${BASH_LINENO[${_FRAME_}]}"; return
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	#dk_debugFunc 0
	
	echo "$(__LINE__)"
}
