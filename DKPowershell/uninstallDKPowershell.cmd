@echo off

:uninstallDKPowershell
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	ftype DKPowershell=
	assoc .ps1=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKPowershell"
	call dk_pause
goto:eof
