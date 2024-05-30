include(${CMAKE_CURRENT_LIST_DIR}/DK.cmake)
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
	dk_info("running dk_test for 10 seconds . . .")
	dk_test(10)

endfunction()