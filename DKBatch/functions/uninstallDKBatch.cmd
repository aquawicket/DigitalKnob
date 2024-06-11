@echo off
call "%DKBATCH_FUNCTIONS_DIR%\DK.cmd"

:uninstall_launcher
	echo Uninstalling .cmd file associations . . .
	
	ftype dk_batch=
	assoc .cmd=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\dk_batch"
goto:eof
