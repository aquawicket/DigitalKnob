#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

################################################################################
# dk_fileToArray(<path> <output>)
#
#  Read lines of a file into an array and echo them back
#
#  reference: https://stackoverflow.com/a/49042678
#
dk_fileToArray () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	
	dk_todo
}



DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_fileToArray

}	