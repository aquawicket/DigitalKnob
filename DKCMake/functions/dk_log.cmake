include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_log(args)
#
#	A simple, quick and easy logger
#
#	@args		- TODO
#
function(dk_log args)
	dk_debugFunc(${ARGV})
	
	dk_verbose(ARGV)
	set(output " ")
	foreach(arg ${ARGV})
		if(DEFINED ${arg})
			set(output "${output} ${arg}=${${arg}} ")
		else()
			set(output "${output} ${arg}")
		endif()
			dk_info(output)
	endforeach()
	#dk_wait()
endfunction()