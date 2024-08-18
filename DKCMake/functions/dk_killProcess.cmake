include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_killProcess(name)
#
#	Kill a running process by name
#
#	@name		- name of the process to kill
#
function(dk_killProcess name)
	dk_debugFunc(${ARGV})
	
	dk_executeProcess("taskkill /f /im ${name}" NO_HALT)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()