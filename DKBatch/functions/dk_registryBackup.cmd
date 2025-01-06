@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::############################################################################
::# dk_registryBackup()
::#
::#		REG EXPORT KeyName FileName [/y] [/reg:32 | /reg:64]
::#
::#		Keyname    ROOTKEY[\SubKey] (local machine only).
::#		ROOTKEY  [ HKLM | HKCU | HKCR | HKU | HKCC ]
::#		SubKey   The full name of a registry key under the selected ROOTKEY.
::#
::#		FileName   The name of the disk file to export.
::#		/y       Force overwriting the existing file without prompt.
::#		/reg:32  Specifies the key should be accessed using the 32-bit registry view.
::#		/reg:64  Specifies the key should be accessed using the 64-bit registry view.
::#
::#	Examples:
::#		'REG EXPORT HKLM\Software\MyCo\MyApp AppBkUp.reg'
::#		Exports all subkeys and values of the key MyApp to the file AppBkUp.reg
::#
:dk_registryBackup
setlocal
	%dk_call% dk_debugFunc 0

	set "reg_backup=%CD%\REG_BACKUP
	echo reg_backup = %reg_backup%
	%dk_call% dk_makeDirectory %reg_backup%
	
    reg export HKLM %reg_backup%\HKLM.reg
	reg export HKCU %reg_backup%\HKCU.reg
	reg export HKCR %reg_backup%\HKCR.reg
	reg export HKU  %reg_backup%\HKU.reg
	reg export HKCC %reg_backup%\HKCC.reg
	
	echo Registry Backup Complete
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_registryBackup
%endfunction%
