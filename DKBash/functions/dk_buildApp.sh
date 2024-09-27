#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_buildApp()
#
#
dk_buildApp() {
	dk_debugFunc 0

	dk_call dk_echo
	dk_call dk_echo "##################################################################"
	dk_call dk_echo "****** Building ${APP} - ${TARGET_OS} - ${TYPE} - ${DKLEVEL} ******"
	dk_call dk_echo "##################################################################"
	dk_call dk_echo
	
	if [ "${TYPE}" = "Debug" ] || [ "${TYPE}" = "All" ]; then
		if dk_call dk_pathExists "${DKAPPS_DIR}/${APP}/${TARGET_OS}/Debug/CMakeCache.txt"; then
			dk_call dk_call ${CMAKE_EXE} "--build" "${DKAPPS_DIR}/${APP}/${TARGET_OS}/Debug" "--config Debug" "--verbose"
		elif dk_call dk_pathExists "${DKAPPS_DIR}/${APP}/${TARGET_OS}/CMakeCache.txt"; then
			dk_call dk_call ${CMAKE_EXE} "--build" "${DKAPPS_DIR}/${APP}/${TARGET_OS}" "--config Debug" "--verbose"
		else
			dk_call dk_error "Could not find CMakeCache.txt in ${APP}/${TARGET_OS}/Debug or ${APP}/${TARGET_OS}"
		fi
	fi
	if [ "${TYPE}" = "Release" ] || [ "${TYPE}" = "All" ]; then
		if dk_call dk_pathExists "${DKAPPS_DIR}/${APP}/${TARGET_OS}/Release/CMakeCache.txt"; then
			dk_call dk_call ${CMAKE_EXE} --build "${DKAPPS_DIR}/${APP}/${TARGET_OS}/Release" --config Release --verbose
		elif dk_call dk_pathExists "${DKAPPS_DIR}/${APP}/${TARGET_OS}/CMakeCache.txt"; then
			dk_call dk_call ${CMAKE_EXE} --build "${DKAPPS_DIR}/${APP}/${TARGET_OS}" --config Release --verbose
		else
			dk_call dk_error "Could not find CMakeCache.txt in ${APP}/${TARGET_OS}/Release or ${APP}/${TARGET_OS}"
		fi
	fi
	
	dk_call dk_echo
	dk_call dk_echo "##################################################################"
	dk_call dk_echo "****** Done Building ${APP} - ${TARGET_OS} - ${TYPE} - ${DKLEVEL} ******"
	dk_call dk_echo "##################################################################"
	dk_call dk_echo
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_buildApp
}
