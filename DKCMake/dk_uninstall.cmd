@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../DKBatch/functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

:dk_uninstall
	ftype DKCmake=
	%dk_call% dk_registryDeleteKey "HKCR/DKCmake"
	
	assoc .cmake=
	%dk_call% dk_registryDeleteKey "HKCR/.cmake"
	%dk_call% dk_registryDeleteKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.cmake"
%endfunction%
