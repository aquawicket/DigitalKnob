#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
#include_guard()

###############################################################################
# dk_set(variable value)
#	
#	https://stackoverflow.com/a/29250496/688352
#
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






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
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
endfunction()
