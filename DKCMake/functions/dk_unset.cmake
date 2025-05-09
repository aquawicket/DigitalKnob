#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

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
	
	if(DEFINED ENV{${variable}})
		unset(ENV{${variable}})
	endif()
	if(DEFINED CACHE{${variable}})  # The $CACHE{VAR} syntax can be used to do direct cache entry lookups
		unset(${variable} CACHE)
	endif()
	if(DEFINED ${variable})
		unset(${variable})
	endif()
	unset(${variable} PARENT_SCOPE)
	
endfunction()
#dk_createOsMacros("dk_unset")




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_set(myVar "value of myVar")
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