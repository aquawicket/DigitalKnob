include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

################################################################################
# dk_arrayAt(array, index, rtn_var)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_at
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/at
#
function(dk_arrayAt array index rtn_var)
	dk_debugFunc(${ARGV})
	
	list(GET ${array} ${index} arrayAt)
	dk_printVar(arrayAt)
	set(${rtn_var} ${arrayAt} PARENT_SCOPE)
	
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	list(APPEND myArray "a")
	list(APPEND myArray "b")
	list(APPEND myArray "c")
	list(APPEND myArray "d")
	list(APPEND myArray "e")
	
	dk_arrayAt(myArray 3 element)
	dk_info("element = ${element}")
endfunction()