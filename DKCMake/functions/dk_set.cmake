#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include(${DKCMAKE_FUNCTIONS_DIR}/dk_createOsMacros.cmake)
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
>>>>>>> Development
#include_guard()

###############################################################################
# dk_set(variable value)
#	
#	https://stackoverflow.com/a/29250496/688352
#
<<<<<<< HEAD
#	@variable	- The name of a variable to declair
#	@value		- The value to set the variable to. 
#
function(dk_set variable)# value)
	dk_debugFunc()
	
	if(${ARGC} LESS 1)
		dk_fatal("dk_set(${ARGV}): not enough arguments")
	endif()
	if(${ARGC} LESS 2)
		dk_warning("dk_set(${ARGV}): expecting more arguments")
	endif()
	#if(${ARGC} GREATER 2)
	#	dk_warning("dk_set(${ARGV}): expecting less arguments")
	#endif()
	
	set(${ARGV} CACHE INTERNAL "" FORCE) # The $CACHE{VAR} syntax can be used to do direct cache entry lookups
	#dk_printVar(${ARGV0})
endfunction()
dk_createOsMacros("dk_set")
=======
#	@variable	The name of a variable to declair
#	@value		The value to set the variable to. 
#
function(dk_set variable) #, value)
	dk_debugFunc(2 256)

	if(${ARGC} LESS 2)
		dk_fatal("dk_set(${ARGV}): not enough arguments, expected at least 2, got ${ARGC}")
	endif()

	string(REPLACE "ENV{" "" VAR "${ARGV0}")
	string(REPLACE "CACHE{" "" VAR "${VAR}")
	string(REPLACE "}" "" VAR "${VAR}")

	set(${VAR} "${ARGN}" CACHE INTERNAL "" FORCE) # The $CACHE{VAR} syntax can be used to do direct cache entry lookups
	set(ENV{${VAR}} "${ARGN}")

	#dk_printVar(ENV{${VAR}})
endfunction()

>>>>>>> Development





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_set(myVariable "this is the string value of myVariable")
	dk_info("myVariable = ${myVariable}")
=======
	dk_debugFunc(0)

	dk_set(myVariableA "String Value of myVariableA")
	dk_echo("myVariableA = ${myVariableA}")

	dk_set(ENV{myVariableB} "String Value of myVariableB")
	dk_echo("ENV{myVariableB} = $ENV{myVariableB}")

	dk_set(CACHE{myVariableC} "String Value of myVariableC")
	dk_echo("CACHE{myVariableC} = $CACHE{myVariableC}")

	dk_set(myVariableA "String Value of myVariableA2")
	dk_echo("myVariableA = ${myVariableA}")
	
	dk_set(ENV{myVariableB} "String Value of myVariableB2")
	dk_echo("ENV{myVariableB} = $ENV{myVariableB}")

	dk_set(CACHE{myVariableC} "String Value of myVariableC2")
	dk_echo("CACHE{myVariableC} = $CACHE{myVariableC}")
>>>>>>> Development
endfunction()
