@echo off
call functions\DK.cmd

:uninstallDKBatch
	echo Uninstalling DKVb . . .
	
	call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"
	ftype DKBatch=
	assoc .dkbatch=
	assoc .cmd=
	assoc .bat=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKBatch"
	pause
goto:eof
