#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_pushAssets()
#
#
dk_pushAssets() {
	dk_debugFunc 0

	
	dk_confirm || return 0
	
	dk_error "not implemented,  TODO"
}



DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######

	dk_pushAssets
}