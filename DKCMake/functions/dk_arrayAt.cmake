include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

################################################################################
# dk_arrayAt(array, index)
# dk_arrayAt(array, index, rtn_var)
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
function(dk_arrayAt array index rtn_var)
	dk_debugFunc("\${ARGV}")
	
	list(GET ${array} ${index} arrayAt)
	set(${rtn_var} ${arrayAt} PARENT_SCOPE)

# DEBUG
#	dk_printVar(rtn_var)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	list(APPEND myArray "a")
	list(APPEND myArray "b")
	list(APPEND myArray "c")
	list(APPEND myArray "d")
	list(APPEND myArray "e")
	
	dk_arrayAt(myArray 3 element)
	dk_info("element = ${element}")
endfunction()
