include_guard()

###############################################################################
# dk_refreshIcons()
#
#	Refresh the icons on a windows operating system
#
function(dk_refreshIcons)
	DKDEBUGFUNC(${ARGV})
	dk_executeProcess(ie4uinit.exe -ClearIconCache)
	dk_executeProcess(ie4uinit.exe -show)	# Windows 10
endfunction()