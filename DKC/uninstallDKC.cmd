@echo off

:uninstallDKCpp
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	ftype DKCpp=
	assoc .cpp=
	assoc .h=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKCpp"
goto:eof
