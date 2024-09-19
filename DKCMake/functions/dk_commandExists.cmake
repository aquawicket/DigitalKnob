include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_commandExists()
#
#
function(dk_commandExists commandName rtn_var)
	dk_debugFunc("\${ARGV}")
	
	if(COMMAND ${commandName})
		set(${rtn_var} TRUE PARENT_SCOPE)
		return()
	endif()
	
	set(${rtn_var} FALSE PARENT_SCOPE)
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_commandExists("echo" echo_exists)
	if(echo_exists)
		dk_info("command: echo exists")
	else()
		dk_info("command: echo does not exist")
	endif()
endfunction()