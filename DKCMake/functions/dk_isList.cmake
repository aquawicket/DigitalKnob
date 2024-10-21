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
	
	math(EXPR ARGC "${ARGC}-1")  

	if(DEFINED "${ARGV1}")
		dk_getArgCount(count ${${ARGN}})

		if(${count} GREATER 1)
			dk_debug("'${ARGN}' is a LIST variable")
			set(isList TRUE)
		elseif(${count} GREATER 0)
			dk_debug("'${ARGN}' is a STRING variable")
			set(isList FALSE)
		else()
			dk_debug("'${ARGN}' is INVALID!")
			set(isList FALSE)
		endif()
		
		set(${rtn_var} ${isList} PARENT_SCOPE)
		return()
	elseif(NOT "${ARGN}" STREQUAL "")
		dk_getArgCount(count ${ARGN})

		if(${count} GREATER 1)
			dk_debug("'${ARGN}' is a LIST value")
			set(isList TRUE)
		elseif(${count} GREATER 0)
			dk_debug("'${ARGN}' is a STRING value")
			set(isList FALSE)
		else()
			dk_debug("'${ARGN}' is INVALID!")
			set(isList FALSE)
		endif()
		
		set(${rtn_var} ${isList} PARENT_SCOPE)
		return()
	else()
		dk_debug("'${ARGN}' is invalid")
		set(isList FALSE)
		set(${rtn_var} ${isList} PARENT_SCOPE)
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	list(APPEND myList "myList item 0")
	list(APPEND myList "myList item 1")
	list(APPEND myList "myList item 2")
	dk_isList(rtn myList)
	
	string(APPEND myString "Hello ")
	string(APPEND myString "World")
	dk_isList(rtn myString)
	
	dk_isList(rtn "abc;123;456")
	dk_isList(rtn "Hello World")
endfunction()