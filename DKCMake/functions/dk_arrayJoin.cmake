#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

################################################################################
# dk_arrayJoin(array, separator)
# dk_arrayJoin(array, separator, rtn_var)
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
function(dk_arrayJoin array separator rtn_val)
	dk_debugFunc("\${ARGV}")
	
	list(JOIN ${array} "," arrayJoin)
	set(${rtn_val} ${arrayJoin} PARENT_SCOPE)

# debug
	#dk_printVar(rtn_val)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	list(APPEND myArray "a")
	list(APPEND myArray "b")
	list(APPEND myArray "c")
	list(APPEND myArray "d")
	list(APPEND myArray "e")
	
	dk_arrayJoin(myArray "," myString)
	dk_info("myString = ${myString}")
endfunction()
