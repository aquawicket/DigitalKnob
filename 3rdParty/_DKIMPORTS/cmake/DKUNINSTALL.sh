#!/bin/bash
##################################################################################
[ -z "${DK_SH-}" ] && . ../../../DKBash/functions/DK.sh
##################################################################################


####################################################################
# DKUNINSTALL()
#
DKUNINSTALL() {
	dk_debugFunc 0
	
	########## kill cmake.exe process #########
	#dk_call dk_killProcess cmake.exe

	########## kill cmake-gui.exe process #########
	#dk_call dk_killProcess cmake-gui.exe
	
	dk_call dk_getFileParams "$(dk_call dk_dirname ${BASH_SOURCE[0]})/dkconfig.txt"
	dk_call dk_validate Host_Tuple "dk_Host_Tuple"
	cmake_Import="cmake_${Host_Tuple}_Import"
	cmake_Import="${!cmake_Import}"
	
	dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR"
	dk_call dk_importVariables ${cmake_Import} ROOT ${DKTOOLS_DIR}
	dk_call dk_assertVar CMAKE
	
	dk_call dk_delete "${CMAKE}"	
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call DKUNINSTALL
}