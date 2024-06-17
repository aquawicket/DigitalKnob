#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

####################################################################
# dk_appendCmakeArgs(string)
#
#
dk_appendCmakeArgs () {
	dk_debugFunc
	#[ $# -ne 1 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
    CMAKE_ARGS=${CMAKE_ARGS} "$*"
	#call dk_set CMAKE_ARGS "${CMAKE_ARGS} "$*""
}




DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo

}