#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

################################################################################
# dk_printArray(array)
#
#
function(dk_printArray)
	dk_debugFunc("\${ARGV}")
	
	if(DEFINED "${ARGV}")
		set(array "${ARGV}")
		set(name ${array})
	elseif(DEFINED "ARGV")
		set(array "ARGV")
		set(name ${array})
	else()
		dk_fatal("arguments invalid: ${ARGV}")
	endif()

	dk_echo("name = ${name}")
	dk_echo("array = ${array}")
	list(LENGTH "${array}" length)

	set(i 0)
	while(${i} LESS ${length})
		list(GET ${array} ${i} value)
		dk_info("${name}[${i}] = ${value}")
		math(EXPR i "${i}+1")
	endwhile()

	dk_echo("${name} length = ${length}")
endfunction()




function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc("\${ARGV}")
	
	list(APPEND myArray "a")
	list(APPEND myArray "b")
	list(APPEND myArray "c")
	list(APPEND myArray "d")
	list(APPEND myArray "e")
	string(APPEND myString "12345")
	
	dk_echo("dk_printArray(myArray)")
	dk_printArray(myArray)
	dk_echo("dk_printArray(\${myArray})")
	dk_printArray(${myArray})
	dk_echo("dk_printArray(\"myArray\")")
	dk_printArray("myArray")
	dk_echo("dk_printArray(\"\${myArray}\")")
	dk_printArray("${myArray}")
	
	dk_echo("dk_printArray(myString)")
	dk_printArray(myString)
	dk_echo("dk_printArray(\${myString})")
	dk_printArray(${myString})
	dk_echo("dk_printArray(\"myString\")")
	dk_printArray("myString")
	dk_echo("dk_printArray(\"\${myString}\")")
	dk_printArray("${myString}")
endfunction()