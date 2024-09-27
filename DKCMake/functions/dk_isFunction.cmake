#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##############################################################################
# dk_isFunction(name rtn_var)
# 
#	Test if a string is a function name
#
#	@name	- The name to test
#	@rtn_var: 	- True if the string is the name of a function, False if otherwise.
#
function(dk_isFunction name rtn_var)
	dk_debugFunc("\${ARGV}")
	
	
	if(COMMAND ${name})
		set(isFunction 1)
	else()
		set(isFunction 0)
	endif()
	
	#dk_printVar(isFunction)
	set(${rtn_var} ${isFunction} PARENT_SCOPE)
endfunction()



function(test_function)
	dk_info("...")
endfunction()

###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_echo("testing dk_isFunction(test_function)")
	dk_isFunction("test_function" isFunction)
	dk_info("isFunction = ${isFunction}")
	
	dk_echo("testing dk_isFunction(nonExistentFunction)")
	dk_isFunction("nonExistentFunction" isFunction)
	dk_info("isFunction = ${isFunction}")
endfunction()
