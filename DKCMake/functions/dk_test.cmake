include(${DKCMAKE_DIR}/functions/DK.cmake)
include_guard()

###############################################################################
# dk_test()
#
#
function(dk_test)
	dk_debugFunc(${ARGV})
	
	execute_process(COMMAND ${CMAKE_COMMAND} -E sleep ${ARGV0})
endfunction()








function(DKTEST) #############################################################

	dk_info("running dk_test for 3 seconds . . .")
	dk_test(3)

endfunction()