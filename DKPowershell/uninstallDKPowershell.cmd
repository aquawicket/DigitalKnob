@echo off
::call "%DKBATCH_FUNCTIONS_DIR%\DK.cmd"

:uninstallDKPowershell
	echo Uninstalling DKPowershell . . .
	
	::###### DKINIT ######
	set "DKBATCH_FUNCTIONS_DIR=..\DKBatch\functions"
	set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR%\"
	call "%DKBATCH_FUNCTIONS_DIR%\DK.cmd"
	
	echo Uninstalling .ps1 file associations . . .
	
	ftype dkpowershell=
	assoc .ps1=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\dkpowershell"
goto:eof
