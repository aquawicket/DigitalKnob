@echo off


:uninstallDKVb
	echo Uninstalling DKVb . . .

	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	ftype DKVb=
	assoc .vbs=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKVb"
	call dk_pause
goto:eof
