@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

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
	
	if exist "%VAL%" call dk_debug("already FOUND %name% at %VAL%") && goto:eof

	call dk_commandToVariable "where /R %pattern% %name% 2>nul" %VAR%
	call dk_printVar %VAR%
	endlocal & set "%2=!%VAR%!"
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_validate DKTOOLS_DIR "call dk_getDKPaths"
	call dk_findProgram POWERSHELL_EXE "pwsh.exe" "%DKTOOLS_DIR%"
goto:eof
