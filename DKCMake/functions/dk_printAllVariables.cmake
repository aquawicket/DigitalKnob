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
# dk_printAllVariables()
#
#	Print all cmake varibles and save to /cmake_variables.temp 
#
function(dk_printAllVariables)
	dk_debugFunc()
	
	set_proterty(REPORT_UNDEFINED_PROPERTIES "C:/CMAKE_REPORT_UNDEFINED_PROPERTIES.txt")
	message("")
	message("")
	message("######################## VARIABLES ########################")
	get_cmake_property(variables VARIABLES)
	list(SORT variables)
	foreach(var ${variables})
		if(NOT "${${var}}" STREQUAL "$CACHE{${var}}")
			message("${var} = '${${var}}'     ${clr}")
		endif()
	endforeach()
	
	message("")
	message("")
	message("######################## CACHE_VARIABLES ########################")
	get_cmake_property(cache_variables CACHE_VARIABLES)
	list(SORT cache_variables)
	foreach(var ${cache_variables})
		message("CACHE{${var}} = '$CACHE{${var}}'     ${clr}")
	endforeach()
	
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

endfunction()


###### Push environment variables to CMAKE CACHE_VERIABLES ######
#dk_set(dk_exec_ECHO_OUTPUT		0)
#dk_exec("${CMAKE_COMMAND}" "-E" "environment")
#string(REPLACE "\\" "{backslash}" lines "${dk_exec_stdout}")
#string(REPLACE ";" "{semicolon}" lines "${lines}")
#string(REPLACE "\n" ";" lines "${lines}")
#foreach(line ${lines})
#	string(REPLACE "=" ";" line "${line}")
#	list(POP_FRONT line var)
#	unset(${var})
#	set(${var} "$ENV{${var}}" CACHE INTERNAL "" FORCE)
#	if(NOT "${${var}}" STREQUAL "$ENV{${var}}")
#		dk_error("${var} is not equal to ENV{${var}}")
#		message("1 ${${var}}")
#		message("2 $ENV{${var}}")
#		message("")
#	endif()
#	#message("${var} = '${${var}}'     ${clr}")
#endforeach()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_printAllVariables()
endfunction()
