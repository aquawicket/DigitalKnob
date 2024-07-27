@echo off


:uninstallDKVb
	echo Uninstalling DKVb . . .

	::###### DKINIT ######
	set "DKBATCH_FUNCTIONS_DIR=..\DKBatch\functions"
	set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR%\"
	call "%DKBATCH_FUNCTIONS_DIR%\DK.cmd"
	
	call dk_echo "Uninstalling DKVb file associations . . ."
	ftype dkvb=
	assoc .vbs=VBSFile
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\dkvb"
	pause
goto:eof
