#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


################################################################################
# dk_freshRun(command)
#
#	Clean the environment variable and replace the current process with a command 
#
dk_freshRun() {
	dk_debugFunc 1

	dk_call dk_clearScreen
	cmnd="${1}"
	exec env -i HOME="$HOME" PATH="$PATH" DKBASH_FUNCTIONS_DIR_="$DKBASH_FUNCTIONS_DIR_" cmnd="$cmnd" bash -l -c '${cmnd}'
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_freshRun "${DKSCRIPT_PATH}"
}
