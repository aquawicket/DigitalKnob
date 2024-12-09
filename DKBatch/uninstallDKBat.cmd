@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

:uninstallDKBatch
	ftype DKBat=
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKBat"
	
	assoc .=bat
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.bat"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bat"

	::###### RESTORE DEFAULTS (restore.reg) ######
	:: .bat
	ftype batfile="%%1" %%*
	assoc .bat=batfile
	::%dk_call% dk_registrySetKey "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.bat" "" "REG_SZ" "cmdfile"
	::%dk_call% dk_registrySetKey "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\batfile\shell\open\command" "" "REG_SZ" "\"%%1\" %*"
%endfunction%
