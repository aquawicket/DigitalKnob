@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_checkError()
::#
:dk_checkError
	call dk_debugFunc 0
	
	::setlocal
    if %ERRORLEVEL% equ 0 goto:eof
    call dk_error "ERRORLEVEL = %ERRORLEVEL%"
	::endlocal
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_checkError
goto:eof
