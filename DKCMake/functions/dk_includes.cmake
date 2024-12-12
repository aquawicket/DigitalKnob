#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_includes(variable find rtn_var)
#
#	Check if a string contains a substring
#
#	@variable	- The variable
#	@find		- The substring to search for
#	@rtn_var		- Returns true if the str contains the substr. Otherwise returns false
#
function(dk_includes)
	dk_debugFunc(3 99)
	#dk_debugFunc(string, string, int)
	
	set(variable 	"${ARGV0}")
	set(find 		"${ARGV1}")
	set(rtn_var 	${ARGV2})
	
	string(FIND "${variable}" "${find}" index)
	
	math(EXPR index "${index}+1")
	set(${rtn_var} ${index} PARENT_SCOPE)
	
#if(DEBUG_CMAKE)	
	if(${index})
		dk_debug("dk_includes(${ARGV}): rtn_var:${rtn_var}:${index}:isTure")
	else()
		dk_debug("dk_includes(${ARGV}): rtn_var:${rtn_var}:${index}:isFalse")
	endif()
#endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(myString "There is a needle in this haystack")
	set(mySubstring "needle")
	dk_includes("${myString}" "${mySubstring}" result)
	if(result)
		dk_info("myString contains mySubstring")
	else()
		dk_info("myString does NOT contain mySubstring")
	endif()
	
	dk_includes("${myString}" "nonexistant" result)
	if(result)
		dk_info("myString contains nonexistant")
	else()
		dk_info("myString does NOT contain nonexistant")
	endif()
	
	list(APPEND myList "one")
	list(APPEND myList "two")
	list(APPEND myList "three")
	dk_includes("${myList}" "two" result)
	if(result)
		dk_info("myList contains two")
	else()
		dk_info("myList does NOT contain two")
	endif()
endfunction()
