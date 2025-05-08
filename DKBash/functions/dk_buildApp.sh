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
	dk_call dk_echo "****** Building ${target_app} - ${target_triple,,} - ${target_type} - ${target_level} ******"
	dk_call dk_echo "##################################################################"
	dk_call dk_echo
	
	dk_call dk_validate DKCPP_APPS_DIR "dk_call dk_DKBRANCH_DIR"
	if [ "${target_type}" = "Debug" ] || [ "${target_type}" = "All" ]; then	
		if dk_call dk_pathExists "${DKCPP_APPS_DIR}/${target_app}/${target_triple,,}/Debug/CMakeCache.txt"; then
			${CMAKE_EXE} --build "${DKCPP_APPS_DIR}/${target_app}/${target_triple,,}/Debug" --verbose #--config Debug
		elif dk_call dk_pathExists "${DKCPP_APPS_DIR}/${target_app}/${target_triple,,}/CMakeCache.txt"; then
			${CMAKE_EXE} --build "${DKCPP_APPS_DIR}/${target_app}/${target_triple,,}" --verbose #--config Debug
		else
			dk_call dk_error "Could not find CMakeCache.txt in ${target_app}/${target_triple,,}/Debug or ${target_app}/${target_triple,,}"
		fi
	fi
	if [ "${target_type}" = "Release" ] || [ "${target_type}" = "All" ]; then
		if dk_call dk_pathExists "${DKCPP_APPS_DIR}/${target_app}/${target_triple,,}/Release/CMakeCache.txt"; then
			${CMAKE_EXE} --build "${DKCPP_APPS_DIR}/${target_app}/${target_triple,,}/Release" --config Release --verbose
		elif dk_call dk_pathExists "${DKCPP_APPS_DIR}/${target_app}/${target_triple,,}/CMakeCache.txt"; then
			${CMAKE_EXE} --build "${DKCPP_APPS_DIR}/${target_app}/${target_triple,,}" --config Release --verbose
		else
			dk_call dk_error "Could not find CMakeCache.txt in ${target_app}/${target_triple,,}/Release or ${target_app}/${target_triple,,}"
		fi
	fi
	
	dk_call dk_echo
	dk_call dk_echo "##################################################################"
	dk_call dk_echo "****** Done Building ${target_app} - ${target_triple,,} - ${target_type} ******"
	dk_call dk_echo "##################################################################"
	dk_call dk_echo
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_buildApp
}
