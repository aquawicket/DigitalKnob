include_guard()

###############################################################################
# dk_extract(src dest)
#
#	Extract a archive file
#
#	@src	- The full path of the archive file
#	@dest	- The folder path to extract the archive to
#
function(dk_extract src dest)
	DKDEBUGFUNC(${ARGV})
	if(NOT EXISTS ${dest})
		dk_makeDirectory(${dest})
	endif()
	if(NOT EXISTS ${CMAKE_COMMAND})
		dk_error("CMAKE_COMMAND not found: \${CMAKE_COMMAND} = ${CMAKE_COMMAND}")
	endif()
	dk_executeProcess(${CMAKE_COMMAND} -E tar xvf ${src} WORKING_DIRECTORY ${dest})
endfunction()
