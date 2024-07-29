@echo off

:uninstallDKC
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	ftype DKC=
	assoc .c=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKC"
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\.c"
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.c"
goto:eof
