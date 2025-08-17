#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')									&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)										&& echo "BASH_EXE = ${BASH_EXE}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/DigitalKnob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_buildApp()
#
#
dk_buildApp() {
	dk_debugFunc 0

	dk_call dk_echo
	dk_call dk_echo "##################################################################"
	dk_call dk_echo "****** Building ${Target_App} - ${Target_Tuple,,} - ${Target_Type} - ${Target_Level} ******"
	dk_call dk_echo "##################################################################"
	dk_call dk_echo
	
	dk_call dk_validate DKCPP_APPS_DIR "dk_call dk_DKBRANCH_DIR"
	if [ "${Target_Type}" = "Debug" ] || [ "${Target_Type}" = "All" ]; then	
		if dk_call dk_pathExists "${DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple,,}/Debug/CMakeCache.txt"; then
			${CMAKE_EXE} --build "${DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple,,}/Debug" --verbose #--config Debug
		elif dk_call dk_pathExists "${DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple,,}/CMakeCache.txt"; then
			${CMAKE_EXE} --build "${DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple,,}" --verbose #--config Debug
		else
			dk_call dk_error "Could not find CMakeCache.txt in ${Target_App}/${Target_Tuple,,}/Debug or ${Target_App}/${Target_Tuple,,}"
		fi
	fi
	if [ "${Target_Type}" = "Release" ] || [ "${Target_Type}" = "All" ]; then
		if dk_call dk_pathExists "${DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple,,}/Release/CMakeCache.txt"; then
			${CMAKE_EXE} --build "${DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple,,}/Release" --config Release --verbose
		elif dk_call dk_pathExists "${DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple,,}/CMakeCache.txt"; then
			${CMAKE_EXE} --build "${DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple,,}" --config Release --verbose
		else
			dk_call dk_error "Could not find CMakeCache.txt in ${Target_App}/${Target_Tuple,,}/Release or ${Target_App}/${Target_Tuple,,}"
		fi
	fi
	
	dk_call dk_echo
	dk_call dk_echo "##################################################################"
	dk_call dk_echo "****** Done Building ${Target_App} - ${Target_Tuple,,} - ${Target_Type} ******"
	dk_call dk_echo "##################################################################"
	dk_call dk_echo
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_buildApp
}
