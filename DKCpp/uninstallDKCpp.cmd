@echo off


:uninstallDKCpp
	echo Uninstalling DKCpp . . .

	::###### DKINIT ######
	set "DKBATCH_FUNCTIONS_DIR=..\DKBatch\functions"
	set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR%\"
	call "%DKBATCH_FUNCTIONS_DIR%\DK.cmd"
	
	call dk_echo "Uninstalling DKCpp file associations . . ."
	ftype DKCpp=
	assoc .cpp=DKCpp
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKCpp"
	pause
goto:eof
