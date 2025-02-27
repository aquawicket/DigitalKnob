@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../DKBatch/functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

:dk_uninstall
	ftype DKBatch=
	%dk_call% dk_registryDeleteKey "HKCR\DKBatch"
	
	assoc .cmd=
	%dk_call% dk_registryDeleteKey "HKCR\.cmd"
	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmd"

	::###### RESTORE DEFAULTS (restore.reg) ######	
	:: .cmd
	ftype cmdfile="%%1" %%*
	assoc .cmd=cmdfile
	::%dk_call% dk_registrySetKey "HKLM\SOFTWARE\Classes\.cmd" "" "REG_SZ" "cmdfile"
	::%dk_call% dk_registrySetKey "HKLM\SOFTWARE\Classes\cmdfile\shell\open\command" "" "REG_SZ" "\"%%1\" %*"
%endfunction%
