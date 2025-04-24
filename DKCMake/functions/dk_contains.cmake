#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_contains(variable find)
#
#	Check if a string contains a substring
#
#	@variable				- The string to search within
#	@find					- The substring to search for
#	${dk_contains}	- Returns index: Returns the index of the string if located
#
function(dk_contains)
	dk_debugFunc(2 99)
	
	### variable ###
	if(DEFINED "${ARGV0}")
		set(variable 	"${${ARGV0}}")
	elseIF(DEFINED ARGV0)
		set(variable 	"${ARGV0}")
	else()
		dk_fatal("dk_contains(${ARGV}): ARGV0:${ARGV0} is invalid.")
	endif()
#	dk_getArg(0 variable)

	### find ###
	if(DEFINED "${ARGV1}")
		set(find 		"${${ARGV1}}")
	elseif(DEFINED ARGV1)
		set(find 		"${ARGV1}")
	else()
		dk_fatal("dk_contains(${ARGV}): ARGV1:${ARGV1} is invalid.")
	endif()
#	dk_getArg(1 find)

	string(FIND "${variable}" "${find}" dk_contains)
	math(EXPR dk_contains "${dk_contains}+1")
	set(dk_contains ${dk_contains} PARENT_SCOPE)
	
#if(DEBUG_CMAKE)	
	if(${dk_contains})
		dk_debug("dk_contains(${ARGV}): RTN:${dk_contains}:isTrue")
	else()
		dk_debug("dk_contains(${ARGV}): RTN:${dk_contains}:isFalse")
	endif()
#endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(myString "There is a needle in this haystack")
	set(mySubstring "needle")
	dk_contains("${myString}" "${mySubstring}")
	if(dk_contains)
		dk_info("${myString} contains ${mySubstring}")
	else()
		dk_info("${myString} does NOT contain ${mySubstring}")
	endif()
	
	set(myString "There is a needle in this haystack")
	set(mySubstring "needle")
	dk_contains(myString "${mySubstring}")
	if(dk_contains)
		dk_info("${myString} contains ${mySubstring}")
	else()
		dk_info("${myString} does NOT contain ${mySubstring}")
	endif()
	
	dk_contains("${myString}" "nonexistant")
	if(dk_contains)
		dk_info("${myString} contains ${mySubstring}")
	else()
		dk_info("${myString} does NOT contain 'nonexistant'")
	endif()
	
	list(APPEND myList "one")
	list(APPEND myList "two")
	list(APPEND myList "three")
	dk_contains("${myList}" "two")
	if(dk_contains)
		dk_info("${myList} contains 'two'")
	else()
		dk_info("${myList} does NOT contain 'two'")
	endif()
endfunction()
