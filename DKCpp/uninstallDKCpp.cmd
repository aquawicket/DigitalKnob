@echo off

:uninstallDKCpp
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd" %~0
	
	ftype DKCpp=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKCpp"
	
	assoc .cpp=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\.cpp"
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cpp
%endfunction%
