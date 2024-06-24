include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()


if(NOT DEFINED ENABLE_dk_error)
	set(ENABLE_dk_error 1 CACHE INTERNAL "")
endif()
if(NOT DEFINED TRACE_ON_ERROR)
	set(TRACE_ON_ERROR 1 CACHE INTERNAL "")
endif()
if(NOT DEFINED PAUSE_ON_ERROR)
	set(PAUSE_ON_ERROR 0 CACHE INTERNAL "")
endif()
if(NOT DEFINED HALT_ON_ERROR)
	set(HALT_ON_ERROR 1 CACHE INTERNAL "")
endif()
##################################################################################
# dk_error(msg) NO_HALT
#
#	Print a error message to the console
#
#	@msg	- The message to print
#
function(dk_error msg)
	dk_debugFunc(${ARGV})
	
	if(NOT ENABLE_dk_error)
		return()
	endif()
	
	dk_getOption(HALT ${ARGV})
	dk_getOption(NO_HALT ${ARGV})
	dk_getOption(TRACE ${ARGV})
	dk_getOption(NO_TRACE ${ARGV})
	dk_getOption(PAUSE ${ARGV})
	dk_getOption(NO_PAUSE ${ARGV})
	
	#dk_dumpAllVariables(${CMAKE_BINARY_DIR}/dk_trace_variables.temp)
	
	#if(HALT_ON_ERROR OR HALT AND NOT NO_HALT)
	if(HALT_ON_ERROR AND NOT ${NO_HALT})
		message("${red}*** HALT_ON_ERROR ***")
		message(FATAL_ERROR "${RED}${msg}${clr}")
	else()
		#if(TRACE_ON_ERROR OR TRACE AND NOT NO_TRACE)
		if(TRACE_ON_ERROR)
			message("${red}*** TRACE_ON_ERROR ***")
			message(WARNING "${RED}${msg}${clr}")
		else()
			message("${red}${RED}${msg}${clr}")
		endif()
	endif()
	
	#if(PAUSE_ON_ERROR OR PAUSE AND NOT NO_PAUSE)
	if(PAUSE_ON_ERROR)
		message("${red}*** PAUSE_ON_ERROR ***${clr}")
		dk_pause()
	endif()
endfunction()







function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_error("test string from dk_error")
endfunction(DKTEST)