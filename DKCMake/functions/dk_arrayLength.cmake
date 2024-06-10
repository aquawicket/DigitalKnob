include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

################################################################################
# dk_arrayLength(array, rtn_var)
#
#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_length
#
function(dk_arrayLength array rtn_var)
	dk_debugFunc(${ARGV})
	
	if(DEFINED "${array}")
		set(_array_ "${array}")
		set(name ${_array_})
	elseif(DEFINED "array")
		set(_array_ "array")
		set(name ${_array_})
	else()
		dk_error("arguments invalid: ${_array_}")
	endif()
	
	list(LENGTH "${_array_}" output)
	set(${rtn_var} ${output} PARENT_SCOPE)
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc(${ARGV})
	
	list(APPEND myArray "element 1")
	list(APPEND myArray "element 2")
	list(APPEND myArray "element 3")

	dk_arrayLength(myArray lengthA)
	dk_echo("lengthA = ${lengthA}")
	
	dk_arrayLength("myArray" lengthB)
	dk_echo("lengthB = ${lengthB}")
	
#	dk_arrayLength(${myArray} lengthC)    #unable to send expanded arrays
#	dk_echo("lengthC = ${lengthC}")
	
	dk_arrayLength("${myArray}" lengthD)
	dk_echo("lengthD = ${lengthD}")
endfunction(DKTEST)