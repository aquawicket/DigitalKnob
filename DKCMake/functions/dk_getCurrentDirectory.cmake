include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_getCurrentDirectory(rtn_var)
#
#	Retrieve the current working directory
#
#	@rtn_var: returns the current working directory upon success. False upon error
#
#function(dk_getCurrentDirectory rtn_var)
#	dk_debugFunc(${ARGV})

#	if(WIN_HOST)
#		execute_process(COMMAND echo "hello world" ECHO_OUTPUT_VARIABLE currentDirectory WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
#	else()
#		execute_process(COMMAND pwd ECHO_OUTPUT_VARIABLE currentDirectory WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
#	endif()
#	execute_process(COMMAND timeout /t 2 /nobreak WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})  ##wait 2 seconds for the stdout to flush
#	#dk_printVar(currentDirectory)
#	set(${rtn_var} ${currentDirectory} PARENT_SCOPE)
#endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()