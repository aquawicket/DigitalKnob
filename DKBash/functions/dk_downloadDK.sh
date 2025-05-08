#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


################################################################################
# dk_downloadDK()
#
#
dk_downloadDK() {
	dk_debugFunc 0

	dk_call dk_download "https://github.com/aquawicket/DigitalKnob/archive/refs/heads/Development.zip"
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_downloadDK
}
