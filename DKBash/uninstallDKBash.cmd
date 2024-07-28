@echo off

:uninstallDKBash
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	ftype DKBash=
	assoc .sh=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKBash"
	call dk_pause
goto:eof
