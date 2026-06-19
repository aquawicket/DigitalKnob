#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# Array::dk_arrayConcat(array, {value1, value2, /* …, */ valueN})
#
#	 Merge two or more arrays. This method does not change the existing arrays, but instead returns a new array.
#
#	PARAMETERS
#	value1, …, valueN Optional
#	Arrays and/or values to concatenate into a new array. 
#	If all valueN parameters are omitted, concat returns a shallow copy of the existing array on which it is called. See the description below for more details.
#
#	RETURN VALUE
#	A new Array instance.
#
#	REFERENCE
#	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/concat
#
function(Array::dk_arrayConcat array)
	dk_debugFunc()

	dk_todo("Array::dk_arrayConcat")
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_call(Array::dk_arrayConcat(MyArray))
endfunction()
