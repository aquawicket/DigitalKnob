#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_realpath(<path> <output>)
#
#    reference: https://stackoverflow.com/a/18443300/688352
#
dk_realpath (){
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	local absolutePath=""
	if dk_commandExists readlink; then
		absolutePath=$(readlink -f "$1") || true
	elif dk_commandExists realpath; then
		absolutePath=$(realpath "$1")
	else	
		absolutePath=$(cd $(dirname $1); pwd -P)/$(basename $1)
	fi
	
	eval "$2=${absolutePath}"
	dk_printVar "${2}"
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_realpath dk_load.sh _realpath
	echo "_realpath = ${_realpath}"
}