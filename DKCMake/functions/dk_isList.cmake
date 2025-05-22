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

###############################################################################
# dk_isList(arg)
#
#	Test if (arg) is a list
#
#	@arg		- The argument to test
#	@dk_isList	- 1 if arg is a list, 0 if otherwise.
#
function(dk_isList)
	dk_debugFunc()

	dk_getArg(0 _arg0_)
	
	dk_getArgCount(count ${_arg0_})
	if(${count} GREATER 1)
		set(dk_isList 1 PARENT_SCOPE)
	else()
		set(dk_isList 0 PARENT_SCOPE)
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	list(APPEND myList "myList item 0")
	list(APPEND myList "myList item 1")
	list(APPEND myList "myList item 2")
	dk_isList(myList)
	if(dk_isList)
		dk_echo("'myList' is a list")
	else()
		dk_echo("'myList' is NOT a list")
	endif()
	
	dk_isList("abc;123;456")
	if(dk_isList)
		dk_echo("'abc;123;456' is a list")
	else()
		dk_echo("'abc;123;456' is NOT a list")
	endif()
	
	string(APPEND myString "Hello ")
	string(APPEND myString "World")
	dk_isList(myString)
	if(dk_isList)
		dk_echo("'myString' is a list")
	else()
		dk_echo("'myString' is NOT a list")
	endif()
	
	dk_isList("Hello World")
	if(dk_isList)
		dk_echo("'Hello World' is a list")
	else()
		dk_echo("'Hello World' is NOT a list")
	endif()
endfunction()