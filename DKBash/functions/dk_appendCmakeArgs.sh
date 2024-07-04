#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

####################################################################
# dk_appendCmakeArgs(args)
#
#
dk_appendCmakeArgs (){
	dk_debugFunc
	[ $# -lt 1 ] && dk_error "${FUNCNAME}($#): not enough arguments"
	
    export CMAKE_ARGS=${CMAKE_ARGS} "${*}"
	#call dk_set CMAKE_ARGS "${CMAKE_ARGS} "${*}""
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc
	
	dk_appendCmakeArgs "-G Unix Makefiles"
}