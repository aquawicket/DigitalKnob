include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_refreshIcons()
#
#	Refresh the icons on a windows operating system
#
function(dk_refreshIcons)
	dk_debugFunc(${ARGV})
	
	dk_executeProcess(ie4uinit.exe -ClearIconCache)
	dk_executeProcess(ie4uinit.exe -show)	# Windows 10
endfunction()




function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()