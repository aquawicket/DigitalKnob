include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_getAppName(path RESULT)
#
#	Get the app name from a file path
#
#	@path		- TODO
#	@RESULT		- TODO
#
function(dk_getAppName path RESULT)
	dk_debugFunc(${ARGV})
	
	dk_getBasename(${path} fileName)
	dk_removeExtension(${fileName} fileNameNoExt)
	dk_verbose(fileNameNoExt)
	set(${RESULT} ${fileNameNoExt} PARENT_SCOPE)
endfunction()






function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)