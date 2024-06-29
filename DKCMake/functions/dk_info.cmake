include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

#dk_set(ENABLE_dk_info 0)
#dk_set(TRACE_ON_INFO 1)
#dk_set(LINE_ON_INFO 1)
#dk_set(PAUSE_ON_INFO 1)
#dk_set(HALT_ON_INFO 1)
#dk_set(INFO_TAG " INFO: ")
##################################################################################
# dk_info(msg)
#
#	Print a info message to the console
#
#	@msg	- The message to print
#
function(dk_info)
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 1)
		dk_error("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
	
	
	if(NOT DEFINED ENABLE_dk_info)
		set(ENABLE_dk_info 1 CACHE INTERNAL "")
	endif()
	if(NOT ENABLE_dk_info)
		return()
	endif()
	
	dk_getOption(HALT ${ARGV})
	dk_getOption(NO_HALT ${ARGV})
	dk_getOption(TRACE ${ARGV})
	dk_getOption(NO_TRACE ${ARGV})
	dk_getOption(PAUSE ${ARGV})
	dk_getOption(NO_PAUSE ${ARGV})
	
	dk_stacktrace()
	if(NOT echo_fileline)
		__FILE__(_FILE_ 0)
		__LINE__(_LINE_ 0)
		dk_getBasename("${_FILE_}" _FILE_)
		set(echo_fileline "${_FILE_}:${_LINE_}   " CACHE INTERNAL "")
	endif()
	
	set(msg ${ARGV})
	if(HALT_ON_INFO OR HALT AND NOT NO_HALT)
		dk_echo("${white}*** HALT_ON_INFO ***")
		message(FATAL_ERROR "${lwhite}${msg}${clr}")
		#dk_exit(1)
	else()
		if(TRACE_ON_INFO OR TRACE AND NOT NO_TRACE)
			dk_echo("${white}*** TRACE_ON_INFO ***")
			message(WARNING "${white}${msg}${clr}")
		else()
			dk_echo("${white}${msg}${clr}")
		endif()
	endif()
	
	if(PAUSE_ON_INFO OR PAUSE AND NOT NO_PAUSE)
		dk_echo("${white}*** PAUSE_ON_INFO ***${clr}")
		dk_pause()
	endif()
endfunction()






function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_info("Test string from dk_info")
endfunction()
