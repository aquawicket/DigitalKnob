#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

################################################################################
# dk_getFiles(<path> <output>)
#
#   reference: https://stackoverflow.com/a/138581
#
dk_getFiles (){
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	eval "$2=($1/*)" 
	#dk_printVar "${2}"
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_getFiles /c/Windows/System32 output

}
