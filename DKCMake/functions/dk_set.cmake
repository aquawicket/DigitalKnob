#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include(${DKCMAKE_FUNCTIONS_DIR}/dk_createOsMacros.cmake)
#include_guard()

###############################################################################
# dk_set(variable value)
#	
#	https://stackoverflow.com/a/29250496/688352
#
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
	
	set(${ARGV} CACHE INTERNAL "" FORCE) # The $CACHE{VAR} syntax can be used todo direct cache entry lookups
	
	set(ENV{${ARGV0}} "${ARGN}")
	#dk_printVar(${ARGV0})
endfunction()
dk_createOsMacros("dk_set")





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_set(myVariable "this is the string value of myVariable")
	dk_printVar(myVariable)
endfunction()
