@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

:uninstallDKPowershell
	ftype DKPowershell=
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKPowershell"
	
	assoc .ps1=
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.ps1"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ps1"
%endfunction%
