#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

####################################################################
# dk_appendArgs(variable args)
#
#
dk_appendArgs (){
	dk_debugFunc
	[ $# -lt 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
		
	dk_load dk_saveArgs
	echo "@ = $*"
	echo "1 = $1"
	echo "2 = $2"
	if [ -n "${!1-}" ]; then
		set -- "$@" "${@:2}"
		#echo "export $1=${!1} "${@:2}"" 
		#export $1=${!1} "${@:2}"
		append=$(dk_saveArgs "$@")
	dk_echo "append = $append"
	else
		set --
		set -- "$@" "${@:2}"
		#echo "export $1="${@:2}""
		#export $1="${@:2}"
		append=$(dk_saveArgs "$@")
	dk_echo "append = $append"
	fi
	
	append=$(dk_saveArgs "$@")
	dk_echo "append = $append"
	#dk_echo "1 = $1 = ${!1}"
	
#	if [ -n "${!1-}" ]; then
#		echo "export $1="${!1} ${@:2}""
#		export $1="${!1} ${@:2}"
#	else
#		echo "export $1="${@:2}""
#		export $1="${@:2}"
#	fi
	#dk_echo "1 = $1 = ${!1}"
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc
	
	dk_echo "myVar = ${myVar-}"
	dk_appendArgs myVar "abc"
	dk_echo "myVar = ${myVar-}"
	dk_appendArgs myVar "zyx"
	dk_echo "myVar = ${myVar-}"
}