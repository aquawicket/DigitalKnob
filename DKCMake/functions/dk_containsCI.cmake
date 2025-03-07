#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_containsCI(variable find)
#
#	Check if a string contains a substring (Case Insensitive)
#
#	@variable				- The string to search within
#	@find					- The substring to search for
#	${dk_containsCI}	- Returns index: Returns the index of the string if located
#
function(dk_containsCI)
	dk_debugFunc(2 99)
	
	### variable ###
	if(DEFINED "${ARGV0}")
		set(variable 	"${${ARGV0}}")
	elseIF(DEFINED ARGV0)
		set(variable 	"${ARGV0}")
	else()
		dk_fatal("dk_containsCI(${ARGV}): ARGV0:${ARGV0} is invalid.")
	endif()

	### find ###
	if(DEFINED "${ARGV1}")
		set(find 		"${${ARGV1}}")
	elseif(DEFINED ARGV1)
		set(find 		"${ARGV1}")
	else()
		dk_fatal("dk_containsCI(${ARGV}): ARGV1:${ARGV1} is invalid.")
	endif()

	string(TOLOWER "${variable}" variable)
	string(TOLOWER "${find}" find)
	string(FIND "${variable}" "${find}" dk_containsCI)
	math(EXPR dk_containsCI "${dk_containsCI}+1")
	set(dk_containsCI ${dk_containsCI} PARENT_SCOPE)
	
#if(DEBUG_CMAKE)	
#	if(${dk_containsCI})
#		dk_debug("dk_containsCI(${ARGV}): RTN:${dk_containsCI}:isTrue")
#	else()
#		dk_debug("dk_containsCI(${ARGV}): RTN:${dk_containsCI}:isFalse")
#	endif()
#endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(myString "There is a Needle in this haystack")
	set(mySubstring "needle")
	dk_containsCI("${myString}" "${mySubstring}")
	if(dk_containsCI)
		dk_info("${myString} contains ${mySubstring}")
	else()
		dk_info("${myString} does NOT contain ${mySubstring}")
	endif()
	
	set(myString "There is a needle in this haystack")
	set(mySubstring "NEEDLE")
	dk_containsCI(myString "${mySubstring}")
	if(dk_containsCI)
		dk_info("${myString} contains ${mySubstring}")
	else()
		dk_info("${myString} does NOT contain ${mySubstring}")
	endif()
	
	dk_containsCI("${myString}" "nonExistant")
	if(dk_containsCI)
		dk_info("${myString} contains 'nonExistant'")
	else()
		dk_info("${myString} does NOT contain 'nonExistant'")
	endif()
	
	list(APPEND myList "one")
	list(APPEND myList "two")
	list(APPEND myList "three")
	dk_containsCI("${myList}" "TWO")
	if(dk_containsCI)
		dk_info("${myList} contains 'TWO'")
	else()
		dk_info("${myList} does NOT contain 'TWO'")
	endif()
endfunction()
