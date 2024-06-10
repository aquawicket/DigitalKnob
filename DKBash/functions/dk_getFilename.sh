#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_getFilename(path, rtn_var)
#
#
dk_getFilename () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	eval "$2=$(basename "$1")"
	dk_printVar $2
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_getFilename "/path/to/a/filename.txt" filename
	dk_echo "filename = ${filename}"
}