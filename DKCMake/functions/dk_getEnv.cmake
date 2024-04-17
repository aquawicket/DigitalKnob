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
	DKDEBUGFUNC(${ARGV})
	
	dk_debug(ENV{${name}})
	set(${RESULT} $ENV{${name}} PARENT_SCOPE)
endfunction()
