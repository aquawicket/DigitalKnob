@echo off

:uninstall_launcher
	echo Uninstalling .ps1 file associations . . .
	
	ftype dk_powershell=
	assoc .ps1=
	::call dk_registrySetKey "HKEY_CLASSES_ROOT\dk_powershell\DefaultIcon" "" "REG_SZ" "%POWERSHELL_EXE%"
goto:eof
