#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include(${DKCMAKE_FUNCTIONS_DIR}/dk_createOsMacros.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_unset(variable)
#
#	https://cmake.org/cmake/help/latest/command/unset.html
#
#	Remove a variable definition. will become undefined. 
#
#	@variable	- The name of the variable to unset
#
function(dk_unset variable)
	dk_debugFunc()
	
	#if(DEFINED ENV{${variable}})
	#	unset(${variable} ENV)
	#endif()
	if(DEFINED CACHE{${variable}})  # The $CACHE{VAR} syntax can be used to do direct cache entry lookups
		unset(${variable} CACHE)
	endif()
	if(DEFINED ${variable})
		unset(${variable})
	endif()
	unset(${variable} PARENT_SCOPE)
	
endfunction()
<<<<<<< HEAD
dk_createOsMacros("dk_unset")
=======
#dk_createOsMacros("dk_unset")
>>>>>>> Development




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	set(myVar "value of myVar")
	dk_printVar(myVar)
	if(myVar)
		dk_info("if(myVar) is true")
	else()
		dk_info("if(myVar) is false")
	endif()
	
	dk_unset(myVar)
	dk_printVar(myVar)
	if(myVar)
		dk_info("if(myVar) is true")
	else()
		dk_info("if(myVar) is false")
	endif()
endfunction()