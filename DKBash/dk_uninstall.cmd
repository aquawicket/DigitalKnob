@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
	
:uninstall
	ftype DKBash=
	%dk_call% dk_registryDeleteKey "HKCR\DKBash"
	
	assoc .sh=
	%dk_call% dk_registryDeleteKey "HKCR\.sh"
	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.sh"
%endfunction%
