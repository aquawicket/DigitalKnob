@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

:uninstallDKPython
	ftype DKPython=
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKPython"
	
	assoc .py=
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.py"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.py"
%endfunction%
