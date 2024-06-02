#!/bin/bash
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# __ARGV__(<frame>)
#
__ARGV__() {
	[ -z ${1-} ] && _FRAME_=0 || _FRAME_=$1
	
	marker=0
	for (( i=0; i<_FRAME_; i++ )); do
		marker=$(($marker + ${BASH_ARGC[${i}]-}))
	done
	#echo "marker = $marker : ${BASH_ARGV[${marker}]-}"
	
	_ARGC_=${BASH_ARGC[${_FRAME_}]-}
	begin=$(($marker+$_ARGC_-1))
	for (( i=$begin; i>((begin-_ARGC_)); i-- )); do
		[ -z "${_ARGV_-}" ] && _ARGV_="${BASH_ARGV[${i}]-}" || _ARGV_="${_ARGV_-}, ${BASH_ARGV[${i}]-}"
	done
	dk_return "${_ARGV_-}"
}



DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	
	echo "$(__ARGV__)"

}