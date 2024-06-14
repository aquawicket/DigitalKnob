#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_getBasename(path, rtn_var)
#
#
dk_getBasename () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	basename=$(basename "$1")
	dk_printVar basename
	eval "$2=$basename"
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_getBasename "/path/to/a/filename.txt" basename
	dk_echo "basename = ${basename}"
}