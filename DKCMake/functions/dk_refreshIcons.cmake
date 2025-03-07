#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_refreshIcons()
#
#	Refresh the icons on a windows operating system
#
function(dk_refreshIcons)
	dk_debugFunc()
	
	dk_executeProcess(ie4uinit.exe -ClearIconCache)
	dk_executeProcess(ie4uinit.exe -show)	# Windows 10
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()