@echo off

:uninstallDKBatch
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"

	ftype DKBatch=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKBatch"
	
	assoc .cmd=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\.cmd"
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmd

	restore.reg
goto:eof
