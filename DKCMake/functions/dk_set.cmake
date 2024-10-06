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
	dk_debugFunc("\${ARGV}")
	
	if(${ARGC} LESS 1)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): not enough arguments")
	endif()
	if(${ARGC} LESS 2)
		dk_warning("${CMAKE_CURRENT_FUNCTION}(${ARGV}): expecting more arguments")
	endif()
	#if(${ARGC} GREATER 2)
	#	dk_warning("${CMAKE_CURRENT_FUNCTION}(${ARGV}): expecting less arguments")
	#endif()
	
	
	set(${ARGV} CACHE INTERNAL "" FORCE) # The $CACHE{VAR} syntax can be used to do direct cache entry lookups
	#set(ENV{${ARGV0}} "${ARGV1}")	# Set as environment variable
	
	#dk_printVar(${ARGV0})
endfunction()
dk_createOsMacros("dk_set")





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_set(myVariable "this is the string value of myVariable")
	dk_info("myVariable = ${myVariable}")
endfunction()
