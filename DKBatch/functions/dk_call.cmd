@echo off


::####################################################################
::# dk_call(command args)
::#
::#
:dk_call
	call dk_debugFunc

	::if not exist "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd" call dk_download "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%~1.cmd" "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd"
	call dk_load %~1
	
	::call dk_echo %magenta% > %* %clr%
    call %*
goto:eof


:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	call dk_debugFunc
	
	call dk_fixme
	call dk_call dir
goto:eof