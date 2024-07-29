@echo off

:uninstallDKVb
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	ftype DKVb=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKVb"
	
	assoc .vbs=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\.vbs"
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.vbs
goto:eof
