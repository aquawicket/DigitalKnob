#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_getAppName(path rtn_var)
#
#	Get the app name from a file path
#
#	@path		- TODO
#	@rtn_var		- TODO
#
function(dk_getAppName path rtn_var)
	dk_debugFunc()
	
	dk_basename(${path} fileName)
	dk_removeExtension(${fileName} fileNameNoExt)
	dk_verbose(fileNameNoExt)
	set(${rtn_var} ${fileNameNoExt} PARENT_SCOPE)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()