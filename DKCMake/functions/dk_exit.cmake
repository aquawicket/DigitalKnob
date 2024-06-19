include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_exit()
#
#	Exit cmake
#
function(dk_exit)
	dk_debugFunc(${ARGV})
	
	dk_debug("#################### dk_exit() ####################")
	if(WIN_HOST)
		execute_process(COMMAND taskkill /IM cmake.exe /F)	# WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
	else()
		execute_process(COMMAND killall -9 cmake)	# WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
	endif()
endfunction()





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction(DKTEST)