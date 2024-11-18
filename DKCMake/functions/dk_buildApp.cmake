#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_buildApp()
#
#
function(dk_buildApp)
	dk_debugFunc(0)

	dk_echo()
	dk_echo("##################################################################")
	dk_echo("****** Building ${APP} - ${triple} - ${TYPE} - ${DKLEVEL} ******")
	dk_echo("##################################################################")
	dk_echo()
	
	dk_validate(DKAPPS_DIR "dk_DKAPPS_DIR()")
	if(("${TYPE}" STREQUAL "Debug") OR ("${TYPE}" STREQUAL "All"))
		if(EXISTS "${DKAPPS_DIR}/${APP}/${triple}/Debug/CMakeCache.txt")
			execute_command(${CMAKE_EXE} --build "${DKAPPS_DIR}/${APP}/${triple}/Debug" --verbose) #--config Debug
		elseif(EXISTS "${DKAPPS_DIR}/${APP}/${triple}/CMakeCache.txt")
			execute_process(${CMAKE_EXE} --build "${DKAPPS_DIR}/${APP}/${triple}" --verbose) #--config Debug
		else()
			dk_error("Could not find CMakeCache.txt in ${APP}/${triple}/Debug or ${APP}/${triple}")
		endif()
	endif()
	if(("${TYPE}" STREQUAL "Release") OR ("${TYPE}" STREQUAL "All"))
		if(EXISTS "${DKAPPS_DIR}/${APP}/${triple}/Release/CMakeCache.txt")
			execute_process(${CMAKE_EXE} --build "${DKAPPS_DIR}/${APP}/${triple}/Release" --config Release --verbose)
		elseif(EXISTS "${DKAPPS_DIR}/${APP}/${triple}/CMakeCache.txt")
			execute_process(${CMAKE_EXE} --build "${DKAPPS_DIR}/${APP}/${triple}" --config Release --verbose)
		else()
			dk_error("Could not find CMakeCache.txt in ${APP}/${triple}/Release or ${APP}/${triple}")
		endif()
	endif()
	
	dk_echo()
	dk_echo("##################################################################")
	dk_echo("****** Done Building ${APP} - ${triple} - ${TYPE} - ${DKLEVEL} ******")
	dk_echo("##################################################################")
	dk_echo()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_buildApp()
endfunction()
