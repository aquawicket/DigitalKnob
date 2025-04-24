<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

##################################################################################
# dk_export(variable, value)
#
#
dk_export() {
	dk_debugFunc 1 2

	export ${1}="${2-}"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_export myVar "the string value of myVar"
	dk_call dk_echo "myVar = ${myVar}"
}
