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
	DKDEBUGFUNC(${ARGV})
	dk_getFilename(${path} fileName)
	dk_removeExtension(${fileName} fileNameNoExt)
	dk_verbose(fileNameNoExt)
	set(${RESULT} ${fileNameNoExt} PARENT_SCOPE)
endfunction()