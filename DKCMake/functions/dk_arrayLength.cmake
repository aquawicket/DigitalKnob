#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

################################################################################
# dk_arrayLength(array)
# dk_arrayLength(array rtn_var)
#
#    The length data property of an Array instance represents the number of elements in that array. 
#    The value is an unsigned, 32-bit integer that is always numerically greater than the highest index in the array.
#
#    REFERENCE
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/length
#
function(dk_arrayLength array rtn_var)
	dk_debugFunc()
	
	if(DEFINED "${array}")
		set(_array_ "${array}")
		set(name ${_array_})
	elseif(DEFINED "array")
		set(_array_ "array")
		set(name ${_array_})
	else()
		dk_fatal("arguments invalid: ${_array_}")
	endif()
	
	list(LENGTH "${_array_}" arrayLength)
	set(${rtn_var} ${arrayLength} PARENT_SCOPE)
	
# DEBUG	
	#dk_printVar(rtn_var)
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

################################################################################
# dk_arrayLength(array)
#
#	The length data property of an Array instance represents the number of elements in that array. 
#	The value is an unsigned, 32-bit integer that is always numerically greater than the highest index in the array.
#
#	REFERENCE
#		https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/length
#
function(dk_arrayLength)
	dk_debugFunc()	
	if(DEFINED "${ARGV0}")
		set(array 	"${${ARGV0}}")
	elseif(DEFINED ARGV0)
		set(array 	"${ARGV0}")
	else()
		dk_fatal("dk_arrayLength(${ARGV}): array is invalid.")
	endif()

	list(LENGTH array dk_arrayLength)
	set(dk_arrayLength ${dk_arrayLength} PARENT_SCOPE)
>>>>>>> Development
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
<<<<<<< HEAD
	dk_debugFunc()
	
=======
	dk_debugFunc(0)

>>>>>>> Development
	list(APPEND myArray "element 1")
	list(APPEND myArray "element 2")
	list(APPEND myArray "element 3")

<<<<<<< HEAD
	dk_arrayLength(myArray lengthA)
	dk_info("lengthA = ${lengthA}")
	
	dk_arrayLength("myArray" lengthB)
	dk_info("lengthB = ${lengthB}")
	
#	dk_arrayLength(${myArray} lengthC)    #unable to send expanded arrays
#	dk_info("lengthC = ${lengthC}")
	
	dk_arrayLength("${myArray}" lengthD)
	dk_info("lengthD = ${lengthD}")
	
	dk_arrayLength("${nonExistent}" lengthE)
	dk_info("lengthE = ${lengthE}")
=======
	dk_arrayLength(myArray)
	dk_info("dk_arrayLength = ${dk_arrayLength}")

	dk_arrayLength("myArray")
	dk_info("dk_arrayLength = ${dk_arrayLength}")

#	dk_arrayLength(${myArray})    #ERROR: returns incorrect value
#	dk_info("dk_arrayLength = ${dk_arrayLength}")

	dk_arrayLength("${myArray}")
	dk_info("dk_arrayLength = ${dk_arrayLength}")
	
	dk_arrayLength("${nonExistent}")
	dk_info("dk_arrayLength = ${dk_arrayLength}")
>>>>>>> Development
endfunction()
