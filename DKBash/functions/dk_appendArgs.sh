#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

####################################################################
# dk_appendArgs(variable args)
#
#
dk_appendArgs (){
	dk_debugFunc
	[ ${#} -lt 2 ] && dk_error "${FUNCNAME}($*): incorrect number of arguments"
	dk_validateArgs variable args
	
	dk_echo
	dk_echo "\${1} = ${1-}"
	dk_echo "\${2} = ${2-}"
	dk_echo "\${3} = ${3-}"
	dk_echo "\${*} = ${*-}"
		
	local args=(${!1-})
	dk_echo "\${args[0] = ${args[0]-}"
	dk_echo "\${args[1] = ${args[1]-}"
	dk_echo "\${args[2] = ${args[2]-}"
	dk_echo "\${args[2] = ${args[3]-}"
	dk_echo "\${args[*] = ${args[*]-}"
	
	dk_arrayPush args "xyz"
	eval ${1}=${args[@]}
	#dk_return "${args[@]}"

#	if [ -n "${!1-}" ]; then
#		set -- "$@" "${@:2}"
#		#dk_echo "export ${1}=${!1} "${@:2}"" 
#		#export ${1}=${!1} "${@:2}"
#		append=$(dk_saveArgs "$@")
#	dk_echo "append = $append"
#	else
#		set --
#		set -- "$@" "${@:2}"
#		#dk_echo "export ${1}="${@:2}""
#		#export ${1}="${@:2}"
#		append=$(dk_saveArgs "$@")
#	dk_echo "append = $append"
#	fi
	
#	append=$(dk_saveArgs "$@")
#	dk_echo "append = $append"
	#dk_echo "1 = ${1} = ${!1}"
	
#	if [ -n "${!1-}" ]; then
#		dk_echo "export ${1}="${!1} ${@:2}""
#		export ${1}="${!1} ${@:2}"
#	else
#		dk_echo "export ${1}="${@:2}""
#		export ${1}="${@:2}"
#	fi
	#dk_echo "1 = ${1} = ${!1}"
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc
	
	local CMAKE_ARGS=(a b c 1 2 4)
	dk_echo "CMAKE_ARGS = ${CMAKE_ARGS-}"
	dk_appendArgs CMAKE_ARGS[@] "A"
	dk_echo "CMAKE_ARGS = ${CMAKE_ARGS-}"
	dk_appendArgs CMAKE_ARGS[@] "B"
	dk_echo "CMAKE_ARGS = ${CMAKE_ARGS-}"
	dk_appendArgs CMAKE_ARGS[@] "C"
	dk_echo "CMAKE_ARGS = ${CMAKE_ARGS-}"
	
}