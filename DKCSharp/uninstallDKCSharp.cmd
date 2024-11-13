@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

:uninstallDKCSharp	
	ftype DKCSharp=
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKCSharp"
	
	assoc .cs=
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.cs"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cs"
%endfunction%
