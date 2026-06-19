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
# dk_cacheEnvVariables(args)
#
#	Copy all Environment variables to CACHE variables.
#
#
function(dk_cacheEnvVariables)
	#dk_set(dk_exec_ECHO_OUTPUT		0)
	execute_process(COMMAND "${CMAKE_COMMAND}" "-E" "environment" OUTPUT_VARIABLE env_vars)
	string(REPLACE "\\" "{backslash}" lines "${env_vars}")
	string(REPLACE ";" "{semicolon}" lines "${lines}")
	string(REPLACE "\n" ";" lines "${lines}")
	list(SORT lines)
	foreach(line ${lines})
		string(REPLACE "=" ";" line "${line}")
		list(POP_FRONT line var)

		if(NOT DEFINED CACHE{${var}})
			set(${var} "$ENV{${var}}" CACHE INTERNAL "" FORCE)
			if(NOT "${${var}}" STREQUAL "$ENV{${var}}")
				message(ERROR "${var} is not equal to ENV{${var}}")
				message("1 ${${var}}")
				message("2 $ENV{${var}}")
				message("")
			endif()
			
			cmake_path(CONVERT "${${var}}" TO_CMAKE_PATH_LIST ${var} NORMALIZE)
			set(${var} "${${var}}" CACHE INTERNAL "" FORCE)
			unset(${var})
			if(NOT "${${var}}" STREQUAL "$CACHE{${var}}")
				message(ERROR: "${var} is not equal to CACHE{${var}}")
				message("1 ${${var}}")
				message("2 $CACHE{${var}}")
				message("")
			endif()
			
			message("${var} = '$CACHE{${var}}'     ${clr}")
		endif()
	endforeach()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_cacheEnvVariables()
	message("USERPROFILE = ${USERPROFILE}")
	message("ComSpec = ${ComSpec}")
endfunction()

