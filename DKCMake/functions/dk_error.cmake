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
# dk_error(msg) NOASSERT
#
#	Print a error message to the console
#
#	@msg	- The message to print
#
function(dk_error msg)
	#DKDEBUGFUNC(${ARGV})
	
	if(NOT ENABLE_dk_error)
		return()
	endif()
	
	dk_get_option(HALT ${ARGV})
	dk_get_option(NO_HALT ${ARGV})
	dk_get_option(TRACE ${ARGV})
	dk_get_option(NO_TRACE ${ARGV})
	dk_get_option(PAUSE ${ARGV})
	dk_get_option(NO_PAUSE ${ARGV})
	
	dk_printvar(msg)
	#dk_dumpAllVariables(${CMAKE_BINARY_DIR}/dk_trace_variables.temp)
	#dk_updateLogInfo()
	#message("${H_black}${STACK_HEADER}${clr}${red}${msg}${clr}")	
	if(HALT_ON_ERROR OR HALT AND NOT NO_HALT)
		message("${red}*** HALT_ON_ERROR ***${clr}")
		message("${red}")
		message(FATAL_ERROR "ERROR:${clr} ${BG_red}${msg}${clr}${red}")
		message("${clr}")
	else()
		if(TRACE_ON_ERROR OR TRACE AND NOT NO_TRACE)
			message("${red}")
			message(WARNING "ERROR:${clr} ${H_red}${msg}${clr}${red}")
			message("${clr}")
		else()
			message("${red}")
			message("ERROR:${clr} ${H_red}${msg}${clr}${red}")
			message("${clr}")
		endif()
	endif()
	
	if(PAUSE_ON_ERROR OR PAUSE AND NOT NO_PAUSE)
		message("${red}*** PAUSE_ON_ERROR ***${clr}")
		dk_pause()
	endif()
endfunction()
