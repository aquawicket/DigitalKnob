#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

####################################################################
# dk_appendArgs(variable args)
#
#
dk_appendArgs (){
	dk_debugFunc
	#[ ${#} -lt 2 ] && dk_error "${FUNCNAME}($*): incorrect number of arguments"
	dk_validateArgs variable args
	
	dk_echo
	dk_echo "\${1} = ${1-}"
	dk_echo "\${2} = ${2-}"
#	dk_echo "\${3} = ${3-}"
#	dk_echo "\${*} = ${*-}"
		
	# THIS WORKS when $1 is passed by array[@]	
	#local var=(${!1-})
	#dk_arrayPush var ${@:2}
	
	array_name=${1}
	dk_echo "\${array_name} = ${array_name}"		# CMAKE_ARGS
	
	array_value=${!array_name}
	dk_echo "\${array_value} = ${array_value}"		# a
	
	eval array_valueA='$'$array_name
	dk_echo "\${array_valueA} = ${array_valueA}"	# a
	
	eval array_valueB='${'$array_name'}'
	dk_echo "\${array_valueB} = ${array_valueB}"	# a
	
	eval array_valueC='${'$array_name'[1]}'
	dk_echo "\${array_valueC} = ${array_valueC}"	# b
	
	eval array_valueD='${'${array_name}'[1]}'
	dk_echo "\${array_valueD} = ${array_valueD}"	# b

	#array_value1=${CMAKE_ARGS[1]}
	#dk_echo "\${array_value1} = ${array_value1}"
	
	
	
	

	#array_valueC=(${!array_valueB})
	#dk_echo "\${array_valueC} = ${array_valueC}"

	#local var=(${1}[@])

	#dk_echo "\${var[0] = ${var[0]-}"
	#dk_echo "\${var[1] = ${var[1]-}"
	#dk_echo "\${var[2] = ${var[2]-}"
	#dk_echo "\${var[3] = ${var[3]-}"
	#dk_echo "\${var[*] = ${var[*]-}"
	
	#eval ${1}=${args[@]}
	#dk_return "${args[@]}"; return

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
	dk_echo "CMAKE_ARGS = ${CMAKE_ARGS}"
	dk_echo "CMAKE_ARGS[1] = ${CMAKE_ARGS[1]}"
	CMAKE_ARGS_ALL="${CMAKE_ARGS[@]}"
	dk_echo "CMAKE_ARGS_ALL = ${CMAKE_ARGS_ALL}"
	#dk_appendArgs CMAKE_ARGS[@] "A"
	dk_appendArgs CMAKE_ARGS "A"
	dk_echo "CMAKE_ARGS = ${CMAKE_ARGS}"
	dk_appendArgs CMAKE_ARGS "B"
	dk_echo "CMAKE_ARGS = ${CMAKE_ARGS}"
	dk_appendArgs CMAKE_ARGS "C"
	dk_echo "CMAKE_ARGS = ${CMAKE_ARGS}"
	
}