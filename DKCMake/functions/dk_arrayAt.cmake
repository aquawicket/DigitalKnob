#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

################################################################################
# dk_arrayAt(array, index)
#
#	 Takes an array instance with an integer value and returns the item at that index, 
#	 allowing for positive and negative integers. Negative integers count back from the last item in the array.  <-- TODO
#
#    PARAMETERS
#    index
#    Zero-based index of the array element to be returned, converted to an integer. Negative index counts back from the end of the array — if index < 0, index + array.length is accessed.
#
#    RETURN VALUE
#    The element in the array matching the given index. Always returns undefined if index < -array.length or index >= array.length without attempting to access the corresponding property.
#
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/at
#
function(dk_arrayAt array index)
	dk_debugFunc(2)
	
	set(array ${ARGV0})
	set(index ${ARGV1})
	
	list(GET ${array} ${index} dk_arrayAt)
	set(dk_arrayAt ${dk_arrayAt} PARENT_SCOPE)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	list(APPEND myArray "a")
	list(APPEND myArray "b")
	list(APPEND myArray "c")
	list(APPEND myArray "d")
	list(APPEND myArray "e")
	
	dk_arrayAt(myArray 3)
	dk_info("dk_arrayAt = ${dk_arrayAt}")
endfunction()
