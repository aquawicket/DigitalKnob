@echo off

:uninstallDKCmake
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	ftype DKCmake=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKCmake"
	
	assoc .cmake=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\.cmake"
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmake
goto:eof
