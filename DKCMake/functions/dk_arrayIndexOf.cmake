include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

################################################################################
# dk_arrayIndexOf(array, searchElement, rtn_val)
# dk_arrayIndexOf(array, searchElement, fromIndex, rtn_val)
#
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf
#
function(dk_arrayIndexOf array searchElement rtn_val)
	dk_debugFunc(${ARGV})
	
	list(FIND ${array} ${searchElement} output)
	set(${rtn_val} ${output} PARENT_SCOPE)
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc(${ARGV})
	
	list(APPEND myArray "a")
	list(APPEND myArray "b")
	list(APPEND myArray "c")
	list(APPEND myArray "d")
	list(APPEND myArray "e")
	
	dk_arrayIndexOf(myArray "a" indexA)
	dk_info("indexA = ${indexA}")
	
	dk_arrayIndexOf(myArray "b" indexB)
	dk_info("indexB = ${indexB}")
	
	dk_arrayIndexOf(myArray "c" indexC)
	dk_info("indexC = ${indexC}")
	
	dk_arrayIndexOf(myArray "d" indexD)
	dk_info("indexD = ${indexD}")
	
	dk_arrayIndexOf(myArray "e" indexE)
	dk_info("indexE = ${indexE}")
	
	dk_arrayIndexOf(myArray "nonExistant" indexN)
	dk_info("indexN = ${indexN}")
endfunction(DKTEST)