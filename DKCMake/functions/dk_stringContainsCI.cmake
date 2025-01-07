#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_stringContainsCI(variable find)
#
#	Check if a string contains a substring (Case Insensitive)
#
#	@variable				- The string to search within
#	@find					- The substring to search for
#	${dk_stringContainsCI}	- Returns index: Returns the index of the string if located
#
function(dk_stringContainsCI)
	dk_debugFunc(2 99)
	
	### variable ###
	if(DEFINED "${ARGV0}")
		set(variable 	"${${ARGV0}}")
	elseIF(DEFINED ARGV0)
		set(variable 	"${ARGV0}")
	else()
		dk_fatal("dk_stringContainsCI(${ARGV}): ARGV0:${ARGV0} is invalid.")
	endif()

	### find ###
	if(DEFINED "${ARGV1}")
		set(find 		"${${ARGV1}}")
	elseif(DEFINED ARGV1)
		set(find 		"${ARGV1}")
	else()
		dk_fatal("dk_stringContainsCI(${ARGV}): ARGV1:${ARGV1} is invalid.")
	endif()

	string(TOLOWER "${variable}" variable)
	string(TOLOWER "${find}" find)
	string(FIND "${variable}" "${find}" dk_stringContainsCI)
	math(EXPR dk_stringContainsCI "${dk_stringContainsCI}+1")
	set(dk_stringContainsCI ${dk_stringContainsCI} PARENT_SCOPE)
	
#if(DEBUG_CMAKE)	
#	if(${dk_stringContainsCI})
#		dk_debug("dk_stringContainsCI(${ARGV}): RTN:${dk_stringContainsCI}:isTrue")
#	else()
#		dk_debug("dk_stringContainsCI(${ARGV}): RTN:${dk_stringContainsCI}:isFalse")
#	endif()
#endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(myString "There is a Needle in this haystack")
	set(mySubstring "needle")
	dk_stringContainsCI("${myString}" "${mySubstring}")
	if(dk_stringContainsCI)
		dk_info("${myString} contains ${mySubstring}")
	else()
		dk_info("${myString} does NOT contain ${mySubstring}")
	endif()
	
	set(myString "There is a needle in this haystack")
	set(mySubstring "NEEDLE")
	dk_stringContainsCI(myString "${mySubstring}")
	if(dk_stringContainsCI)
		dk_info("${myString} contains ${mySubstring}")
	else()
		dk_info("${myString} does NOT contain ${mySubstring}")
	endif()
	
	dk_stringContainsCI("${myString}" "nonExistant")
	if(dk_stringContainsCI)
		dk_info("${myString} contains 'nonExistant'")
	else()
		dk_info("${myString} does NOT contain 'nonExistant'")
	endif()
	
	list(APPEND myList "one")
	list(APPEND myList "two")
	list(APPEND myList "three")
	dk_stringContainsCI("${myList}" "TWO")
	if(dk_stringContainsCI)
		dk_info("${myList} contains 'TWO'")
	else()
		dk_info("${myList} does NOT contain 'TWO'")
	endif()
endfunction()
