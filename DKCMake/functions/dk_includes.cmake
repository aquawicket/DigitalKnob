include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
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
	#dk_debugFunc("\${ARGV}")
	
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
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()
