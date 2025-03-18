#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_set(variable value)
#	
#	https://stackoverflow.com/a/29250496/688352
#
#	@variable	- The name of a variable to declair
#	@value		- The value to set the variable to. 
#
function(dk_set variable) #, value)
	dk_debugFunc(2 256)
	
	if(${ARGC} LESS 2)
		dk_fatal("dk_set(${ARGV}): not enough arguments, expected at least 2, got ${ARGC}")
	endif()
	
	#set(${ARGV} CACHE INTERNAL "" FORCE) # The $CACHE{VAR} syntax can be used to do direct cache entry lookups
	set(${ARGV0} "${ARGN}" CACHE INTERNAL "" FORCE) # The $CACHE{VAR} syntax can be used todo direct cache entry lookups
	set(ENV{${ARGV0}} "${ARGN}")
	
#	dk_printVar(${ARGV0})
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_set(myVariable "this is the string value of myVariable")
	dk_printVar(myVariable)
endfunction()
