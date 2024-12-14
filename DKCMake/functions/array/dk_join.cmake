#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ "../")
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

################################################################################
# dk_arrayJoin(array, separator)
#
#    The join() method of Array instances creates and returns a new string by concatenating all of the elements in this array, separated by commas or a specified separator string. 
#    If the array has only one item, then that item will be returned without using the separator.
#
#    PARAMETERS
#    separator :optional
#        A string to separate each pair of adjacent elements of the array. If omitted, the array elements are separated with a comma (",").
#
#    RETURN VALUE
#    A string with all array elements joined. If array.length is 0, the empty string is returned.
#
#    REFERENCE
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join
#
function(dk_arrayJoin)
	dk_debugFunc(2)
	
	###### array ######
	if(DEFINED "${ARGV0}")
		set(array 	"${${ARGV0}}")
	elseif(DEFINED ARGV0)
		set(array 	"${ARGV0}")
	else()
		dk_fatal("dk_arrayJoin(${ARGV}): array is invalid.")
	endif()
	
	###### seperator ######
	if(DEFINED "${ARGV1}")
		set(separator 	"${${ARGV1}}")
	elseif(DEFINED ARGV0)
		set(separator 	"${ARGV1}")
	else()
		dk_fatal("dk_arrayJoin(${ARGV}): separator is invalid.")
	endif()
	
	list(JOIN array "${separator}" dk_arrayJoin)
	set(dk_arrayJoin ${dk_arrayJoin} PARENT_SCOPE)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	list(APPEND myArray "a")
	list(APPEND myArray "b")
	list(APPEND myArray "c")
	list(APPEND myArray "d")
	list(APPEND myArray "e")
	
	dk_arrayJoin(myArray ",")
	dk_info("dk_arrayJoin = ${dk_arrayJoin}")
endfunction()
