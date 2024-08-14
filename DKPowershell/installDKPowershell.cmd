@echo off

if not "%*" == "" (goto:runDKPowershell)
:installDKPowershell
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	::###### Install DKPowershell ######
	%dk_call% dk_echo "Installing DKPowershell . . ."
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_validateBranch"
	%dk_call% dk_validate POWERSHELL_EXE "call %DKIMPORTS_DIR%\powershell\dk_installPowershell.cmd"

	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKPowershell"
	ftype DKPowershell=cmd /c call "%~f0" "%DKPOWERSHELL_FUNCTIONS_DIR%" "%POWERSHELL_EXE%" "%%1" %*
	%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\DKPowershell\DefaultIcon" "" "REG_SZ" "%POWERSHELL_EXE%"
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.ps1"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ps1
	assoc .ps1=DKPowershell
	
	%dk_call% dk_echo "DKPowershell install complete"
goto:eof


:runDKPowershell
	set "DKPOWERSHELL_FUNCTIONS_DIR=%~1"
	set "POWERSHELL_EXE=%~2"
	set "DKPOWERSHELL_FILE=%~3"
	call %POWERSHELL_EXE% -Command %DKPOWERSHELL_FILE%; exit $LASTEXITCODE && (echo returned TRUE) || (echo returned FALSE)
	echo ERRORLEVEL = %ERRORLEVEL% & pause
goto:eof