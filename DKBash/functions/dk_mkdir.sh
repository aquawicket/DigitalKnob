#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################



#####################################################################
# dk_mkdir(<path>)
#
#
dk_mkdir() {
	dk_debugFunc 1

	
	mkdir -p "${1}"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	dk_mkdir test
}