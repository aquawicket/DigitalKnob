#!/bin/bash
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# __LINE__()
#
__LINE__() {
	[ -z ${1-} ] && _FRAME_=0 || _FRAME_=$1
	((_FRAME_=_FRAME_+1))

	if [ "$(echo -e)" = "" ]; then
		echo -e "${BASH_LINENO[${_FRAME_}]}"
	else
		echo "${BASH_LINENO[${_FRAME_}]}"
	fi

	#echo ${LINENO}
}
