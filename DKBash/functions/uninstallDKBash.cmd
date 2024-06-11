@echo off
call "%DKBATCH_FUNCTIONS_DIR%\DK.cmd"

:uninstall_launcher
	echo Uninstalling .sh file associations . . .
	
	ftype dk_bash=
	assoc .sh=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\dk_bash"
goto:eof
