<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

################################################################################
# dk_getAttributes(<path> <output>)
#
dk_getAttributes() {
	dk_debugFunc 2

	dk_call dk_todo
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
<<<<<<< HEAD
	dk_call dk_fileToArray
=======
	dk_call dk_getAttributes
>>>>>>> Development
}	
