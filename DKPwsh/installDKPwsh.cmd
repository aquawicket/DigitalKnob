@echo off

if not "%*" == "" (goto:runDKPwsh)
:installDKPwsh
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	::###### Install DKPwsh ######
	%dk_call% dk_echo "Installing DKPwsh . . ."
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_validateBranch"
	%dk_call% dk_validate PWSH_EXE "call %DKIMPORTS_DIR%\pwsh\dk_installPwsh.cmd"

	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKPwsh"
	ftype DKPwsh=cmd /c call "%~f0" "%DKPWSH_FUNCTIONS_DIR%" "%PWSH_EXE%" "%%1" %*
	%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\DKPwsh\DefaultIcon" "" "REG_SZ" "%PWSH_EXE%"
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.ps1"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ps1
	assoc .ps1=DKPwsh
	
	%dk_call% dk_echo "DKPwsh install complete"
goto:eof


:runDKPwsh
	set "DKPWSH_FUNCTIONS_DIR=%~1"
	set "PWSH_EXE=%~2"
	set "DKPWSH_FILE=%~3"
	
	
	::###### run script ######
	call %PWSH_EXE% -Command %DKPWSH_FILE%; exit $LASTEXITCODE && (echo returned TRUE) || (echo returned FALSE)
	
	::###### exit_code ######
	if %ERRORLEVEL% neq 0 echo ERROR:%ERRORLEVEL% && pause
	
	::###### reload ######
	if not exist %~dp0\reload goto:eof
	del %~dp0\reload
	cls
	goto:runDKPwsh
	
goto:eof