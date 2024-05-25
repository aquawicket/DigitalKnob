#!/bin/bash
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# __FILE__()
#
__FILE__() {
	[ -z ${1-} ] && _FRAME_=0 || _FRAME_=$1
	((_FRAME_=_FRAME_+2))

	if [ "$(echo -e)" = "" ]; then
		echo -e "$(basename ${BASH_SOURCE[${_FRAME_}]})"
	else
		echo "$(basename ${BASH_SOURCE[${_FRAME_}]})"
	fi
}



DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	
	if [ "$(echo -e)" = "" ]; then
		echo -e "$(__FILE__)"
	else
		echo "$(__FILE__)"
	fi
}