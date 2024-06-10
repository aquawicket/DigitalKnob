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
	
	list(APPEND MyArray "a")
	list(APPEND MyArray "b")
	list(APPEND MyArray "c")
	list(APPEND MyArray "d")
	list(APPEND MyArray "e")
	
	dk_arrayIndexOf(MyArray "a" indexA)
	dk_echo("indexA = ${indexA}")
	
	dk_arrayIndexOf(MyArray "b" indexB)
	dk_echo("indexB = ${indexB}")
	
	dk_arrayIndexOf(MyArray "c" indexC)
	dk_echo("indexC = ${indexC}")
	
	dk_arrayIndexOf(MyArray "d" indexD)
	dk_echo("indexD = ${indexD}")
	
	dk_arrayIndexOf(MyArray "e" indexE)
	dk_echo("indexE = ${indexE}")
	
	dk_arrayIndexOf(MyArray "nonExistant" indexN)
	dk_echo("indexN = ${indexN}")
endfunction(DKTEST)