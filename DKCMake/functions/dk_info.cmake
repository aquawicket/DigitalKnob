include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()


##################################################################################
# dk_info(msg) HALT, NO_HALT, TRACE, NO_TRACE, PAUSE, NO_PAUSE
#
#	Print a info message to the console
#
#	@msg	- The message to print
#
function(dk_info msg)
	dk_debugFunc(${ARGV})

	dk_if(NOT DEFINED ENABLE_dk_INFO "set(ENABLE_dk_info  1        CACHE INTERNAL '')")
	dk_if(NOT DEFINED PAUSE_ON_INFO  "set(PAUSE_ON_INFO   0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED TRACE_ON_INFO  "set(TRACE_ON_INFO   0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED LINE_ON_INFO   "set(LINE_ON_INFO    0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED HALT_ON_INFO   "set(HALT_ON_INFO    0        CACHE INTERNAL '')")
	dk_if(NOT DEFINED INFO_TAG       "set(INFO_TAG       'INFO: ' CACHE INTERNAL '')")

	dk_if(NOT ENABLE_dk_info "return()")
	
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
	dk_echo("${white}${INFO_TAG}${msg}${clr}")

	if((PAUSE_ON_INFO OR PAUSE) AND NOT NO_PAUSE)
		dk_echo("${white}*** PAUSE_ON_INFO ***${clr}")
		dk_pause()
	endif()
	if((TRACE_ON_INFO OR TRACE) AND NOT NO_TRACE)
		message(WARNING "${white}*** TRACE_ON_INFO ***")
		dk_echo("${clr}")
	endif()
	if((LINE_ON_INFO OR LINE) AND NOT NO_LINE)
		dk_echo("${white}*** LINE_ON_INFO ***${clr}")
		dk_todo("LINE_ON_INFO\n")
	endif()
	if((HALT_ON_INFO OR HALT) AND NOT NO_HALT)
		dk_echo("${white}*** HALT_ON_INFO ***${clr}")
		dk_exit(0)
	endif()	
endfunction()






function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	set(ENABLE_dk_info 1)
	set(PAUSE_ON_INFO 1)
	set(TRACE_ON_INFO 1)
	set(LINE_ON_INFO 1)
	set(HALT_ON_INFO 1)
	set(INFO_TAG "DKTEST_INFO: ")
	dk_info("test dk_info message")
endfunction()
