#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

################################################################################
# dk_getFiles(<path> <output>)
#
#   reference: https://stackoverflow.com/a/138581
#
dk_getFiles () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	
	dk_todo
}




DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_getFiles

}
