@echo off

:uninstallDKHta
	::###### DKINIT ######
	call "..\DKHta\functions\DK.cmd"

	ftype DKHta=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKHta"
	
	assoc .hta=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\.hta"
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.hta
%endfunction%
