include_guard()


if(NOT DEFINED ENABLE_dk_todo)
	set(ENABLE_dk_todo 1 CACHE INTERNAL "")
endif()
if(NOT DEFINED TRACE_ON_TODO)
	set(TRACE_ON_TODO 0 CACHE INTERNAL "")
endif()
if(NOT DEFINED PAUSE_ON_TODO)
	set(PAUSE_ON_TODO 0 CACHE INTERNAL "")
endif()
if(NOT DEFINED HALT_ON_TODO)
	set(HALT_ON_TODO 0 CACHE INTERNAL "")
endif()
###############################################################################
# dk_todo(msg)
#
#	print a TODO message and wait 10 seconds
#
#	@msg (optional)	- A header message to print
#
function(dk_todo msg)
	#DKDEBUGFUNC(${ARGV})

	if(NOT ENABLE_dk_todo)
		return()
	endif()
	
	dk_get_option(HALT ${ARGV})
	dk_get_option(NO_HALT ${ARGV})
	dk_get_option(TRACE ${ARGV})
	dk_get_option(NO_TRACE ${ARGV})
	dk_get_option(PAUSE ${ARGV})
	dk_get_option(NO_PAUSE ${ARGV})
	
	dk_printvar(msg)
	#dk_updateLogInfo()
	#message("${H_black}${STACK_HEADER}${clr}${yellow}${msg}${clr}")	
	if(HALT_ON_TODO OR HALT AND NOT NO_HALT)
		message("${yellow}*** HALT_ON_TODO ***${clr}")
		message("${red}")
		message(FATAL_ERROR "${yellow}TODO:${clr} ${H_yellow}${msg}${clr}${red}")
		message("${clr}")
		#dk_exit(1)
	elseif(TRACE_ON_TODO OR TRACE AND NOT NO_TRACE)
		message("${yellow}")
		message(WARNING "TODO:${clr} ${H_yellow}${msg}${clr}${yellow}")
		message("${clr}")
	else()
		message("${yellow}")
		message("TODO:${clr} ${H_yellow}${msg}${clr}${yellow}")
		message("${clr}")
	endif()
	
	if(PAUSE_ON_TODO OR PAUSE AND NOT NO_PAUSE)
		message("${yellow}*** PAUSE_ON_TODO ***${clr}")
		dk_pause()
	endif()
endfunction()