include_guard()

###############################################################################
# dk_getCurrentDirectory(RESULT)
#
#	Retrieve the current working directory
#
#	@RESULT: returns the current working directory upon success. False upon error
#
#function(dk_getCurrentDirectory RESULT)
#	DKDEBUGFUNC(${ARGV})
#	if(WIN_HOST)
#		execute_process(COMMAND echo "hello world" ECHO_OUTPUT_VARIABLE output WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
#	else()
#		execute_process(COMMAND pwd ECHO_OUTPUT_VARIABLE output WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
#	endif()
#	execute_process(COMMAND timeout /t 2 /nobreak WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})  ##wait 2 seconds for the stdout to flush
#	#dk_debug(output	PRINTVAR)
#	set(${RESULT} ${output} PARENT_SCOPE)
#endfunction()