@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../DKBatch/functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

:dk_uninstall
	ftype DKPowershell=
	%dk_call% dk_registryDeleteKey "HKCR\DKPowershell"
	
	assoc .ps1=
	%dk_call% dk_registryDeleteKey "HKCR\.ps1"
	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ps1"
%endfunction%
