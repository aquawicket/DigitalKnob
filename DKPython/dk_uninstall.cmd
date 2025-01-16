@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

:dk_uninstall
	ftype DKPython=
	%dk_call% dk_registryDeleteKey "HKCR\DKPython"
	
	assoc .py=
	%dk_call% dk_registryDeleteKey "HKCR\.py"
	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.py"
%endfunction%
