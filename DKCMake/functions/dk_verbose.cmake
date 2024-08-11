include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()


##################################################################################
# dk_verbose(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a verbose message to the console
#
#	@msg	- The message to print
#
function(dk_verbose msg)
	dk_debugFunc(${ARGV})

	dk_log(VERBOSE "${ARGV0}")
	return()
	
	
	dk_if(NOT DEFINED ENABLE_dk_verbose "set(ENABLE_dk_verbose  1        CACHE INTERNAL '')")
	dk_if(NOT DEFINED PAUSE_ON_VERBOSE  "set(PAUSE_ON_VERBOSE   0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED TRACE_ON_VERBOSE  "set(TRACE_ON_VERBOSE   0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED LINE_ON_VERBOSE   "set(LINE_ON_VERBOSE    0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED HALT_ON_VERBOSE   "set(HALT_ON_VERBOSE    0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED VERBOSE_TAG       "set(VERBOSE_TAG       'VERBOSE: ' CACHE INTERNAL '')")

	dk_if(NOT ENABLE_dk_verbose "return()")
	
	dk_getOption(HALT ${ARGV})
	dk_getOption(NO_HALT ${ARGV})
	dk_getOption(TRACE ${ARGV})
	dk_getOption(NO_TRACE ${ARGV})
	dk_getOption(PAUSE ${ARGV})
	dk_getOption(NO_PAUSE ${ARGV})
	
#	if(NOT echo_fileline)
#		__FILE__(_FILE_ 0)
#		__LINE__(_LINE_ 0)
#		dk_basename("${_FILE_}" _FILE_)
#		set(echo_fileline "${_FILE_}:${_LINE_}   " CACHE INTERNAL "")
#	endif()
	
#	set(msg ${ARGV})
	dk_echo("${cyan}${VERBOSE_TAG}${msg}${clr}")
	
	if((PAUSE_ON_VERBOSE OR PAUSE) AND NOT NO_PAUSE)
		dk_echo("${cyan}*** PAUSE_ON_VERBOSE ***${clr}")
		dk_pause()
	endif()
	if((TRACE_ON_VERBOSE OR TRACE) AND NOT NO_TRACE)
		message(WARNING "${cyan}*** TRACE_ON_VERBOSE ***")
		dk_echo("${clr}")
	endif()
	if((LINE_ON_VERBOSE OR LINE) AND NOT NO_LINE)
		dk_echo("${cyan}*** LINE_ON_VERBOSE ***${clr}")
		dk_todo("LINE_ON_VERBOSE\n")
	endif()
	if((HALT_ON_VERBOSE OR HALT) AND NOT NO_HALT)
		dk_echo("${cyan}*** HALT_ON_VERBOSE ***${clr}")
		dk_exit(0)
	endif()	
endfunction()






function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	set(ENABLE_dk_verbose 1)
	set(PAUSE_ON_VERBOSE 1)
	set(TRACE_ON_VERBOSE 1)
	set(LINE_ON_VERBOSE 1)
	set(HALT_ON_VERBOSE 1)
	set(VERBOSE_TAG "DKTEST_VERBOSE: ")
	dk_verbose("test dk_verbose message")
endfunction()
