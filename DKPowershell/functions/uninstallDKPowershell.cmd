@echo off
call "%DKBATCH_FUNCTIONS_DIR%\DK.cmd"

:uninstall_launcher
	echo Uninstalling .ps1 file associations . . .
	
	ftype dk_powershell=
	assoc .ps1=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\dk_powershell"
goto:eof
