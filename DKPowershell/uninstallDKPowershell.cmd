@echo off

:uninstallDKPowershell
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	ftype DKPowershell=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKPowershell"
	
	assoc .ps1=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\.ps1"
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ps1
goto:eof
