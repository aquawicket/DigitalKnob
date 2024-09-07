include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

################################################################################
# dk_arrayPush(array, element1, element2, /* …, */ elementN)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_push
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push
#
function(dk_arrayPush array element1)
	dk_debugFunc("\${ARGV}")
	if(NOT ${ARGC} EQUAL 2)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
	
	if(DEFINED "${ARGV}")
		set(_array_ "${ARGV}")
		set(name ${_array_})
	elseif(DEFINED "ARGV")
		set(_array_ "ARGV")
		set(name ${_array_})
	else()
		dk_fatal("arguments invalid: ${_array_}")
	endif()
	
	#dk_fixme("${CMAKE_CURRENT_FUNCTION}")
	#list(APPEND ${name} ${element1})
	dk_append(${name} ${element1})
endfunction()




function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc("\${ARGV}")
	
	dk_append(myArray "a")
	
	dk_printArray(myArray)
	
	dk_arrayPush(myArray a)
	dk_printArray(myArray)
	
	dk_arrayPush(myArray b)
	dk_printArray(myArray)
	
	dk_arrayPush(myArray c)
	dk_printArray(myArray)
	
	dk_arrayPush(myArray d)
	dk_printArray(myArray)
	
endfunction()