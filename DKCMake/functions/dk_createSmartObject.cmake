#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_createSmartObject(object)
#
#	TODO
#	We can scan each plugin and attempt to create it's variable and infomation manually here
#
#	@object		- TODO
#
function(dk_createSmartObject object)
	dk_debugFunc()
	
	todo()
	dk_verbose("dk_createSmartObject(${object})")
	# We require something that can resolve to a full, valid path containing a DKINSTALL.cmake file 
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_createSmartObject(todo)
endfunction()