#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

################################################################################
# dk_arrayAt(array, index)
#
#	Takes an array instance with an integer value and returns the item at that index, 
#	allowing for positive and negative integers. Negative integers count back from the last item in the array.  <-- TODO
#
#	PARAMETERS
#	index
#		Zero-based index of the array element to be returned, converted to an integer. Negative index counts back from the end of the array — if index < 0, index + array.length is accessed.
#
#	RETURN VALUE
#		The element in the array matching the given index. Always returns undefined if index < -array.length or index >= array.length without attempting to access the corresponding property.
#
#	REFERENCE
#		https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/at
#
function(dk_arrayAt)
	dk_debugFunc(2 99)

#	if(DEFINED "${ARGV0}")
#		set(array 	"${${ARGV0}}")
#	elseif(DEFINED ARGV0)
#		set(array 	"${ARGV0}")
#	else()
#		dk_fatal("dk_arrayLength(${ARGV}): array is invalid.")
#	endif()
#	#dk_printVar(array)
	dk_getArg(0 array)

#	if(DEFINED "${ARGV1}")
#		set(index 	"${${ARGV1}}")
#	elseif(DEFINED ARGV0)
#		set(index 	"${ARGV1}")
#	else()
#		dk_fatal("dk_arrayLength(${ARGV}): index is invalid.")
#	endif()
	dk_getArg(1 index)

	list(GET array ${index} dk_arrayAt)
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
	list(APPEND myArray "f")
	list(APPEND myArray "g")
	list(APPEND myArray "h")
	list(APPEND myArray "i")

	dk_arrayAt(myArray 0)
	dk_info("dk_arrayAt 0 = ${dk_arrayAt}")

	dk_arrayAt("myArray" 1)
	dk_info("dk_arrayAt 1 = ${dk_arrayAt}")

	dk_arrayAt("${myArray}" 2)
	dk_info("dk_arrayAt 2 = ${dk_arrayAt}")

#	dk_arrayAt(${myArray} 3)				# FIXME: Variables revieved by array without quotes fail
#	dk_info("dk_arrayAt 3 = ${dk_arrayAt}")

	set(at 4)
	dk_arrayAt(myArray at)
	dk_info("dk_arrayAt 4 = ${dk_arrayAt}")

	set(at 5)
	dk_arrayAt(myArray "at")
	dk_info("dk_arrayAt 5 = ${dk_arrayAt}")

	set(at 6)
	dk_arrayAt(myArray ${at})
	dk_info("dk_arrayAt 6 = ${dk_arrayAt}")

	set(at 7)
	dk_arrayAt(myArray "${at}")
	dk_info("dk_arrayAt 7 = ${dk_arrayAt}")
endfunction()
