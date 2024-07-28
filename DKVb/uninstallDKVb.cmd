@echo off

:uninstallDKVb
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	ftype DKVb=
	assoc .vbs=VBSFile
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKVb"
	call dk_pause
goto:eof
