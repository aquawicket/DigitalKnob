#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_pullAssets()
#
#
dk_pullAssets () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	
	dk_confirm || return 0

	dk_error "not implemented,  TODO"
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_pullAssets
}