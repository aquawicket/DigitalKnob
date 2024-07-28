@echo off

:uninstallDKCpp
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	ftype DKCpp=
	assoc .cpp=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKCpp"
	call dk_pause
goto:eof
