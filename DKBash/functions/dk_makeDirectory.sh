#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


#####################################################################
# dk_makeDirectory(<path>)
#
#
dk_makeDirectory () {
	dk_debugFunc
	[ $# -ne 1 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	
	mkdir -p "$1"
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_makeDirectory test
}