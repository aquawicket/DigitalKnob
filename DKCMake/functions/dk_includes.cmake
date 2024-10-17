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
function(dk_includes variable find rtn_var)
	#dk_debugFunc()
	
	string(FIND "${variable}" "${find}" index)
	if(${index} GREATER -1)
		set(includes 1)
	else()
		set(includes 0)
	endif()
	
	#dk_printVar(includes)
	set(${rtn_var} ${includes} PARENT_SCOPE)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	set(myString "There is a needle in this haystack")
	set(mySubstring "needle")
	dk_includes(${myString} ${mySubstring} result)
	if(result)
		dk_info("myString contains mySubstring")
	else()
		dk_info("myString does NOT contain mySubstring")
	endif()
	
	dk_includes(${myString} "nonexistant" result)
	if(result)
		dk_info("myString contains nonexistant")
	else()
		dk_info("myString does NOT contain nonexistant")
	endif()
endfunction()
