#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_set(<variable> <value>)
#
#
dk_set (){
	dk_debugFunc
	[ $# -lt 1 ] && dk_error "${FUNCNAME}($#): not enough arguments"

	export $1="${2-}"
	dk_printVar "${1}"
}





DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_set myVar "value assigned with dk_set"	
	echo "myVar = ${myVar}"
}