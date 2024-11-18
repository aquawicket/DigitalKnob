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
	dk_echo("###############################################################################")
	dk_echo("****** Building ${APP} - ${target_triple} - ${DKBUILD_TYPE} - ${DKLEVEL} ******")
	dk_echo("###############################################################################")
	dk_echo()
	
	dk_validate(DKAPPS_DIR "dk_DKAPPS_DIR()")
	if(("${DKBUILD_TYPE}" STREQUAL "Debug") OR ("${DKBUILD_TYPE}" STREQUAL "All"))
		if(EXISTS "${DKAPPS_DIR}/${APP}/${target_triple}/Debug/CMakeCache.txt")
			execute_process(COMMAND ${CMAKE_EXE} --build "${DKAPPS_DIR}/${APP}/${target_triple}/Debug" --verbose) #--config Debug
		elseif(EXISTS "${DKAPPS_DIR}/${APP}/${target_triple}/CMakeCache.txt")
			execute_process(COMMAND ${CMAKE_EXE} --build "${DKAPPS_DIR}/${APP}/${target_triple}" --verbose) #--config Debug
		else()
			dk_error("Could not find CMakeCache.txt in ${APP}/${target_triple}/Debug or ${APP}/${target_triple}")
		endif()
	endif()
	if(("${DKBUILD_TYPE}" STREQUAL "Release") OR ("${DKBUILD_TYPE}" STREQUAL "All"))
		if(EXISTS "${DKAPPS_DIR}/${APP}/${target_triple}/Release/CMakeCache.txt")
			execute_process(COMMAND ${CMAKE_EXE} --build "${DKAPPS_DIR}/${APP}/${target_triple}/Release" --config Release --verbose)
		elseif(EXISTS "${DKAPPS_DIR}/${APP}/${target_triple}/CMakeCache.txt")
			execute_process(COMMAND ${CMAKE_EXE} --build "${DKAPPS_DIR}/${APP}/${target_triple}" --config Release --verbose)
		else()
			dk_error("Could not find CMakeCache.txt in ${APP}/${target_triple}/Release or ${APP}/${target_triple}")
		endif()
	endif()
	
	dk_echo()
	dk_echo("####################################################################################")
	dk_echo("****** Done Building ${APP} - ${target_triple} - ${DKBUILD_TYPE} - ${DKLEVEL} ******")
	dk_echo("####################################################################################")
	dk_echo()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_buildApp()
endfunction()
