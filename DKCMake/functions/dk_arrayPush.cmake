include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

dk_fixme()
################################################################################
# dk_arrayPush(array, element1, element2, /* …, */ elementN)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_push
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push
#
function(dk_arrayPush array element1)
	dk_debugFunc(${ARGV})
	
	if(DEFINED "${ARGV}")
		set(_array_ "${ARGV}")
		set(name ${_array_})
	elseif(DEFINED "ARGV")
		set(_array_ "ARGV")
		set(name ${_array_})
	else()
		dk_error("arguments invalid: ${_array_}")
	endif()
	
	$end_index = $_array_.count
	##$array[${end_index}] = $element1
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc(${ARGV})
	
	list(APPEND myArray "a")
	list(APPEND myArray "b")
	list(APPEND myArray "c")
	list(APPEND myArray "d")
	list(APPEND myArray "e")
	
	dk_printArray myArray
	
	dk_arrayPush myArray a
	dk_printArray myArray
	
	dk_arrayPush myArray b
	dk_printArray myArray
	
	dk_arrayPush myArray c
	dk_printArray myArray
	
	dk_arrayPush myArray d
	dk_printArray myArray
	
endfunction()