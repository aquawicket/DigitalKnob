#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_buildApp()
#
#
function(dk_buildApp)
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
		endif()
	endif()
	
	dk_echo()
	dk_echo("####################################################################################")
	dk_echo("****** Done Building ${target_app} - ${target_triple} - ${target_type} - ${target_level} ******")
	dk_echo("####################################################################################")
	dk_echo()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_buildApp()
endfunction()
