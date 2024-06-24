include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()


if(NOT DEFINED ENABLE_dk_info)
	set(ENABLE_dk_info 1 CACHE INTERNAL "")
	#dk_set(ENABLE_dk_info 1)
endif()
if(NOT DEFINED TRACE_ON_INFO)
	set(TRACE_ON_INFO 0 CACHE INTERNAL "")
	#dk_set(TRACE_ON_INFO 0)
endif()
if(NOT DEFINED PAUSE_ON_INFO)
	set(PAUSE_ON_INFO 0 CACHE INTERNAL "")
	#dk_set(PAUSE_ON_INFO 0)
endif()
if(NOT DEFINED HALT_ON_INFO)
	set(HALT_ON_INFO 0 CACHE INTERNAL "")
	#dk_set(HALT_ON_INFO 0)
endif()
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
	
	if(NOT ENABLE_dk_info)
		return()
	endif()
	
	dk_getOption(HALT ${ARGV})
	dk_getOption(NO_HALT ${ARGV})
	dk_getOption(TRACE ${ARGV})
	dk_getOption(NO_TRACE ${ARGV})
	dk_getOption(PAUSE ${ARGV})
	dk_getOption(NO_PAUSE ${ARGV})
	
	set(msg ${ARGV})
	if(HALT_ON_INFO OR HALT AND NOT NO_HALT)
		message("${white}*** HALT_ON_INFO ***")
		message(FATAL_ERROR "${WHITE}${msg}${clr}")
		#dk_exit(1)
	else()
		if(TRACE_ON_INFO OR TRACE AND NOT NO_TRACE)
			message("${white}*** HALT_ON_INFO ***")
			message(WARNING "${WHITE}${msg}${clr}")
		else()
			message("${WHITE}${msg}${clr}")
		endif()
	endif()
	
	if(PAUSE_ON_INFO OR PAUSE AND NOT NO_PAUSE)
		message("${white}*** PAUSE_ON_INFO ***${clr}")
		dk_pause()
	endif()
endfunction()






function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_info("Test string from dk_info")
endfunction(DKTEST)
