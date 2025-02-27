@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../DKBatch/functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

:dk_uninstall
	ftype DKC=
	%dk_call% dk_registryDeleteKey "HKCR\DKC"
	
	assoc .c=
	%dk_call% dk_registryDeleteKey "HKCR\.c"
	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.c"
%endfunction%
