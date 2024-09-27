#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

################################################################################
# dk_arrayPop(array)
# dk_arrayPop(array, rtn_var)
#
#    The pop() method of Array instances removes the last element from an array and returns that element. This method changes the length of the array.
#
#    PARAMETERS
#    array
#
#	 RETURN VALUE
#    The removed element from the array; undefined if the array is empty.
#
#    REFERENCE
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/pop
#
 #function(dk_arrayPop array)# rtn_var)
 #	dk_debugFunc("\${ARGV}")
 #	
 #	if(DEFINED "${array}")
 #		set(_array_ "${array}")
 #		set(name ${_array_})
 #	elseif(DEFINED "array")
 #		set(_array_ "array")
 #		set(name ${_array_})
 #	else()
 #		dk_fatal("arguments invalid: ${_array_}")
 #	endif()
 #	
 #	list(POP_BACK "${_array_}")
 #	dk_printArray("${_array_}")
 #	
 #	set(${array} "${_array_}" PARENT_SCOPE)
 #
 # debug
 #	dk_printVar(array)
 #endfunction()
macro(dk_arrayPop)
	dk_debugFunc("\${ARGV}")
	
	if(DEFINED "${ARGV}")
		set(_array_ "${ARGV}")
		set(name ${_array_})
	elseif(DEFINED "ARGV")
		set(_array_ "ARGV")
		set(name ${_array_})
	else()
		dk_fatal("arguments invalid: ${_array_}")
	endif()
	
	list(POP_BACK "${_array_}")
	
# DEBUG
#	dk_printVar(_array_)
endmacro()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	list(APPEND myArray "a")
	list(APPEND myArray "b")
	list(APPEND myArray "c")
	list(APPEND myArray "d")
	list(APPEND myArray "e")
	
	dk_printArray(myArray)
	
	dk_arrayPop(myArray)
	dk_printArray(myArray)
	
	dk_arrayPop("myArray")
	dk_printArray("myArray")

	dk_arrayPop(${myArray})
	dk_printArray(${myArray})
	
	dk_arrayPop("${myArray}")
	dk_printArray("${myArray}")
	
	dk_arrayPop(myArray)
	dk_printArray(myArray)
	
	dk_arrayPop(myArray)
	dk_printArray(myArray)
	
	dk_arrayPop(myArray)
	dk_printArray(myArray)
	
	dk_arrayPop(myArray )
	dk_printArray(myArray)
endfunction()
