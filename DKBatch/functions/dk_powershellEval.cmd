@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_powershellEval(commands)
::#
::#
:dk_powershellEval
	call dk_debugFunc 1 99
	
	setlocal
	
	"%POWERSHELL_EXE%" /? %NO_STD% && goto:found
	
	call dk_validate DKTOOLS_DIR "call dk_getDKPaths"
	call dk_findProgram POWERSHELL_EXE "pwsh.exe" "%DKTOOLS_DIR%"
	"%POWERSHELL_EXE%" /? %NO_STD% && goto:found
	
	set "POWERSHELL_EXE=powershell.exe"
	"%POWERSHELL_EXE%" /? %NO_STD% && goto:found

	call dk_error "POWERSHELL_EXE command invalid"

::	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
::	call dk_validate DKPOWERSHELL_DIR "call dk_validateBranch"
::	if not exist "%DKPOWERSHELL_DIR%" call dk_error "%__FUNCTION__%(): could not locate DKPOWERSHELL_DIR"
	
::	call dk_validate POWERSHELL_EXE "call %DKIMPORTS_DIR%\powershell\dk_installPowershell"
::	if not exist "%POWERSHELL_EXE%"   call dk_error "%__FUNCTION__%(): could not locate POWERSHELL_EXE" 
	
	:found
	"%POWERSHELL_EXE%" -Command %*
	
	endlocal
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0

	call dk_powershellEval "$PSVAR='this is a powershell variable'; Write-Output 'testing dk_powershellEval(): ${PSVAR}'"
goto:eof
