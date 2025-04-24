#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

##################################################################################
# dk_buildApp()
#
#
function(dk_buildApp)
<<<<<<< HEAD
	dk_debugFunc()

	dk_echo()
	dk_echo("##################################################################")
	dk_echo("****** Building ${APP} - ${triple} - ${TYPE} - ${DKLEVEL} ******")
	dk_echo("##################################################################")
	dk_echo()
	
	dk_validate(DKAPPS_DIR "dk_DKAPPS_DIR")
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
=======
	dk_debugFunc(0)

	dk_echo()
	dk_echo("###############################################################################")
	dk_echo("****** Building ${target_app} - ${target_triple} - ${target_type} - ${target_level} ******")
	dk_echo("###############################################################################")
	dk_echo()
	
	dk_validate(DKCPP_APPS_DIR "dk_DKBRANCH_DIR()")
	if(("${target_type}" STREQUAL "Debug") OR ("${target_type}" STREQUAL "All"))
		if(EXISTS "$ENV{DKCPP_APPS_DIR}/${target_app}/${target_triple}/Debug/CMakeCache.txt")
			execute_process(COMMAND ${CMAKE_EXE} --build "$ENV{DKCPP_APPS_DIR}/${target_app}/${target_triple}/Debug" --verbose) #--config Debug
		elseif(EXISTS "$ENV{DKCPP_APPS_DIR}/${target_app}/${target_triple}/CMakeCache.txt")
			execute_process(COMMAND ${CMAKE_EXE} --build "$ENV{DKCPP_APPS_DIR}/${target_app}/${target_triple}" --verbose) #--config Debug
		else()
			dk_error("Could not find CMakeCache.txt in ${target_app}/${target_triple}/Debug or ${target_app}/${target_triple}")
		endif()
	endif()
	if(("${target_type}" STREQUAL "Release") OR ("${target_type}" STREQUAL "All"))
		if(EXISTS "$ENV{DKCPP_APPS_DIR}/${target_app}/${target_triple}/Release/CMakeCache.txt")
			execute_process(COMMAND ${CMAKE_EXE} --build "$ENV{DKCPP_APPS_DIR}/${target_app}/${target_triple}/Release" --config Release --verbose)
		elseif(EXISTS "$ENV{DKCPP_APPS_DIR}/${target_app}/${target_triple}/CMakeCache.txt")
			execute_process(COMMAND ${CMAKE_EXE} --build "$ENV{DKCPP_APPS_DIR}/${target_app}/${target_triple}" --config Release --verbose)
		else()
			dk_error("Could not find CMakeCache.txt in ${target_app}/${target_triple}/Release or ${target_app}/${target_triple}")
>>>>>>> Development
		endif()
	endif()
	
	dk_echo()
<<<<<<< HEAD
	dk_echo("##################################################################")
	dk_echo("****** Done Building ${APP} - ${triple} - ${TYPE} - ${DKLEVEL} ******")
	dk_echo("##################################################################")
=======
	dk_echo("####################################################################################")
	dk_echo("****** Done Building ${target_app} - ${target_triple} - ${target_type} - ${target_level} ******")
	dk_echo("####################################################################################")
>>>>>>> Development
	dk_echo()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_buildApp()
endfunction()
