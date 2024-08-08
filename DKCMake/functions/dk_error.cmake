include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

#dk_set(ENABLE_dk_error 0)
#dk_set(TRACE_ON_ERROR 1)
#dk_set(LINE_ON_ERROR 1)
#dk_set(PAUSE_ON_ERROR 1)
#dk_set(HALT_ON_ERROR 1)
#dk_set(ERROR_TAG " ERROR: ")
##################################################################################
# dk_error(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a error dk_echo to the console
#
#	@msg	- The dk_echo to print
#
function(dk_error msg)
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 1)
		dk_error("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
	
	
	if(NOT DEFINED ENABLE_dk_error)
		set(ENABLE_dk_error 1 CACHE INTERNAL "")
	endif()
	if(NOT ENABLE_dk_error)
		return()
	endif()
	
	dk_getOption(HALT ${ARGV})
	dk_getOption(NO_HALT ${ARGV})
	dk_getOption(TRACE ${ARGV})
	dk_getOption(NO_TRACE ${ARGV})
	dk_getOption(PAUSE ${ARGV})
	dk_getOption(NO_PAUSE ${ARGV})
	
	if(NOT DEFINED ERROR_TAG)
		set(ERROR_TAG " ERROR: " CACHE INTERNAL "")
	endif()
	
	if(NOT echo_fileline)
		__FILE__(_FILE_ 0)
		__LINE__(_LINE_ 0)
		dk_basename("${_FILE_}" _FILE_)
		set(echo_fileline "${_FILE_}:${_LINE_}   " CACHE INTERNAL "")
	endif()
	
	set(msg ${ARGV})
	if((HALT_ON_ERROR OR HALT) AND NOT NO_HALT)
		dk_echo("${red}")
		dk_echo("*** HALT_ON_ERROR ***")
		dk_echo(FATAL_ERROR "${ERROR_TAG}${msg}")
		dk_echo("${clr}")
		dk_exit(1)
	else()
		if((TRACE_ON_ERROR OR TRACE) AND NOT NO_TRACE)
			dk_echo("${red}")
			dk_echo("*** TRACE_ON_ERROR ***")
			dk_echo(WARNING "${ERROR_TAG}${msg}")
			dk_echo("${clr}")
			#dk_dumpAllVariables(${CMAKE_BINARY_DIR}/dk_trace_variables.temp)
		else()
			dk_echo("${red}${ERROR_TAG}${msg}${clr}")
		endif()
	endif()
	
	if((PAUSE_ON_ERROR OR PAUSE) AND NOT NO_PAUSE)
		dk_echo("${red}*** PAUSE_ON_ERROR ***${clr}")
		dk_pause()
	endif()
endfunction()






function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_set(ENABLE_dk_error 1)
	dk_error("test dk_error message")
endfunction()
