@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../DKBatch/functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

:dk_uninstall_bat
	ftype DKBat=
	%dk_call% dk_registryDeleteKey "HKCR\DKBat"
	
	assoc .=bat
	%dk_call% dk_registryDeleteKey "HKCR\.bat"
	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bat"

	::###### RESTORE DEFAULTS (restore.reg) ######
	:: .bat
	ftype batfile="%%1" %%*
	assoc .bat=batfile
	::%dk_call% dk_registrySetKey "HKLM\SOFTWARE\Classes\.bat" "" "REG_SZ" "cmdfile"
	::%dk_call% dk_registrySetKey "HKLM\SOFTWARE\Classes\batfile\shell\open\command" "" "REG_SZ" "\"%%1\" %*"
%endfunction%
