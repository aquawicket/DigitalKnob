#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_fileWrite(<file> <string>)
#
#
dk_fileWrite() {
	dk_debugFunc 2

	builtin echo "${2}" > "${1}"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	dk_call dk_fileWrite "dk_fileWrite_TEST.txt" "string written by dk_fileWrite"
}
