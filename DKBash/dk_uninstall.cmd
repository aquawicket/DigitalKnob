@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../DKBatch/functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

:dk_uninstall
setlocal
	%dk_call% dk_debugFunc 0
		
	(ftype DKBash 2>nul) && (ftype DKBash=)
	%dk_call% dk_registryKeyExists "HKCR/DKBash" && %dk_call% dk_registryDeleteKey "HKCR/DKBash"

	(assoc .sh 2>nul) && (assoc .sh=)
	%dk_call% dk_registryKeyExists "HKCR/.sh" && %dk_call% dk_registryDeleteKey "HKCR/.sh"
	%dk_call% dk_registryKeyExists "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.sh" && %dk_call% dk_registryDeleteKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.sh"

	::###### RESTORE DEFAULTS ######
	::ftype shfile="%%1" %%*
	::assoc .sh=shfile
	::%dk_call% dk_registrySetKey "HKLM/SOFTWARE/Classes/.sh" "" "REG_SZ" .shfile"
	::%dk_call% dk_registrySetKey "HKLM/SOFTWARE/Classes/shfile/shell/open/command" "" "REG_SZ" "\"%%1\" %*"
%endfunction%










::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	call :dk_uninstall
%endfunction%