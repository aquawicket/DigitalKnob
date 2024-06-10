include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

################################################################################
# dk_printArray(array)
#
#
function(dk_printArray)
	dk_debugFunc(${ARGV})
	
	if(DEFINED "${ARGV}")
		set(array "${ARGV}")
		set(name ${array})
	elseif(DEFINED "ARGV")
		set(array "ARGV")
		set(name ${array})
	else()
		dk_error("arguments invalid: ${ARGV}")
	endif()

	message("name = ${name}")
	message("array = ${array}")
	list(LENGTH "${array}" length)

	set(i 0)
	while(${i} LESS ${length})
		list(GET ${array} ${i} value)
		dk_info("${name}[${i}] = ${value}")
		math(EXPR i "${i}+1")
	endwhile()

	message("${name} length = ${length}")
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc(${ARGV})
	
	list(APPEND myArray "a")
	list(APPEND myArray "b")
	list(APPEND myArray "c")
	list(APPEND myArray "d")
	list(APPEND myArray "e")
	string(APPEND myString "12345")
	
	message("dk_printArray(myArray)")
	dk_printArray(myArray)
	message("dk_printArray(\${myArray})")
	dk_printArray(${myArray})
	message("dk_printArray(\"myArray\")")
	dk_printArray("myArray")
	message("dk_printArray(\"\${myArray}\")")
	dk_printArray("${myArray}")
	
	message("dk_printArray(myString)")
	dk_printArray(myString)
	message("dk_printArray(\${myString})")
	dk_printArray(${myString})
	message("dk_printArray(\"myString\")")
	dk_printArray("myString")
	message("dk_printArray(\"\${myString}\")")
	dk_printArray("${myString}")
endfunction(DKTEST)