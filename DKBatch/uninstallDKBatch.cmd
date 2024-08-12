@echo off

:uninstallDKBatch
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"

	ftype DKBatch=
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKBatch"
	
	assoc .cmd=
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.cmd"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmd

	::###### RESTORE DEFAULTS (restore.reg) ######
	
	:: .bat
	::ftype batfile="%%1" %%*
	::assoc .bat=batfile
	::%dk_call% dk_registrySetKey "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.bat" "" "REG_SZ" "batfile"
	::%dk_call% dk_registrySetKey "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\batfile\shell\open\command" "" "REG_SZ" "\"%%1\" %*"
	
	:: .cmd
	ftype cmdfile="%%1" %%*
	assoc .cmd=cmdfile
	::%dk_call% dk_registrySetKey "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.cmd" "" "REG_SZ" "cmdfile"
	::%dk_call% dk_registrySetKey "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\cmdfile\shell\open\command" "" "REG_SZ" "\"%%1\" %*"
goto:eof
