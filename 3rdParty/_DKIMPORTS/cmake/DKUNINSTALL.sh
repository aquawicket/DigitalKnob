#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)      || export PATH=/bin
	(command -v 'cygpath' 1>/dev/null) && HOME=$(cygpath -u $USERPROFILE)                                 && echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null) && CMD_EXE=$(command -v 'cmd.exe')                                 && echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]            && USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')      && echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null) && HOME=$(wslpath -u ${USERPROFILE})                               && echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)    && export BASH_EXE=$(command -v bash)                              && echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH=$(find "${HOME}" -name "DK.sh")                    && echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]               && exec "${BASH_EXE}" "${DK_SH}" "$0" $* || exec "${DK_SH}" "$0" $*
fi
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