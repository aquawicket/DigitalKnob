@echo off


:uninstallDKBash
	echo Uninstalling DKBash . . .
	
	::###### DKINIT ######
	set "DKBATCH_FUNCTIONS_DIR=..\DKBatch\functions"
	set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR%\"
	call "%DKBATCH_FUNCTIONS_DIR%\DK.cmd"
	
	call dk_echo "Uninstalling DKBash file associations . . ."
	ftype dkbash=
	assoc .sh=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\dkbash"
	pause
goto:eof
