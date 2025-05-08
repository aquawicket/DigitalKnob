#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################



##################################################################################
# dk_pushAssets()
#
#
dk_pushAssets() {
	dk_debugFunc 0

	
	dk_confirm || return 0
	
	dk_error "not implemented,  TODO"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	dk_pushAssets
}