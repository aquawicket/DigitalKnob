include_guard()

###############################################################################
# dk_exit()
#
#	Exit cmake
#
macro(dk_exit)
	dk_debugFunc(${ARGV})
	
	dk_debug("#################### dk_exit() ####################")
	if(WIN_HOST)
		execute_process(COMMAND taskkill /IM cmake.exe /F)	# WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
	else()
		execute_process(COMMAND killall -9 cmake)	# WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
	endif()
endmacro()