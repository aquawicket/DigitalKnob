#!/bin/bash
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# __ARGV__()
#
__ARGV__() {
	[ -z ${1-} ] && _FRAME_=0 || _FRAME_=$1
#	((_FRAME_=_FRAME_-1))
	
	_ARGC_=${BASH_ARGC[${_FRAME_}]-}
	for (( i=((_ARGC_)); i>=1; i-- )); do
		[ -z "${_ARGV_-}" ] && _ARGV_="${BASH_ARGV[${i}]-}" || _ARGV_="${_ARGV_-}, ${BASH_ARGV[${i}]-}"
	done
	dk_return "${_ARGV_-}"
}



DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	
	echo "$(__ARGV__)"

}