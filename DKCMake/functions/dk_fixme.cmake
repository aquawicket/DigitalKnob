include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()


if(NOT DEFINED ENABLE_dk_fixme)
	set(ENABLE_dk_fixme 1 CACHE INTERNAL "")
endif()
if(NOT DEFINED TRACE_ON_FIXME)
	set(TRACE_ON_FIXME 0 CACHE INTERNAL "")
endif()
if(NOT DEFINED PAUSE_ON_FIXME)
	set(PAUSE_ON_FIXME 0 CACHE INTERNAL "")
endif()
if(NOT DEFINED HALT_ON_FIXME)
	set(HALT_ON_FIXME 0 CACHE INTERNAL "")
endif()
###############################################################################
# dk_fixme(msg)
#
#	@msg (optional)	- A message to print
#
function(dk_fixme msg)
	dk_debugFunc(${ARGV})

	if(NOT ENABLE_dk_fixme)
		return()
	endif()
	
	dk_getOption(HALT ${ARGV})
	dk_getOption(NO_HALT ${ARGV})
	dk_getOption(TRACE ${ARGV})
	dk_getOption(NO_TRACE ${ARGV})
	dk_getOption(PAUSE ${ARGV})
	dk_getOption(NO_PAUSE ${ARGV})
	
	#dk_updateLogInfo()
	#message("${H_black}${STACK_HEADER}${clr}${yellow}${msg}${clr}")	
	if(HALT_ON_FIXME OR HALT AND NOT NO_HALT)
		message("${yellow}*** HALT_ON_FIXME ***")
		message(FATAL_ERROR "FIXME: ${H_yellow}${msg}${clr}")
		#dk_exit(1)
	elseif(TRACE_ON_FIXME OR TRACE AND NOT NO_TRACE)
		message("${yellow}*** TRACE_ON_FIXME ***")
		message(WARNING "FIXME: ${H_yellow}${msg}${clr}")
	else()
		message("${yellow}FIXME:${H_yellow}${msg}${clr}")
	endif()
	
	if(PAUSE_ON_FIXME OR PAUSE AND NOT NO_PAUSE)
		message("${yellow}*** PAUSE_ON_FIXME ***${clr}")
		dk_pause()
	endif()
endfunction()





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})

	dk_fixme()
endfunction(DKTEST)