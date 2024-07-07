#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# __FILE__(<frame>)
#
__FILE__ (){
	#dk_debugFunc
	
	[ -z ${1-} ] && _FRAME_=0 || _FRAME_=$1
	((_FRAME_=_FRAME_+1))
	#echo "$(basename ${BASH_SOURCE[${_FRAME_}]})"
	dk_return "$(basename ${BASH_SOURCE[${_FRAME_}]})"; return
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	#dk_debugFunc
	
	echo "$(__FILE__)"
}