<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

##################################################################################
# dk_hasValue(<variable>)
#
# Evaluates to true if the parameter is a variable that exists and has value
#
dk_hasValue() {
	dk_debugFunc 1

	eval value='$'{${1}}
	[ -n "${value//[[:blank:]]/}" ] # remove spaces and check if empty
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_hasValue
}