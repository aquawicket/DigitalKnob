#!/bin/bash
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# __ARGC__()
#
__ARGC__() {
	
	[ -z ${1-} ] && _FRAME_=1 || _FRAME_=$1
	
	if [ "$(echo -e)" = "" ]; then
		echo -e "${BASH_ARGC[${_FRAME_}]-}"
	else
		echo "${BASH_ARGC[${_FRAME_}]-}"
	fi
}
