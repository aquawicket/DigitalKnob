#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_validatePath(path rtn_var)
#
#	TODO
#
#	@path		- TODO
#	@rtn_var		- TODO
#
function(dk_validatePath path rtn_var)
	dk_debugFunc()
	
	dk_getFullPath(${path} path)
	set(${rtn_var} ${path} PARENT_SCOPE)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()