#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


#########################################################################
# dk_arrayAt(array, index, rtn_var)
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

	list(APPEND array "${ARGV}")
	set(index ${ARGV1})
	
	list(GET array ${index} dk_arrayAt)
	
	###### output ######
	set(dk_arrayAt ${dk_arrayAt} PARENT_SCOPE)
	#if(ARGV2)
	#	set(${ARGV2} ${dk_arrayAt} PARENT_SCOPE)
	#else()
		message("${dk_arrayAt}") 
	#endif()
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

	dk_arrayAt(myArray 1 resultB)
	dk_info("resultB 1 = ${resultB}" PARENT_SCOPE)

	dk_arrayAt("${myArray}" 2)
	dk_info("dk_arrayAt 2 = ${dk_arrayAt}")

#	dk_arrayAt(${myArray} 3)				# FIXME: Variables revieved by array without quotes fail
#	dk_info("dk_arrayAt 3 = ${dk_arrayAt}")

	set(at 4)
	dk_arrayAt(myArray at)
	dk_info("dk_arrayAt ${at} = ${dk_arrayAt}")

	set(at 5)
	dk_arrayAt(myArray "at")
	dk_info("dk_arrayAt ${at} = ${dk_arrayAt}")

	set(at 6)
	dk_arrayAt(myArray ${at})
	dk_info("dk_arrayAt ${at} = ${dk_arrayAt}")

	set(at 7)
	dk_arrayAt(myArray "${at}")
	dk_info("dk_arrayAt ${at} = ${dk_arrayAt}")
endfunction()
