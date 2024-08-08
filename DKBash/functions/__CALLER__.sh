#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# __CALLER__(<frame>)
#
__CALLER__() {
	#dk_debugFunc
	
	[ -z ${1-} ] && _FRAME_=0 || _FRAME_=${1}
	((_FRAME_=_FRAME_+1))
	dk_return "${FUNCNAME[${_FRAME_}]-}"; return
}



DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	#dk_debugFunc
	
	echo "$(__CALLER__)"
}