#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_stringContains(variable find)
#
#	Check if a string contains a substring
#
#	@variable				- The string to search within
#	@find					- The substring to search for
#	${dk_stringContains}	- Returns index: Returns the index of the string if located
#
function(dk_stringContains)
	dk_debugFunc(2 99)
	
	### variable ###
	if(DEFINED "${ARGV0}")
		set(variable 	"${${ARGV0}}")
	elseIF(DEFINED ARGV0)
		set(variable 	"${ARGV0}")
	else()
		dk_fatal("dk_stringContains(${ARGV}): ARGV0:${ARGV0} is invalid.")
	endif()
#	dk_getArg(${ARGV0} variable)

	### find ###
	if(DEFINED "${ARGV1}")
		set(find 		"${${ARGV1}}")
	elseif(DEFINED ARGV1)
		set(find 		"${ARGV1}")
	else()
		dk_fatal("dk_stringContains(${ARGV}): ARGV1:${ARGV1} is invalid.")
	endif()
#	dk_getArg(${ARGV1} find)

	string(FIND "${variable}" "${find}" dk_stringContains)
	math(EXPR dk_stringContains "${dk_stringContains}+1")
	set(dk_stringContains ${dk_stringContains} PARENT_SCOPE)
	
#if(DEBUG_CMAKE)	
	if(${dk_stringContains})
		dk_debug("dk_stringContains(${ARGV}): RTN:${dk_stringContains}:isTrue")
	else()
		dk_debug("dk_stringContains(${ARGV}): RTN:${dk_stringContains}:isFalse")
	endif()
#endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(myString "There is a needle in this haystack")
	set(mySubstring "needle")
	dk_stringContains("${myString}" "${mySubstring}")
	if(dk_stringContains)
		dk_info("${myString} contains ${mySubstring}")
	else()
		dk_info("${myString} does NOT contain ${mySubstring}")
	endif()
	
	set(myString "There is a needle in this haystack")
	set(mySubstring "needle")
	dk_stringContains(myString "${mySubstring}")
	if(dk_stringContains)
		dk_info("${myString} contains ${mySubstring}")
	else()
		dk_info("${myString} does NOT contain ${mySubstring}")
	endif()
	
	dk_stringContains("${myString}" "nonexistant")
	if(dk_stringContains)
		dk_info("${myString} contains ${mySubstring}")
	else()
		dk_info("${myString} does NOT contain 'nonexistant'")
	endif()
	
	list(APPEND myList "one")
	list(APPEND myList "two")
	list(APPEND myList "three")
	dk_stringContains("${myList}" "two")
	if(dk_stringContains)
		dk_info("${myList} contains 'two'")
	else()
		dk_info("${myList} does NOT contain 'two'")
	endif()
endfunction()
