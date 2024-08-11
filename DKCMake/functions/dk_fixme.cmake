include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()


##################################################################################
# dk_fixme(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a fixme message to the console
#
#	@msg	- The message to print
#
function(dk_fixme msg)
	dk_debugFunc(${ARGV})

	dk_log(FIXME "${ARGV0}")
	return()
	
	dk_if(NOT DEFINED ENABLE_dk_fixme "set(ENABLE_dk_fixme  1        CACHE INTERNAL '')")
	dk_if(NOT DEFINED PAUSE_ON_FIXME  "set(PAUSE_ON_FIXME   1        CACHE INTERNAL '')")
	dk_if(NOT DEFINED TRACE_ON_FIXME  "set(TRACE_ON_FIXME   0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED LINE_ON_FIXME   "set(LINE_ON_FIXME    0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED HALT_ON_FIXME   "set(HALT_ON_FIXME    0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED FIXME_TAG       "set(FIXME_TAG       'FIXME: ' CACHE INTERNAL '')")

	dk_if(NOT ENABLE_dk_fixme "return()")
	
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
	dk_echo("${magenta}${FIXME_TAG}${msg}${clr}")
	
	if((PAUSE_ON_FIXME OR PAUSE) AND NOT NO_PAUSE)
		dk_echo("${magenta}*** PAUSE_ON_FIXME ***${clr}")
		dk_pause()
	endif()
	if((TRACE_ON_FIXME OR TRACE) AND NOT NO_TRACE)
		message(WARNING "${magenta}*** TRACE_ON_FIXME ***")
		dk_echo("${clr}")
	endif()
	if((LINE_ON_FIXME OR LINE) AND NOT NO_LINE)
		dk_echo("${magenta}*** LINE_ON_FIXME ***${clr}")
		dk_todo("LINE_ON_FIXME\n")
	endif()
	if((HALT_ON_FIXME OR HALT) AND NOT NO_HALT)
		dk_echo("${magenta}*** HALT_ON_FIXME ***${clr}")
		dk_exit(0)
	endif()	
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc(${ARGV})

	set(ENABLE_dk_fixme 1)
	set(PAUSE_ON_FIXME 1)
	set(TRACE_ON_FIXME 1)
	set(LINE_ON_FIXME 1)
	set(HALT_ON_FIXME 1)
	set(FIXME_TAG "DKTEST_FIXME: ")
	dk_fixme("test dk_fixme message")
endfunction()
