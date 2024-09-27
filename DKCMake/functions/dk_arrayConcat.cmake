#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

################################################################################
# dk_arrayConcat(array, {value1, value2, /* …, */ valueN})
# dk_arrayConcat(array, {value1, value2, /* …, */ valueN}, rtn_var)
#
#	 Merge two or more arrays. This method does not change the existing arrays, but instead returns a new array.
#
#    PARAMETERS
#    value1, …, valueN Optional
#        Arrays and/or values to concatenate into a new array. 
#        If all valueN parameters are omitted, concat returns a shallow copy of the existing array on which it is called. See the description below for more details.
#
#    RETURN VALUE
#    A new Array instance.
#
#    REFERENCE
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/concat
#
function(dk_arrayConcat array)
	dk_debugFunc("\${ARGV}")
	
	dk_todo("dk_arrayConcat")

# DEBUG
#	TODO
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_arrayConcat(MyArray)
endfunction()
