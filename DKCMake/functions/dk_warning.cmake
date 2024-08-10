include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()


##################################################################################
# dk_warning(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a warning message to the console
#
#	@msg	- The message to print
#
function(dk_warning msg)
	dk_debugFunc(${ARGV})

	dk_if(NOT DEFINED ENABLE_dk_warning "set(ENABLE_dk_warning  1          CACHE INTERNAL '')")
	dk_if(NOT DEFINED PAUSE_ON_WARNING  "set(PAUSE_ON_WARNING   0          CACHE INTERNAL '')")
	dk_if(NOT DEFINED TRACE_ON_WARNING  "set(TRACE_ON_WARNING   0          CACHE INTERNAL '')")
	dk_if(NOT DEFINED LINE_ON_WARNING   "set(LINE_ON_WARNING    0          CACHE INTERNAL '')")
	dk_if(NOT DEFINED HALT_ON_WARNING   "set(HALT_ON_WARNING    0          CACHE INTERNAL '')")
	dk_if(NOT DEFINED WARNING_TAG       "set(WARNING_TAG       'WARNING: ' CACHE INTERNAL '')")

	dk_if(NOT ENABLE_dk_warning "return()")	
	
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
	dk_echo("${yellow}${WARNING_TAG}${msg}${clr}")
	
	if((PAUSE_ON_WARNING OR PAUSE) AND NOT NO_PAUSE)
		dk_echo("${yellow}*** PAUSE_ON_WARNING ***${clr}")
		dk_pause()
	endif()
	if((TRACE_ON_WARNING OR TRACE) AND NOT NO_TRACE)
		message(WARNING "${yellow}*** TRACE_ON_WARNING ***")
		dk_echo("${clr}")
	endif()
	if((LINE_ON_WARNING OR LINE) AND NOT NO_LINE)
		dk_echo("${yellow}*** LINE_ON_WARNING ***${clr}")
		dk_todo("LINE_ON_WARNING\n")
	endif()
	if((HALT_ON_WARNING OR HALT) AND NOT NO_HALT)
		dk_echo("${yellow}*** HALT_ON_WARNING ***${clr}")
		dk_exit(0)
	endif()	
endfunction()






function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	set(ENABLE_dk_warning 1)
	set(PAUSE_ON_WARNING 1)
	set(TRACE_ON_WARNING 1)
	set(LINE_ON_WARNING 1)
	set(HALT_ON_WARNING 1)
	set(WARNING_TAG "DKTEST_WARNING: ")
	dk_warning("test dk_warning message")
endfunction()
