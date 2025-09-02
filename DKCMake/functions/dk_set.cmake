#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################

#if(NOT DEFINED dk_set_DEBUG)
#	set(dk_set_DEBUG 1)
#endif()
#########################################################################
# dk_set(variable value)
#	
#	https://stackoverflow.com/a/29250496/688352
#
#	@variable	The name of a variable to declair
#	@value		The value to set the variable to. 
#
function(dk_set variable) #, value)
	if(COMMAND dk_debugFunc)
		dk_debugFunc(2 256)
	endif()

	if(${ARGC} LESS 2)
		dk_fatal("dk_set(${ARGV}): not enough arguments, expected at least 2, got ${ARGC}")
	endif()

	string(REPLACE "ENV{" "" Var "${ARGV0}")
	string(REPLACE "CACHE{" "" Var "${Var}")
	string(REPLACE "}" "" Var "${Var}")

	set(${Var} "${ARGN}" PARENT_SCOPE)
	set(${Var} "${ARGN}" CACHE INTERNAL "" FORCE) # The $CACHE{Var} syntax can be used to do direct cache entry lookups
	set(ENV{${Var}} "${ARGN}")
	
	#dk_debug("${Var} = ${${Var}}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_set(myVariableA "String Value of myVariableA")
	dk_echo("myVariableA = ${myVariableA}")

#	dk_set(myVariableB "String Value of myVariableB")
#	dk_echo("ENV{myVariableB} = $ENV{myVariableB}")

#	dk_set(CACHE{myVariableC} "String Value of myVariableC")
#	dk_echo("CACHE{myVariableC} = $CACHE{myVariableC}")

#	dk_set(myVariableA "String Value of myVariableA2")
#	dk_echo("myVariableA = ${myVariableA}")
	
#	dk_set(myVariableB "String Value of myVariableB2")
#	dk_echo("ENV{myVariableB} = $ENV{myVariableB}")

#	dk_set(CACHE{myVariableC} "String Value of myVariableC2")
#	dk_echo("CACHE{myVariableC} = $CACHE{myVariableC}")
endfunction()
