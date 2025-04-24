<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

####################################################################
# dk_SUDO_EXE()
#
#
dk_SUDO_EXE(){
	(command -v sudo) && export SUDO_EXE=$(command -v sudo) || echo "sudo Not Found" >&2
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0
 
    dk_call dk_SUDO_EXE
    dk_call dk_printVar SUDO_EXE
}
