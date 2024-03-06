include_guard()

###############################################################################
# dk_sleep(seconds)
#
#	TODO
#
function(dk_sleep seconds)
	execute_process(COMMAND ${CMAKE_COMMAND} -E sleep ${seconds})
endfunction()