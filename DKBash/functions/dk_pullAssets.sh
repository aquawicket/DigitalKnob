#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"


##################################################################################
# dk_pullAssets()
#
#
dk_pullAssets() {
	dk_debugFunc 0

	
	dk_confirm || return 0

	dk_error "not implemented,  TODO"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	dk_pullAssets
}