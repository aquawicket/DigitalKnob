#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

####################################################################
# dk_appendArgs(variable args)
#
#
dk_appendArgs (){
	dk_debugFunc
	[ $# -lt 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
		if [ -n "${!1-}" ]; then
			export $1=${!1} "${@:2}"
		else
			export $1="${@:2}"
		fi
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