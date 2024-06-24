include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

################################################################################
# dk_arrayPop(array rtn_val)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_pop
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/pop
#
#function(dk_arrayPop array)# rtn_var)
#	dk_debugFunc(${ARGV})
#	
#	if(DEFINED "${array}")
#		set(_array_ "${array}")
#		set(name ${_array_})
#	elseif(DEFINED "array")
#		set(_array_ "array")
#		set(name ${_array_})
#	else()
#		dk_error("arguments invalid: ${_array_}")
#	endif()
#	
#	list(POP_BACK "${_array_}")
#	dk_printArray("${_array_}")
#	
#	set(${array} "${_array_}" PARENT_SCOPE)
#endfunction()


macro(dk_arrayPop)
	if(DEFINED "${ARGV}")
		set(_array_ "${ARGV}")
		set(name ${_array_})
	elseif(DEFINED "ARGV")
		set(_array_ "ARGV")
		set(name ${_array_})
	else()
		dk_error("arguments invalid: ${_array_}")
	endif()
	
	list(POP_BACK "${_array_}")
endmacro()



function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc(${ARGV})
	
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
