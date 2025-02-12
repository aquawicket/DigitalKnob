@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\")
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

:dk_uninstall
	ftype DKCSharp=
	%dk_call% dk_registryDeleteKey "HKCR\DKCSharp"
	
	assoc .cs=
	%dk_call% dk_registryDeleteKey "HKCR\.cs"
	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cs"
%endfunction%
