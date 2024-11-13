@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

:uninstallDKC	
	ftype DKC=
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKC"
	
	assoc .c=
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.c"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.c"
%endfunction%
