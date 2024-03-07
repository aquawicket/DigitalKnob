include_guard()

###############################################################################
# dk_deleteTempFiles()
#
#	Delete all .tmp files recursivly thoughout the digitalknob directory
#
function(dk_deleteTempFiles)
	DKDEBUGFUNC(${ARGV})
	DKASSERT(DIGITALKNOB_DIR)
	dk_info("Deleteing Temporary files . . .")
	if(WIN_HOST)
		dk_executeProcess(for /r %%i in (*.TMP) do del "%%i" WORKING_DIRECTORY ${DIGITALKNOB_DIR})
		dk_executeProcess(for /r %%i in (*.tmp) do del "%%i" WORKING_DIRECTORY ${DIGITALKNOB_DIR})
	else()
		dk_executeProcess("rm -rf `find . -name *.tmp`" WORKING_DIRECTORY ${DIGITALKNOB_DIR})
		dk_executeProcess(find . -name "*.TMP" -delete WORKING_DIRECTORY ${DIGITALKNOB_DIR})
		dk_executeProcess(find . -name "*.tmp" -delete WORKING_DIRECTORY ${DIGITALKNOB_DIR})
		
	endif()
endfunction()
