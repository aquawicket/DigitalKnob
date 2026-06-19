#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# dk_printEnvVariables()
#
#	Print all Environment varibles
#
function(dk_printEnvVariables)
	dk_debugFunc()
	
	message("")
	message("")
	message("######################## ENV_VARIABLES ########################")
	dk_set(dk_exec_ECHO_OUTPUT		0)
	dk_exec("${CMAKE_COMMAND}" "-E" "environment")
	string(REPLACE "\\" "{backslash}" lines "${dk_exec_stdout}")
	string(REPLACE ";" "{semicolon}" lines "${lines}")
	string(REPLACE "\n" ";" lines "${lines}")
	foreach(line ${lines})
		string(REPLACE "=" ";" line "${line}")
		list(POP_FRONT line var)
		message("ENV{${var}} = '$ENV{${var}}'     ${clr}")
	endforeach()
	message("#################### END ENV_VARIABLES ########################")

endfunction()









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_printEnvVariables()
endfunction()
