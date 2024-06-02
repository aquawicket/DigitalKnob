#!/bin/bash
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# __ARGC__(<frame>)
#
__ARGC__() {
	[ -z ${1-} ] && _FRAME_=0 || _FRAME_=$1

	dk_return "${BASH_ARGC[${_FRAME_}]-}"
}



DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	
	echo "$(__ARGC__)"

}