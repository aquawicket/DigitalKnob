#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

####################################################################
# dk_appendArgs(variable args)
#
#
dk_appendArgs (){
	dk_debugFunc
	[ $# -lt 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
    CMAKE_ARGS=${CMAKE_ARGS} "$*"
	#call dk_set CMAKE_ARGS "${CMAKE_ARGS} "$*""
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc
	
	dk_todo
}