#!/bin/bash
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# __ARGV__()
#
__ARGV__() {
	
	[ -z ${1-} ] && _FRAME_=1 || _FRAME_=$1
	
	(( _ARGCF_=$_FRAME_+1 ))
	_ARGC_=$(__ARGC__ $_ARGCF_)
	
	for (( i=(($_ARGC_-1)); i>=0; i-- )); do
		[ -z "${_ARGV_-}" ] && _ARGV_="${BASH_ARGV[${i}]-}" || _ARGV_="${_ARGV_-}, ${BASH_ARGV[${i}]-}"
	done
	echo ${_ARGV_-}
}
