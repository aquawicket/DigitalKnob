#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	file(TO_CMAKE_PATH "$ENV{USERPROFILE}$ENV{HOME}/digitalknob/Development/DKCMake/functions" DKCMAKE_FUNCTIONS_DIR)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

################################################################################
# dk_arrayLength(array)
#
#    The length data property of an Array instance represents the number of elements in that array. 
#    The value is an unsigned, 32-bit integer that is always numerically greater than the highest index in the array.
#
#    REFERENCE
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/length
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
	
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc(0)
	
	list(APPEND myArray "element 1")
	list(APPEND myArray "element 2")
	list(APPEND myArray "element 3")

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
endfunction()
