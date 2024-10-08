#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

####################################################################
# dk_DKUSERNAME()
#
#
dk_DKUSERNAME() {
    dk_debugFunc 0

	[ ! -n "${DKUSERNAME-}" ] && [ -n "${USER-}" ] 		&& export DKUSERNAME="${USER-}"
	[ ! -n "${DKUSERNAME-}" ] && [ -n "${USERNAME-}" ] 	&& export DKUSERNAME="${USERNAME-}"
	[ ! -n "${DKUSERNAME-}" ] && echo "DKUSERNAME is invalid"
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0
 
    dk_call dk_DKUSERNAME
    dk_call dk_printVar DKUSERNAME
}
