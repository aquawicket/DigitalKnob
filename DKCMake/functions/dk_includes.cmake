include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


###############################################################################
# dk_includes(variable find RESULT)
#
#	Check if a string contains a substring
#
#	@variable	- The variable
#	@find		- The substring to search for
#	@RESULT		- Returns true if the str contains the substr. Otherwise returns false
#
function(dk_includes variable find RESULT)
	#DKDEBUGFUNC(${ARGV})
	string(FIND "${variable}" "${find}" index)
	if(${index} GREATER -1)
		set(${RESULT} TRUE PARENT_SCOPE)
	else()
		set(${RESULT} FALSE PARENT_SCOPE)
	endif()
endfunction()
