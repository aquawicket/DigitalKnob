#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_getEnv(name rtn_var)
#
#	Get a system environment variable
#
#	@name		- The name of the system environment variable to get
#	@rtn_var		- Returns the value of the system environment vairable
#
function(dk_getEnv name rtn_var)
	dk_debugFunc("\${ARGV}")
	
	dk_printVar(ENV{${name}})
	set(${rtn_var} $ENV{${name}} PARENT_SCOPE)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()
