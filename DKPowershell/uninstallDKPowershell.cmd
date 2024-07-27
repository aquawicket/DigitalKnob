@echo off


:uninstallDKPowershell
	echo Uninstalling DKPowershell . . .
	
	::###### DKINIT ######
	set "DKBATCH_FUNCTIONS_DIR=..\DKBatch\functions"
	set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR%\"
	call "%DKBATCH_FUNCTIONS_DIR%\DK.cmd"
	
	call dk_echo "Uninstalling DKHta file associations . . ."
	ftype dkpowershell=
	assoc .ps1=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\dkpowershell"
	pause
goto:eof
