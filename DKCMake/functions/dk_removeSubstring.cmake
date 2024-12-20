#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

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
	dk_debugFunc()
	if(NOT ${ARGC} EQUAL 3)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()


	dk_replaceAll("${fromthis}" "${removethis}" "" removeSubstring)
	#dk_printVar(removeSubstring)
	set("${rtn_var}" "${removeSubstring}" PARENT_SCOPE)
endfunction()
dk_createOsMacros("dk_removeSubstring")





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	set(myString "You have never had a good day today or anyday")
	dk_removeSubstring("have never " "${myString}" myString)
	dk_removeSubstring(" or anyday" "${myString}" myString)
	dk_info("${myString}")
endfunction()