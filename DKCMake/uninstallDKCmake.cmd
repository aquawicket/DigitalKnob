@echo off
call "%DKBATCH_FUNCTIONS_DIR%\DK.cmd"

:uninstall_launcher
	dk_debugFunc(${ARGV})
	
	
	echo Uninstalling .cmake file associations . . .
	
	ftype dkcmake=
	assoc .cmake=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\dkcmake"
goto:eof
