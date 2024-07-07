@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

:uninstallDKBash
	echo Uninstalling .sh file associations . . .
	
	ftype dkbash=
	assoc .sh=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\dkbash"
goto:eof
