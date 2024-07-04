@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

:uninstallDKBash
	echo Uninstalling .sh file associations . . .
	
	ftype dk_bash=
	assoc .sh=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\dk_bash"
goto:eof
