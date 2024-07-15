include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

#dk_set(ENABLE_dk_verbose 1)
#dk_set(TRACE_ON_VERBOSE 1)
#dk_set(LINE_ON_VERBOSE 1)
#dk_set(PAUSE_ON_VERBOSE 1)
#dk_set(HALT_ON_VERBOSE 1)
#dk_set(VERBOSE_TAG " VERBOSE: ")
##################################################################################
# dk_verbose(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a verbose message to the console
#
#	@msg	- The message to print
#
function(dk_verbose msg)
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 1)
		dk_error("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
	
	
	if(NOT DEFINED ENABLE_dk_verbose)
		set(ENABLE_dk_verbose 0 CACHE INTERNAL "")
	endif()
	if(NOT ENABLE_dk_verbose)
		return()
	endif()
	
	dk_getOption(HALT ${ARGV})
	dk_getOption(NO_HALT ${ARGV})
	dk_getOption(TRACE ${ARGV})
	dk_getOption(NO_TRACE ${ARGV})
	dk_getOption(PAUSE ${ARGV})
	dk_getOption(NO_PAUSE ${ARGV})
	
	if(NOT DEFINED VERBOSE_TAG)
		set(VERBOSE_TAG " VERBOSE: " CACHE INTERNAL "")
	endif()
	
	if(NOT echo_fileline)
		__FILE__(_FILE_ 0)
		__LINE__(_LINE_ 0)
		dk_getBasename("${_FILE_}" _FILE_)
		set(echo_fileline "${_FILE_}:${_LINE_}   " CACHE INTERNAL "")
	endif()
	
	set(msg ${ARGV})
	if((HALT_ON_VERBOSE OR HALT) AND NOT NO_HALT)
		dk_echo("${magenta}")
		dk_echo("*** HALT_ON_VERBOSE ***")
		dk_echo(FATAL_ERROR "${VERBOSE_TAG}${msg}")
		dk_echo("${clr}")
		dk_exit(1)
	else()
		if((TRACE_ON_VERBOSE OR TRACE) AND NOT NO_TRACE)
			dk_echo("${magenta}")
			dk_echo("*** TRACE_ON_VERBOSE ***")
			dk_echo(WARNING "${VERBOSE_TAG}${msg}")
			dk_echo("${clr}")
			#dk_dumpAllVariables(${CMAKE_BINARY_DIR}/dk_trace_variables.temp)
		else()
			dk_echo("${magenta}${VERBOSE_TAG}${msg}${clr}")
		endif()
	endif()
	
	if((PAUSE_ON_VERBOSE OR PAUSE) AND NOT NO_PAUSE)
		dk_echo("${magenta}*** PAUSE_ON_VERBOSE ***${clr}")
		dk_pause()
	endif()
endfunction()






function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_set(ENABLE_dk_verbose 1)
	dk_verbose("test dk_verbose message")
endfunction()
