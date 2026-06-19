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
# dk_varToString(variable string)
#
function(dk_varToString var str)
	dk_debugFunc()

	set(tmp ${var})
	string(APPEND var_str "{${tmp}}")
	
	while(${${tmp}})
		set(tmp ${${tmp}})
		string(APPEND var_str ":{${tmp}}")
	endwhile()
	
	string(APPEND var_str " = ${${tmp}}")
	
	set(${str} "${var_str}" PARENT_SCOPE)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(varC "string value")
	dk_varToString(varC varC_str)
	dk_echo("${varC_str}")
	
	set(varB varC)
	dk_varToString(varB varB_str)
	dk_echo("${varB_str}")
	
	set(varA varB)
	dk_varToString(varA varA_str)
	dk_echo("${varA_str}")
endfunction()
