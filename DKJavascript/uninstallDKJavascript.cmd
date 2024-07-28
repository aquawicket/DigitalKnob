@echo off

:uninstallDKJavascript
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"

	ftype DKJavascript=
	assoc .js=
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKJavascript"
	call dk_pause
goto:eof
