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
	if exist "%VAL%" %dk_call% dk_debug "already FOUND %name% at %VAL%" && goto:eof
	
	set "name=%~2"
	if "%~3" equ "" set "pattern=" && set "recursive="
	if "%~3" neq "" set "pattern=%~3" && set "recursive=/R" 
	
	%dk_call% dk_commandToVariable "where %recursive% %pattern% %name% %NO_STDERR%" value
	%dk_call% dk_printVar value
	endlocal & set "%1=%value%"
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_findProgram POWERSHELL_EXE "powershell.exe"
	%dk_call% dk_printVar POWERSHELL_EXE
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_getDKPaths"
	%dk_call% dk_findProgram POWERSHELL_EXE "pwsh.exe" "%DKTOOLS_DIR%"
goto:eof
