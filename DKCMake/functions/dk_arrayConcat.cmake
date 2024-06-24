include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

################################################################################
# dk_arrayConcat(array, value1, value2, /* …, */ valueN)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_concat
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/concat
#
function(dk_arrayConcat array)
	dk_debugFunc(${ARGV})
	
	dk_todo("dk_arrayConcat")
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_arrayConcat(MyArray)
	
endfunction()