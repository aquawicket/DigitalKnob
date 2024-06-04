include(${DKCMAKE_DIR}/functions/DK.cmake)
include_guard()

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
	dk_debugFunc(${ARGV})
	
	string(FIND "${variable}" "${find}" index)
	if(${index} GREATER -1)
		set(${RESULT} TRUE PARENT_SCOPE)
	else()
		set(${RESULT} FALSE PARENT_SCOPE)
	endif()
endfunction()
