#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


####################################################################
# dk_SUDO_EXE()
#
#
dk_SUDO_EXE(){
	(command -v sudo) && export SUDO_EXE=$(command -v sudo) || echo "sudo Not Found" >&2
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0
 
    dk_call dk_SUDO_EXE
    dk_call dk_printVar SUDO_EXE
}
