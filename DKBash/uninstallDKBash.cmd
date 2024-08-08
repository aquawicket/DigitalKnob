@echo off

:uninstallDKBash
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	ftype DKBash=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKBash"
	
	assoc .sh=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\.sh"
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.sh
goto:eof
