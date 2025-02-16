#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_includes(variable find)
#
#	Check if a string contains a substring
#
#	@variable		- The variable
#	@find			- The substring to search for
#	${dk_includes}	- Returns index: Returns the index of the string if located
#
function(dk_includes)
	dk_debugFunc(2 99)
	
	dk_getArg(0 variable)
	dk_getArg(1 find)
	
	string(FIND "${variable}" "${find}" dk_includes)
	math(EXPR dk_includes "${dk_includes}+1")
	set(dk_includes ${dk_includes} PARENT_SCOPE)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(myString "There is a needle in this haystack")
	set(mySubstring "needle")
	dk_includes("${myString}" "${mySubstring}")
	if(dk_includes)
		dk_info("myString contains mySubstring")
	else()
		dk_info("myString does NOT contain mySubstring")
	endif()
	
	set(myString "There is a needle in this haystack")
	set(mySubstring "needle")
	dk_includes(myString "${mySubstring}")
	if(dk_includes)
		dk_info("myString contains mySubstring")
	else()
		dk_info("myString does NOT contain mySubstring")
	endif()
	
	dk_includes("${myString}" "nonexistant")
	if(dk_includes)
		dk_info("myString contains nonexistant")
	else()
		dk_info("myString does NOT contain nonexistant")
	endif()
	
	list(APPEND myList "one")
	list(APPEND myList "two")
	list(APPEND myList "three")
	dk_includes("${myList}" "two")
	if(dk_includes)
		dk_info("myList contains two")
	else()
		dk_info("myList does NOT contain two")
	endif()
endfunction()
