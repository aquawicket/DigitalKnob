include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_test()
#
#
function(dk_test)
	dk_debugFunc(${ARGV})
	
	message("dk_test() sleeping for ${ARGV0} seconds")
	execute_process(COMMAND ${CMAKE_COMMAND} -E sleep ${ARGV0})
endfunction()








function(DKTEST) #############################################################
	dk_debugFunc(${ARGV})
	
	dk_test(3)
endfunction()