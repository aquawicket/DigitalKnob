#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

################################################################################
# dk_arrayIndexOf(array, searchElement)
# dk_arrayIndexOf(array, searchElement, rtn_val)
# dk_arrayIndexOf(array, searchElement, fromIndex)
# dk_arrayIndexOf(array, searchElement, fromIndex, rtn_val)
#
#	The indexOf() method of Array instances returns the first index at which a given element can be found in the array, or -1 if it is not present.
#
#	PARAMETERS
#	searchElement
#		Element to locate in the array.
#
#	fromIndex :optional
#		Zero-based index at which to start searching, converted to an integer.
#		Negative index counts back from the end of the array — if -array.length <= fromIndex < 0, fromIndex + array.length is used. 
#		Note, the array is still searched from front to back in this case.
#		If fromIndex < -array.length or fromIndex is omitted, 0 is used, causing the entire array to be searched.
#		If fromIndex >= array.length, the array is not searched and -1 is returned.
#
#	RETURN VALUE
#		The first index of searchElement in the array; -1 if not found.
#
#	REFERENCE
#		https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf
#
function(dk_arrayIndexOf array searchElement rtn_val)
	dk_debugFunc(2 4)

	list(FIND ${array} ${searchElement} output)
	set(${rtn_val} ${output} PARENT_SCOPE)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc(0)

	list(APPEND myArray "a")
	list(APPEND myArray "b")
	list(APPEND myArray "c")
	list(APPEND myArray "d")
	list(APPEND myArray "e")

	dk_arrayIndexOf(myArray "a" indexA)
	dk_info("indexA = ${indexA}")

	dk_arrayIndexOf(myArray "b" indexB)
	dk_info("indexB = ${indexB}")

	dk_arrayIndexOf(myArray "c" indexC)
	dk_info("indexC = ${indexC}")

	dk_arrayIndexOf(myArray "d" indexD)
	dk_info("indexD = ${indexD}")

	dk_arrayIndexOf(myArray "e" indexE)
	dk_info("indexE = ${indexE}")

	dk_arrayIndexOf(myArray "nonExistant" indexN)
	dk_info("indexN = ${indexN}")
endfunction()
