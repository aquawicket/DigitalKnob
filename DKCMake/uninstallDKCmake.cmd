@echo off

:uninstallDKCmake
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	ftype DKCmake=
	assoc .cmake=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKCmake"
	call dk_pause
goto:eof
