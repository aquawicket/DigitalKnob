@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_powershell(commands)
::#
::#
echo dk_powershell
:dk_powershell
	if defined dk_powershell (goto:eof) else (set "dk_powershell=1")   &::disallow recursion for this function
	call dk_debugFunc 1 99
	
	setlocal
	"%POWERSHELL_EXE%" /? %NO_STD% && goto:found
	
::	:: try pwsh.exe
::	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_getDKPaths"
::	%dk_call% dk_findProgram POWERSHELL_EXE "pwsh.exe" "%DKTOOLS_DIR%"
::	"%POWERSHELL_EXE%" /? %NO_STD% && goto:found
	
	:: try powershell.exe
	set "POWERSHELL_EXE=powershell.exe"
	"%POWERSHELL_EXE%" /? %NO_STD% && goto:found

	:: install pwsh.exe and try again
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_validateBranch"
	%dk_call% %DKIMPORTS_DIR%\powershell\dk_installPowershell.cmd"
	set "POWERSHELL_EXE=%POWERSHELL_EXE%"
	"%POWERSHELL_EXE%" /? %NO_STD% && goto:found
	
	
	:notfound
	%dk_call% dk_error "POWERSHELL_EXE command invalid"
	
	:found
	%dk_call% dk_printVar POWERSHELL_EXE
	"%POWERSHELL_EXE%" -Command %*
	
	endlocal
	set "dk_powershell="  &::function complete, remove recursion block
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0

	%dk_call% dk_powershell "$PSVAR='this is a powershell variable'; Write-Output 'testing dk_powershell(): ${PSVAR}'"
goto:eof