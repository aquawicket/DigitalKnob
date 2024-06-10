include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_getEnv(name RESULT)
#
#	Get a system environment variable
#
#	@name		- The name of the system environment variable to get
#	@RESULT		- Returns the value of the system environment vairable
#
function(dk_getEnv name RESULT)
	dk_debugFunc(${ARGV})
	
	dk_printVar(ENV{${name}})
	set(${RESULT} $ENV{${name}} PARENT_SCOPE)
endfunction()






function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)
