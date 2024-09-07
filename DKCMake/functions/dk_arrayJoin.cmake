include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

################################################################################
# dk_arrayJoin(array, separator, rtn_var)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_join
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join
#
function(dk_arrayJoin array separator rtn_val)
	dk_debugFunc("\${ARGV}")
	
	list(JOIN ${array} "," arrayJoin)
	set(${rtn_val} ${arrayJoin} PARENT_SCOPE)
	#dk_printVar(rtn_val)
endfunction()




function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc("\${ARGV}")
	
	list(APPEND myArray "a")
	list(APPEND myArray "b")
	list(APPEND myArray "c")
	list(APPEND myArray "d")
	list(APPEND myArray "e")
	
	dk_arrayJoin(myArray "," myString)
	dk_info("myString = ${myString}")
endfunction()
