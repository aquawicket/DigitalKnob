#!/bin/bash
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# __FUNCTION__(<frame>)
#
__FUNCTION__() {
	[ -z ${1-} ] && _FRAME_=0 || _FRAME_=$1

	dk_return "${FUNCNAME[${_FRAME_}]}"
}



DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	
	echo "$(__FUNCTION__)"

}