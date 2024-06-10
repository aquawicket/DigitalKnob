include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

################################################################################
# dk_arrayAt(array, index, rtn_var)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_at
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/at
#
function(dk_arrayAt array index rtn_var)
	dk_debugFunc(${ARGV})
	
	list(GET ${array} ${index} output)
	set(${rtn_var} ${output} PARENT_SCOPE)
	
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	list(APPEND MyArray "a")
	list(APPEND MyArray "b")
	list(APPEND MyArray "c")
	list(APPEND MyArray "d")
	list(APPEND MyArray "e")
	
	dk_arrayAt(MyArray 3 element)
	dk_echo("element = ${element}")
endfunction(DKTEST)