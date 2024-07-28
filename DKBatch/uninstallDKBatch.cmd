@echo off

:uninstallDKBatch
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"

	ftype DKBatch=
	assoc .cmd=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKBatch"
	call dk_pause
goto:eof
