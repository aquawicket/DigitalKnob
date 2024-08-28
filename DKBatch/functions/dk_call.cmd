@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_call(command args)
::#
::#
:dk_call
 ::setlocal
	::if exist "%DKBATCH_FUNCTIONS_DIR%\dk_debugFunc.cmd" call dk_debugFunc 1 99
	
	if "%~1"=="dk_debugFunc" echo [31m ERROR: dk_call cannot be used with dk_debugFunc [0m & goto:eof
	
	set "arg=%1"
	if "%arg:dk_=%"=="%arg%"  echo [31m ERROR: dk_call[%arg%]: dk_call can only be used with dk_ functions [0m & goto:eof

	if not exist "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd" (
		call dk_source "%~1"
		if not exist "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd" echo [31m ERROR: failed to dowload %~1.cmd [0m & goto:eof
		if not exist "%DKBATCH_FUNCTIONS_DIR%\dk_isCRLF.cmd" call dk_source dk_isCRLF
		if not exist "%DKBATCH_FUNCTIONS_DIR%\dk_fileToCRLF.cmd" call dk_source dk_fileToCRLF
		if exist "%DKBATCH_FUNCTIONS_DIR%\dk_isCRLF.cmd" call dk_isCRLF "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd" || if exist "%DKBATCH_FUNCTIONS_DIR%\dk_fileToCRLF.cmd" call dk_fileToCRLF "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd"
	)
	
	::echo "call %*"
	call %*
%endfunction%








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	::if exist "%DKBATCH_FUNCTIONS_DIR%\dk_debugFunc.cmd" call dk_debugFunc 0
	
	%dk_call% dk_color
	call dk_call dk_color
	%dk_call% dk_color
	call dk_call dk_color
	%dk_call% dk_color
%endfunction%
