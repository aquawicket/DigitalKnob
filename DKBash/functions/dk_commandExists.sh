<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

##################################################################################
# dk_commandExists(<command>)
#
#
dk_commandExists() {
	dk_debugFunc 1
	
	(command -v ${1} &>/dev/null)
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	if dk_call dk_commandExists bash; then
		dk_call dk_echo "bash command exists"
	else
		dk_call dk_echo "bash command does NOT exist"
	fi
	
	if dk_call dk_commandExists dummy; then
		dk_call dk_echo "dummy command exists"
	else
		dk_call dk_echo "dummy command does NOT exist"
	fi
}
