#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# __FILE__(<frame>)
#
__FILE__() {
	#dk_debugFunc 0 1
	
	[ -z ${1-} ] && _FRAME_=0 || _FRAME_=${1}
	((_FRAME_=_FRAME_+1))
	#echo "$(dk_basename ${BASH_SOURCE[${_FRAME_}]})"
	dk_return "$(dk_basename ${BASH_SOURCE[${_FRAME_}]})"; return
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	#dk_debugFunc 0
	
	echo "$(__FILE__)"
}