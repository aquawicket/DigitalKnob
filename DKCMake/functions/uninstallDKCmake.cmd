@echo off

:uninstall_launcher
	echo Uninstalling .cmake file associations . . .
	
	ftype dk_cmake=
	assoc .cmake=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\dk_cmake"
goto:eof
