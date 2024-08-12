@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::dk_findProgram (<VAR> name [path1 path2 ...])
::#
::#
:dk_findProgram
	call dk_debugFunc 2 9 
	
	setlocal
	set "VAR=%~1"
	set "VAL=!%VAR%!"
	set "name=%~2"
	if "%~3" equ "" set "pattern=C:\"
	if "%~3" neq "" set "pattern=%~3" 
	
	if exist "%VAL%" %dk_call% dk_debug("already FOUND %name% at %VAL%") && goto:eof

	%dk_call% dk_commandToVariable "where /R %pattern% %name% 2>nul" %VAR%
	%dk_call% dk_printVar %VAR%
	endlocal & set "%2=!%VAR%!"
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_getDKPaths"
	%dk_call% dk_findProgram POWERSHELL_EXE "pwsh.exe" "%DKTOOLS_DIR%"
goto:eof
