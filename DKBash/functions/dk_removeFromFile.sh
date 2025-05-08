#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################



##################################################################################
# dk_removeFromFile(<string> <file>)
#
#
dk_removeFromFile() {
	dk_debugFunc 2


	sed -i -e "/${1}/d" ${2}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	dk_removeFromFile
}