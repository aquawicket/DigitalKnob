@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


:dk_uninstall_bat
	ftype DKBat=
	%dk_call% dk_registryDeleteKey "HKCR\DKBat"
	
	assoc .=bat
	%dk_call% dk_registryDeleteKey "HKCR\.bat"
	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bat"

	::###### RESTORE DEFAULTS (restore.reg) ######
	:: .bat
	ftype batfile="%%1" %%*
	assoc .bat=batfile
	::%dk_call% dk_registrySetKey "HKLM\SOFTWARE\Classes\.bat" "" "REG_SZ" "cmdfile"
	::%dk_call% dk_registrySetKey "HKLM\SOFTWARE\Classes\batfile\shell\open\command" "" "REG_SZ" "\"%%1\" %*"
%endfunction%
