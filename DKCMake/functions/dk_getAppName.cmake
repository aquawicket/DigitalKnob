include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_getAppName(path rtn_var)
#
#	Get the app name from a file path
#
#	@path		- TODO
#	@rtn_var		- TODO
#
function(dk_getAppName path rtn_var)
	dk_debugFunc("\${ARGV}")
	
	dk_basename(${path} fileName)
	dk_removeExtension(${fileName} fileNameNoExt)
	dk_verbose(fileNameNoExt)
	set(${rtn_var} ${fileNameNoExt} PARENT_SCOPE)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()