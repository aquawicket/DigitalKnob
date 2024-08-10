include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
##include_guard()


##################################################################################
# dk_debug(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
function(dk_debug msg)
	dk_debugFunc(${ARGV})
	
	dk_if(NOT DEFINED ENABLE_dk_debug "set(ENABLE_dk_debug  1        CACHE INTERNAL '')")
	dk_if(NOT DEFINED PAUSE_ON_DEBUG  "set(PAUSE_ON_DEBUG   0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED TRACE_ON_DEBUG  "set(TRACE_ON_DEBUG   0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED LINE_ON_DEBUG   "set(LINE_ON_DEBUG    0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED HALT_ON_DEBUG   "set(HALT_ON_DEBUG    0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED DEBUG_TAG       "set(DEBUG_TAG       'DEBUG: ' CACHE INTERNAL '')")

	dk_if(NOT ENABLE_dk_debug "return()")
	
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
	dk_echo("${blue}${DEBUG_TAG}${msg}${clr}")
	
	if((PAUSE_ON_DEBUG OR PAUSE) AND NOT NO_PAUSE)
		dk_echo("${blue}*** PAUSE_ON_DEBUG ***${clr}")
		dk_pause()
	endif()
	if((TRACE_ON_DEBUG OR TRACE) AND NOT NO_TRACE)
		message(WARNING "${blue}*** TRACE_ON_DEBUG ***")
		dk_echo("${clr}")
	endif()
	if((LINE_ON_DEBUG OR LINE) AND NOT NO_LINE)
		dk_echo("${blue}*** LINE_ON_DEBUG ***${clr}")
		dk_todo("LINE_ON_DEBUG\n")
	endif()
	if((HALT_ON_DEBUG OR HALT) AND NOT NO_HALT)
		dk_echo("${blue}*** HALT_ON_DEBUG ***${clr}")
		dk_exit(0)
	endif()	
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	set(ENABLE_dk_debug 1)
	set(PAUSE_ON_DEBUG 1)
	set(TRACE_ON_DEBUG 1)
	set(LINE_ON_DEBUG 1)
	set(HALT_ON_DEBUG 1)
	set(DEBUG_TAG "DKTEST_DEBUG: ")
	dk_debug("test dk_debug message")
endfunction()
