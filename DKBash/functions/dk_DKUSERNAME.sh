<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

####################################################################
# dk_DKUSERNAME()
#
#
dk_DKUSERNAME() {
    dk_debugFunc 0

	[ -n "${DKUSERNAME-}" ] || export DKUSERNAME="${USER-}"
	[ -n "${DKUSERNAME-}" ] || export DKUSERNAME="${USERNAME-}"
	[ -n "${DKUSERNAME-}" ] || export DKUSERNAME="${LOGNAME-}"
	[ -n "${DKUSERNAME-}" ] || echo "DKUSERNAME is invalid"
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0
 
    dk_call dk_DKUSERNAME
    dk_call dk_printVar DKUSERNAME
}
