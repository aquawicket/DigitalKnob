#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_realpath(<path> <output>)
#
#    reference: https://stackoverflow.com/a/18443300/688352
#
dk_realpath() {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	
	eval "$2=$(cd $(dirname $1); pwd -P)/$(basename $1)"
	dk_printVar "${2}"
}




DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_realpath dk_load _realpath
	echo "_realpath = ${_realpath}"
}