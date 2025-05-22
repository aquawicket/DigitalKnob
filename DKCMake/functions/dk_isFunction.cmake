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

##############################################################################
# dk_isFunction(arg)
# 
#	Test if a string is a function
#
#	@arg			- The argument to test
#	@dk_isFunction 	- 1 if arg is a function, 0 if otherwise.
#
function(dk_isFunction)
	dk_debugFunc(1)
	
	dk_getArg(0 _arg0_)
	
	if(COMMAND "${_arg0_}")
		get_directory_property(macros MACROS)
		if(NOT "${_arg0_}" IN_LIST macros)
			set(dk_isFunction 1 PARENT_SCOPE)
		else()
			set(dk_isFunction 0 PARENT_SCOPE)
		endif()
	else()
		set(dk_isFunction 0 PARENT_SCOPE)
	endif()
endfunction()









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(test_function)
	dk_echo("test_function body")
endfunction()

function(DKTEST)
	dk_debugFunc(0)
	
	dk_isFunction("test_function")
	if(dk_isFunction)
		dk_echo("'test_function' is a function")
	else()
		dk_echo("'test_function' is NOT a function")
	endif()
	
	dk_isFunction("nonExistentFunction")
	if(dk_isFunction)
		dk_echo("'nonExistentFunction' is a function")
	else()
		dk_echo("'nonExistentFunction' is NOT a function")
	endif()
endfunction()
