include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

################################################################################
# dk_arrayLength(array, rtn_var)
#
#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_length
#
function(dk_arrayLength array rtn_var)
	dk_debugFunc(${ARGV})
	
	list(LENGTH ${array} output)
	set(${rtn_var} ${output} PARENT_SCOPE)
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc(${ARGV})
	
	list(APPEND myArray "element 1")
	list(APPEND myArray "element 2")
	list(APPEND myArray "element 3")

	dk_arrayLength(myArray length)
	dk_echo("length = ${length}")
endfunction(DKTEST)