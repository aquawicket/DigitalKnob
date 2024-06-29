include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()


#dk_set(ENABLE_dk_fixme 0)
#dk_set(TRACE_ON_FIXME 1)
#dk_set(LINE_ON_FIXME 1)
#dk_set(PAUSE_ON_FIXME 1)
#dk_set(HALT_ON_FIXME 1)
#dk_set(FIXME_TAG " FIXME: ")
###############################################################################
# dk_fixme(msg)
#
#	@msg (optional)	- A message to print
#
function(dk_fixme)
	dk_debugFunc(${ARGV})


	if(NOT DEFINED ENABLE_dk_fixme)
		set(ENABLE_dk_fixme 1 CACHE INTERNAL "")
	endif()
	if(NOT ENABLE_dk_fixme)
		return()
	endif()
	
	dk_getOption(HALT ${ARGV})
	dk_getOption(NO_HALT ${ARGV})
	dk_getOption(TRACE ${ARGV})
	dk_getOption(NO_TRACE ${ARGV})
	dk_getOption(PAUSE ${ARGV})
	dk_getOption(NO_PAUSE ${ARGV})
	
	if(NOT DEFINED FIXME_TAG)
		set(FIXME_TAG " FIXME: " CACHE INTERNAL "")
	endif()
	
	if(HALT_ON_FIXME OR HALT AND NOT NO_HALT)
		dk_echo("${yellow}*** HALT_ON_FIXME ***")
		message(FATAL_ERROR "${yellow}FIXME: ${msg}${clr}")
		#dk_exit(1)
	elseif(TRACE_ON_FIXME OR TRACE AND NOT NO_TRACE)
		dk_echo("${yellow}*** TRACE_ON_FIXME ***")
		message(WARNING "${yellow}FIXME: ${yellow}${msg}${clr}")
	else()
		dk_echo("${yellow}FIXME: ${msg}${clr}")
	endif()
	
	if(PAUSE_ON_FIXME OR PAUSE AND NOT NO_PAUSE)
		dk_echo("${yellow}*** PAUSE_ON_FIXME ***${clr}")
		dk_pause()
	endif()
endfunction()





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})

	dk_fixme()
endfunction()