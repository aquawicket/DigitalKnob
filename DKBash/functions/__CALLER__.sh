#!/bin/bash
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# __CALLER__(<frame>)
#
__CALLER__() {
	[ -z ${1-} ] && _FRAME_=0 || _FRAME_=$1
	((_FRAME_=_FRAME_+1))

	dk_return "${FUNCNAME[${_FRAME_}]-}()"
}



DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	
	echo "$(__CALLER__)"

}