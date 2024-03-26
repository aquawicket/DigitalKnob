include_guard()

###############################################################################
# dk_setEnv(name value)
#
#	Set a system environment variable
#
#	@name	- The name of the system environment variable to set
#	@value	- The value to set the system environment vairable to
#
# BE CAREFUL WITH THIS. It can make the shell unresponsive to commands
function(dk_setEnv name value)
	#DKDEBUGFUNC(${ARGV})
	#dk_debug("dk_setEnv(${ARGV})")
	if(EXISTS "${value}")
		dk_debug("Converting value to NATIVE_PATH")
		file(TO_NATIVE_PATH "${value}" value)
	endif()
	if(DEFINED ENV{${name}})
		dk_warn("${name} is already defined")
	endif()
	#dk_info("Setting ENV{${name}} environment variable to ${value}")
	set(ENV{${name}} "${value}")
	#dk_debug(ENV{${name}} PRINTVAR)
	
	#dk_debug(ENV{${name}} PRINTVAR)
	#dk_debug(value PRINTVAR)
	#if(ENV{${name}})
	#	string(FIND $ENV{${name}} ${value} index)
	#else()
	#	set(index -1)
	#endif()
	#if(${index} EQUAL -1)
	#		if(NOT "$ENV{${name}}" STREQUAL "${value}")
	#	if(WIN_HOST)
	#		dk_info("Setting %${name}% environment variable to ${value}")
	#		set(ENV{${name}} ${value})
	#		#dk_executeProcess(setx ${name} ${value}) # https://stackoverflow.com/a/69246810		#FIXME
	#		#execute_process(COMMAND cmd /c setx ${name} ${value}) # https://stackoverflow.com/a/69246810
	#	else()
	#		dk_warn("dk_setEnv() not implemented on this system")
	#	endif()
	#endif()
endfunction()