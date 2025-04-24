#!/usr/bin/cmake -P
<<<<<<< HEAD
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
	
	if(variable MATCHES "${find}")
		set(includes 1)
	else()
		set(includes 0)
	endif()
	
	#dk_printVar(includes)
	set(${rtn_var} ${includes} PARENT_SCOPE)
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
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
>>>>>>> Development
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	set(myString "There is a needle in this haystack")
	set(mySubstring "needle")
	dk_includes(${myString} ${mySubstring} result)
	if(result)
=======
	dk_debugFunc(0)
	
	set(myString "There is a needle in this haystack")
	set(mySubstring "needle")
	dk_includes("${myString}" "${mySubstring}")
	if(dk_includes)
>>>>>>> Development
		dk_info("myString contains mySubstring")
	else()
		dk_info("myString does NOT contain mySubstring")
	endif()
	
<<<<<<< HEAD
	dk_includes(${myString} "nonexistant" result)
	if(result)
=======
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
>>>>>>> Development
		dk_info("myString contains nonexistant")
	else()
		dk_info("myString does NOT contain nonexistant")
	endif()
	
	list(APPEND myList "one")
	list(APPEND myList "two")
	list(APPEND myList "three")
<<<<<<< HEAD
	dk_includes("${myList}" "two" result)
	if(result)
=======
	dk_includes("${myList}" "two")
	if(dk_includes)
>>>>>>> Development
		dk_info("myList contains two")
	else()
		dk_info("myList does NOT contain two")
	endif()
endfunction()
