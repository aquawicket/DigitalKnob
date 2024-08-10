include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()


##################################################################################
# dk_error(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a error dk_echo to the console
#
#	@msg	- The dk_echo to print
#
function(dk_error msg)
	dk_debugFunc(${ARGV})
	
	dk_if(NOT DEFINED ENABLE_dk_error "set(ENABLE_dk_error  1        CACHE INTERNAL '')")
	dk_if(NOT DEFINED PAUSE_ON_ERROR  "set(PAUSE_ON_ERROR   0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED TRACE_ON_ERROR  "set(TRACE_ON_ERROR   0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED LINE_ON_ERROR   "set(LINE_ON_ERROR    0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED HALT_ON_ERROR   "set(HALT_ON_ERROR    0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED ERROR_TAG       "set(ERROR_TAG       'ERROR: ' CACHE INTERNAL '')")

	dk_if(NOT ENABLE_dk_error "return()")
	
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
	dk_echo("${red}${ERROR_TAG}${msg}${clr}")
	
	if((PAUSE_ON_ERROR OR PAUSE) AND NOT NO_PAUSE)
		dk_echo("${red}*** PAUSE_ON_ERROR ***${clr}")
		dk_pause()
	endif()
	if((TRACE_ON_ERROR OR TRACE) AND NOT NO_TRACE)
		message(WARNING "${red}*** TRACE_ON_ERROR ***")
		dk_echo("${clr}")
	endif()
	if((LINE_ON_ERROR OR LINE) AND NOT NO_LINE)
		dk_echo("${red}*** LINE_ON_ERROR ***${clr}")
		dk_todo("LINE_ON_ERROR\n")
	endif()
	if((HALT_ON_ERROR OR HALT) AND NOT NO_HALT)
		dk_echo("${red}*** HALT_ON_ERROR ***${clr}")
		dk_exit(1)
	endif()	
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	set(ENABLE_dk_error 1)
	set(PAUSE_ON_ERROR 1)
	set(TRACE_ON_ERROR 1)
	set(LINE_ON_ERROR 1)
	set(HALT_ON_ERROR 1)
	set(ERROR_TAG "DKTEST_ERROR: ")
	dk_error("test dk_error message")
	
endfunction()
