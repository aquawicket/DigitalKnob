#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

####################################################################
# dk_prependArgs(variable args)
#
#
dk_prependArgs (){
	dk_debugFunc
	[ $# -lt 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
		if [ -n "${!1-}" ]; then
			echo "export $1="${@:2} ${!1}""
			export $1="${@:2} ${!1}"
		else
			echo "export $1="${@:2}""
			export $1="${@:2}"
		fi
		dk_echo "1 = $1 = ${!1}"
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc
	
	dk_echo "myVar = ${myVar-}"
	dk_prependArgs myVar "abc"
	dk_echo "myVar = ${myVar-}"
	dk_prependArgs myVar "zyx"
	dk_echo "myVar = ${myVar-}"
}