#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_unset(variable)
#
#
dk_unset() {
	dk_debugFunc 1


	builtin unset ${1}
}





DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc 0
	
	dk_set myVar "initial value assigned with dk_unset"
	dk_echo "myVar = ${myVar}"
	dk_unset myVar
	dk_echo "myVar = ${myVar-}"
}
