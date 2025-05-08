#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_validateSudo()
#
#
dk_validateSudo() {
	dk_debugFunc 0

	if command -v "sudo" >/dev/null 2>&1; then
		SUDO_EXE="sudo"
	fi
	${SUDO_EXE-} echo
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_validateSudo
}
