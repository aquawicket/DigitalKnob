#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

####################################################################
# dk_prependArgs(array args)
#
#
dk_prependArgs (){
	dk_debugFunc
	[ ${#} -lt 2 ] && dk_error "${FUNCNAME}(${#}): not enough arguments"
	#dk_validateArgs array args optional:rtn_var
	
	typeset -n array="${1}"
	dk_arrayLength array arrayPush			# parameter variable return
#	if [ -n ${1-} ]; then
#		local arrayPush=$(dk_arrayLength ${1})		# command substitution return
#	fi
	eval ${array}[${arrayPush}]=${2}

#	[ ${#} -gt 2 ] && eval "${3}=${arrayPush}" 
	dk_return ${arrayPush}; return		# command substitution return
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc
	
	local CMAKE_ARGS=(a b c 1 2 4)
	dk_printVar CMAKE_ARGS
	dk_prependArgs CMAKE_ARGS "A"
	dk_printVar CMAKE_ARGS
	dk_prependArgs CMAKE_ARGS "B"
	dk_printVar CMAKE_ARGS
	dk_prependArgs CMAKE_ARGS "C"
	dk_printVar CMAKE_ARGS
}