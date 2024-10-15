#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# __FILE__(<frame>)
#
__FILE__() {
	#dk_debugFunc 0 1
	
	[ -z ${1-} ] && _FRAME_=0 || _FRAME_=${1}
	((_FRAME_=_FRAME_+1))

	FILE="${BASH_SOURCE[${_FRAME_-}]-}"
	[ -z "${FILE}" ] && dk_return "nofile" && return
	
	dk_call dk_basename "${FILE}" FILE
	
	dk_return "${FILE}";
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	echo "$(__FILE__)"
}