#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# __LINE__(<frame>)
#
__LINE__ (){
	[ -z ${1-} ] && _FRAME_=0 || _FRAME_=$1

	dk_return "${BASH_LINENO[${_FRAME_}]}"
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	
	echo "$(__LINE__)"

}
