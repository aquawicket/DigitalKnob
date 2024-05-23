#!/bin/bash
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# __CALLER__()
#
__CALLER__() {

	[ -z ${1-} ] && _FRAME_=1 || _FRAME_=$1
	(( _FRAME_=$_FRAME_+1 ))
	
	if [ "$(echo -e)" = "" ]; then
		echo -e "${FUNCNAME[${_FRAME_}]}($*)"
	else
		echo "${FUNCNAME[${_FRAME_}]}($*)"
	fi
}
