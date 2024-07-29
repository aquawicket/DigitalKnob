@echo off

:uninstallDKC
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	ftype DKC=
	assoc .c=
	::assoc .h=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKC"
goto:eof
