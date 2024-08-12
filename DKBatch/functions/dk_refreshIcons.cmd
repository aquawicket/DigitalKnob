@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_refreshIcons()
::#
:dk_refreshIcons
	echo Refreshing windows icons

	:: for window
	ie4uinit.exe -ClearIconCache

	:: for windows 10+
	ie4uinit.exe -show
goto:eof








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_refreshIcons
goto:eof
