#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

####################################################################
# dk_appendArgs(array args)
#
#
dk_appendArgs (){
	dk_debugFunc
	#[ ${#} -lt 2 ] && dk_error "${FUNCNAME}($*): incorrect number of arguments"
	dk_validateArgs array args
	
	#eval local arry=('${'$1'[@]}')
	typeset -n arry=${1}
	
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc
	
	local CMAKE_ARGS=(a b c 1 2 4)
	dk_echo "CMAKE_ARGS = ${CMAKE_ARGS}"
	dk_appendArgs CMAKE_ARGS "A"
	dk_echo "CMAKE_ARGS = ${CMAKE_ARGS}"
	dk_appendArgs CMAKE_ARGS "B"
	dk_echo "CMAKE_ARGS = ${CMAKE_ARGS}"
	dk_appendArgs CMAKE_ARGS "C"
	dk_echo "CMAKE_ARGS = ${CMAKE_ARGS}"
	
}