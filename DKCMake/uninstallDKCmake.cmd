@echo off

:uninstallDKCmake
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd" %~0
	
	ftype DKCmake=
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKCmake"
	
	assoc .cmake=
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.cmake"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmake
%endfunction%
