#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"


##################################################################################
# dk_set(variable, value)
#
#
dk_set() {
	dk_debugFunc 2

	dk_call dk_export ${1} "${2-}"
	dk_call dk_printVar ${1}
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_set myVar "value assigned with dk_set"	
	dk_call dk_echo "myVar = ${myVar}"
}
