#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

####################################################################
# dk_appendArgs(array args)
#
#
dk_appendArgs (){
	dk_debugFunc
	[ ${#} -lt 2 ] && dk_error "${FUNCNAME}(${#}): not enough arguments"
	#dk_validateArgs array element optional:rtn_var
	
	# https://stackoverflow.com/a/38959226
	
	typeset -n array="${1}"
	eval array=("${array[@]}" '${2}');

	[ ${#} -gt 2 ] && eval "${3}=${array}" 
	dk_return ${array}; return		# command substitution return
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc
	
	local CMAKE_ARGS=(a b c 1 2 4)
	dk_printVar CMAKE_ARGS
	dk_appendArgs CMAKE_ARGS "A"
	dk_printVar CMAKE_ARGS
	dk_appendArgs CMAKE_ARGS "B"
	dk_printVar CMAKE_ARGS
	dk_appendArgs CMAKE_ARGS "C"
	dk_printVar CMAKE_ARGS
}