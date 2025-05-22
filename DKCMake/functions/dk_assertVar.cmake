#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_assertVar(variable)
#
#	If the variable compares equal to false (i.e., the variable is false), a error message is written and abort is called, terminating the scripts execution.
#
#	@variable:  The variable to be evaluated. If this variable evaluates to false, this causes an assertion
#
function(dk_assertVar)
	dk_debugFunc(1)
	set(variable ${ARGV0})
	
	###### Scoped Variable ######
	if(NOT DEFINED ${variable})
		dk_echo("\n\n${bg_red}${white}Variable Assertion${clr}")
		dk_fatal("${variable} not defined")
	endif()
	
	###### Global Variable ######
	if(DEFINED CACHE{${variable}})
		if(NOT "${${variable}}" STREQUAL "$CACHE{${variable}}")	### Do {variable} and CACHE{variable} match ?
			dk_echo("\n\n${bg_red}${white}Variable Assertion${clr}")
			dk_fatal("${variable}:'${${variable}}' != CACHE:${variable}:'$CACHE{${variable}}'")
		endif()
	#else()
	#	dk_echo("\n\n${bg_red}${white}Variable Assertion${clr}")
	#	dk_fatal("CACHE:${variable} not defined")
	endif()
	
	###### Global Environment Variable ######
	if(DEFINED ENV{${variable}})
		if(NOT "${${variable}}" STREQUAL "$ENV{${variable}}")	### Do {variable} and ENV{variable} match ?
			dk_echo("\n\n${bg_red}${white}Variable Assertion${clr}")
			dk_fatal("${variable}:'${${variable}}' != ENV:${variable}:'$ENV{${variable}}'")
		endif()
	#else()
	#	dk_echo("\n\n${bg_red}${white}Variable Assertion${clr}")
	#	dk_fatal("ENV:${variable} not defined")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(varA "varA_value")
	dk_assertVar(varA)
	
	set(varB "varB_value" CACHE INTERNAL "")
	dk_assertVar(varB)
	
	dk_set(varC "varC_value")
	dk_assertVar(varC)
	
	dk_set(varD "")
	dk_unset(varD)
	dk_assertVar(varD)

endfunction()
