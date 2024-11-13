#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_isList(result arg(s))
#
#	@rtn_var     - returns true is the arg(s) is a list, false if not
#	@arg		- The input argument(s) to be examined 
#
function(dk_isList rtn_var)
	dk_debugFunc()

	set(${rtn_var} 0 PARENT_SCOPE)
	if(DEFINED "${ARGV1}")
		dk_getArgCount(count ${${ARGN}})
		if(${count} GREATER 1)
			set(${rtn_var} 1 PARENT_SCOPE)
		endif()
	elseif(NOT "${ARGN}" STREQUAL "")
		dk_getArgCount(count ${ARGN})
		if(${count} GREATER 1)
			set(${rtn_var} 1 PARENT_SCOPE)
		endif()
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	list(APPEND myList "myList item 0")
	list(APPEND myList "myList item 1")
	list(APPEND myList "myList item 2")
	dk_isList(isList myList)
	if(isList)
		dk_echo("'myList' is a list")
	else()
		dk_echo("'myList' is NOT a list")
	endif()
	
	string(APPEND myString "Hello ")
	string(APPEND myString "World")
	dk_isList(isList myString)
	if(isList)
		dk_echo("'myString' is a list")
	else()
		dk_echo("'myString' is NOT a list")
	endif()
	
	dk_isList(isList "abc;123;456")
	if(isList)
		dk_echo("'abc;123;456' is a list")
	else()
		dk_echo("'abc;123;456' is NOT a list")
	endif()
	
	dk_isList(isList "Hello World")
	if(isList)
		dk_echo("'Hello World' is a list")
	else()
		dk_echo("'Hello World' is NOT a list")
	endif()
endfunction()