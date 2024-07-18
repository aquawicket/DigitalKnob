include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_confirm(rtn_var)
#
#
function(dk_confirm rtn_var)
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 0)
		dk_error("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()

	dk_echo("${yellow} Are you sure ? [Y/N] ${clr}")
	
	dk_fixme()
#	read -rp $" " REPLY
	dk_echo()
	dk_echo()
	if("${REPLY}" STREQUAL "y") 
		return(PROPAGATE 1)
	endif()
	if("${REPLY}" STREQUAL "Y")
		return(PROPAGATE 1)
	endif()
	return(PROPAGATE 0)
endfunction()





function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_confirm(result)
	if(result) 
		dk_echo("the confimation has passed")
	else()
		dk_echo("the confimation has failed")
	endif()
endfunction()