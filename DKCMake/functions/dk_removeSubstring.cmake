#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_removeSubstring(removethis fromthis rtn_var)
#
#	TODO
#
#	@removethis		- TODO
#	@fromthis		- TODO
#	@rtn_var			- TODO
#
function(dk_removeSubstring removethis fromthis rtn_var)
<<<<<<< HEAD
	dk_debugFunc()
	if(NOT ${ARGC} EQUAL 3)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()

=======
	dk_debugFunc(3)
>>>>>>> Development

	dk_replaceAll("${fromthis}" "${removethis}" "" removeSubstring)
	#dk_printVar(removeSubstring)
	set("${rtn_var}" "${removeSubstring}" PARENT_SCOPE)
endfunction()
<<<<<<< HEAD
dk_createOsMacros("dk_removeSubstring")
=======
>>>>>>> Development





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	set(myString "You have never had a good day today or anyday")
	dk_removeSubstring("have never " "${myString}" myString)
	dk_removeSubstring(" or anyday" "${myString}" myString)
	dk_info("${myString}")
endfunction()