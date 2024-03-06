include_guard()

###############################################################################
# dk_filesMatch(fileA fileB)
#
#	TODO
#
#	@fileA	- TODO
#	@fileB	- TODO
#
function(dk_filesMatch fileA fileB)
	DKDEBUGFUNC(${ARGV})
	execute_process(COMMAND ${CMAKE_COMMAND} -E compare_files ${fileA} ${fileB} RESULT_VARIABLE compare_result)
	if(compare_result EQUAL 0)
		dk_info("The files are identical.")
	elseif(compare_result EQUAL 1)
		dk_info("The files are different.")
	else()
		dk_info("Error while comparing the files.")
	endif()
endfunction()
