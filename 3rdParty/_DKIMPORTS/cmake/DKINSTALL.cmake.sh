#!/usr/bin/env sh
##################################################################################
[ -z "${DK_SH-}" ] && . ../../../DKBash/functions/DK.sh
##################################################################################


##################################################################################
# DKINSTALL()
#
DKINSTALL() {
	
#	dk_call dk_debugFunc 0

	dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR"
	dk_dirname=$(dk_call dk_dirname "$0")
	dk_call dk_echo "${dk_dirname}/DKINSTALL.cmake"
	#dk_call dk_pause
	dk_call dk_cmakeEval "dk_load('DKINSTALL.cmake')" "CMAKE_EXE"
	dk_call dk_assertPath CMAKE_EXE
	export CMAKE_EXE=${CMAKE_EXE}
	#
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

#	dk_call dk_debugFunc 0
	
	DKINSTALL
}