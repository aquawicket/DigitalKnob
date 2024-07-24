@echo off

if not "%*" == "" (goto:runDKPowershell)

:installDKPowershell
	echo Installing DKPowershell . . .
	
	::###### DKINIT ######
	set "DKBATCH_FUNCTIONS_DIR=..\DKBatch\functions"
	set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR%\"
	call "%DKBATCH_FUNCTIONS_DIR%\DK.cmd"
	
	call dk_load dk_validate
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate POWERSHELL_EXE "call %DKIMPORTS_DIR%\powershell\dk_installPowershell"
	
	::###### Powershell ######::
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ps1
	ftype dkpowershell=cmd /c call "%~f0" "%DKPOWERSHELL_FUNCTIONS_DIR%" "%POWERSHELL_EXE%" "%%1" %*
	assoc .ps1=dkpowershell
	call dk_registrySetKey "HKEY_CLASSES_ROOT\dkpowershell\DefaultIcon" "" "REG_SZ" "%POWERSHELL_EXE%"
goto:eof


:runDKPowershell
	set "DKPOWERSHELL_FUNCTIONS_DIR=%~1"
	set "POWERSHELL_EXE=%~2"
	set "PS_FILE=%~3"

	echo ############### Digitalknob ##################
	start /b %POWERSHELL_EXE% %PS_FILE%
	pause
goto:eof