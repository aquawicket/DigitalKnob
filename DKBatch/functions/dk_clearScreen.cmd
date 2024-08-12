@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_clearScreen()
::#
::#
:dk_clearScreen
	call dk_debugFunc 0
	
	::setlocal
    cls
	::endlocal
goto:eof








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_clearScreen
goto:eof
