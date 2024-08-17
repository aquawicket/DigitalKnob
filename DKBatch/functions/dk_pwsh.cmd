@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_pwsh(commands)
::#
::#
:dk_pwsh
	call dk_debugFunc 1 99
	
	setlocal
	
	"%PWSH_EXE%" /? %NO_STD% && goto:found
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_getDKPaths"
	%dk_call% dk_findProgram PWSH_EXE "pwsh.exe" "%DKTOOLS_DIR%"
	"%PWSH_EXE%" /? %NO_STD% && goto:found
	
::	set "POWERSHELL_EXE=powershell.exe"
::	"%POWERSHELL_EXE%" /? %NO_STD% && goto:found

	%dk_call% dk_error "PWSH_EXE command invalid"
	
	:found
	"%PWSH_EXE%" -Command %*
	
	endlocal
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0

	%dk_call% dk_pwsh "$PSVAR='this is a pwsh variable'; Write-Output 'testing dk_pwsh(): ${PSVAR}'"
goto:eof
