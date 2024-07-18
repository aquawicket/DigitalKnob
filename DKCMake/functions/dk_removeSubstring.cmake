include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
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
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 3)
		dk_error("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()


	dk_replaceAll("${fromthis}" "${removethis}" "" removeSubstring)
	dk_printVar(removeSubstring)
	set("${rtn_var}" "${removeSubstring}" PARENT_SCOPE)
endfunction()
dk_createOsMacros("dk_removeSubstring")





function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	set(myString "You have never had a good day today or anyday")
	dk_removeSubstring("have never " "${myString}" myString)
	dk_removeSubstring(" or anyday" "${myString}" myString)
	dk_info("${myString}")
endfunction()