@echo off

:uninstallDKPowershell
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd" %~0
	
	ftype DKPowershell=
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKPowershell"
	
	assoc .ps1=
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.ps1"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ps1
%endfunction%
