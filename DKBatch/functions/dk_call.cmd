@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"


::####################################################################
::# dk_call(command args)
::#
::#
:dk_call
	::if exist "%DKBATCH_FUNCTIONS_DIR%\dk_debugFunc.cmd" call dk_debugFunc 1 99
	
	if not exist "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd" (
		call dk_source "%~1"
		if not exist "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd" echo ERROR: failed to dowload %~1 & goto:eof
		if not exist "%DKBATCH_FUNCTIONS_DIR%\dk_isCRLF.cmd" call dk_isCRLF "%~1" || call dk_fileToCRLF "%~1"
	)
	
	::echo "call %*"
	call %*	
goto:eof








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	::if exist "%DKBATCH_FUNCTIONS_DIR%\dk_debugFunc.cmd" call dk_debugFunc 0
	
	%dk_call% dk_color
	call dk_call dk_color
	%dk_call% dk_color
	call dk_call dk_color
	%dk_call% dk_color
goto:eof
