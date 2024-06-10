#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# dk_unset(<variable>)
#
#
dk_unset() {
	dk_debugFunc
	[ $# -ne 1 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"

	unset $1
}





DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	myVar="initial value assigned with dk_unset"
	echo "myVar = ${myVar}"
	dk_unset myVar
	echo "myVar = ${myVar-}"
}