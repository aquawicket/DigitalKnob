@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../DKBatch/functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

:dk_uninstall
setlocal
	%dk_call% dk_debugFunc 0
		
	(ftype DKBatch 2>nul) && (ftype DKBatch=)
	%dk_call% dk_registryKeyExists "HKCR\DKBatch" && %dk_call% dk_registryDeleteKey "HKCR\DKBatch"

	(assoc .cmd 2>nul) && (assoc .cmd=)
	%dk_call% dk_registryKeyExists "HKCR/.cmd" && %dk_call% dk_registryDeleteKey "HKCR/.cmd"
	%dk_call% dk_registryKeyExists "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.cmd" && %dk_call% dk_registryDeleteKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.cmd"

	::###### RESTORE DEFAULTS ######
	ftype cmdfile="%%1" %%*
	assoc .cmd=cmdfile
	::%dk_call% dk_registrySetKey "HKLM/SOFTWARE/Classes/.cmd" "" "REG_SZ" "cmdfile"
	::%dk_call% dk_registrySetKey "HKLM/SOFTWARE/Classes/cmdfile/shell/open/command" "" "REG_SZ" "\"%%1\" %*"
%endfunction%










::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	call :dk_uninstall
%endfunction%
