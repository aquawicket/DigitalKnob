@echo off

:uninstallDKBash
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd" %~0
	
	ftype DKBash=
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKBash"
	
	assoc .sh=
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.sh"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.sh
goto:eof
