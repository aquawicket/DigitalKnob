#!/bin/bash
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# __FILE__()
#
__FILE__() {
	[ -z ${1-} ] && _FRAME_=2 || _FRAME_=$1
	
	if [ "$(echo -e)" = "" ]; then
		echo -e "$(basename ${BASH_SOURCE[${_FRAME_}]})"
	else
		echo "$(basename ${BASH_SOURCE[${_FRAME_}]})"
	fi
}
