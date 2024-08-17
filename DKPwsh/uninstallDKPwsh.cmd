@echo off

:uninstallDKPwsh
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	ftype DKPwsh=
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKPwsh"
	
	assoc .ps1=
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.ps1"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ps1
goto:eof
