include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_validatePath(path rtn_var)
#
#	TODO
#
#	@path		- TODO
#	@rtn_var		- TODO
#
function(dk_validatePath path rtn_var)
	dk_debugFunc("\${ARGV}")
	
	dk_getFullPath(${path} path)
	set(${rtn_var} ${path} PARENT_SCOPE)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()