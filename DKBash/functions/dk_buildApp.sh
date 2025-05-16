#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
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
