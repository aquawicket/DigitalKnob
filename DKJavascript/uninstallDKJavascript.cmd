@echo off

:uninstallDKJavascript
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"

	ftype DKJavascript=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKJavascript"
	
	assoc .js=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\.js"
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.js
goto:eof
