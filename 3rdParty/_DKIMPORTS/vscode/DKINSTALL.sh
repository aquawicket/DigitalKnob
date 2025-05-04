#!/usr/bin/env sh
#######################################################
[ -z "${DK_SH-}" ] && . ../../../DKBash/functions/DK.sh
#######################################################


####################################################################
# DKINSTALL()
#
DKINSTALL() {
	#dk_call dk_debugFunc 0

	dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR"
	dk_call dk_dirname "$0"
	dk_call dk_echo "${dk_dirname}INSTALL.cmake"
	dk_call dk_cmakeEval "dk_load('%~dp0DKINSTALL.cmake')"
	
}