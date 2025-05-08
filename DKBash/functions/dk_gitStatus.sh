#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


################################################################################
# dk_gitStatus()
#
#
dk_gitStatus() {
	dk_debugFunc 0
  
	dk_call dk_validate GIT_EXE "dk_call dk_installGit"
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
    "${GIT_EXE}" -C ${DKBRANCH_DIR} status
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_gitStatus
}
