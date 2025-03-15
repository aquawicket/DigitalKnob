@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

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

	set "REG_BACKUP_DIR=%CD:\=/%/REGISTRY_BACKUP"
	%dk_call% dk_echo "REG_BACKUP_DIR = %REG_BACKUP_DIR%"
	%dk_call% dk_makeDirectory "%REG_BACKUP_DIR%"
	
	%dk_call% dk_validate REG_EXE "%dk_call% dk_REG_EXE"
	
    "%REG_EXE%" export HKLM %REG_BACKUP_DIR:/=\%\HKLM.reg
	"%REG_EXE%" export HKCU %REG_BACKUP_DIR:/=\%\HKCU.reg
	"%REG_EXE%" export HKCR %REG_BACKUP_DIR:/=\%\HKCR.reg
	"%REG_EXE%" export HKU  %REG_BACKUP_DIR:/=\%\HKU.reg
	"%REG_EXE%" export HKCC %REG_BACKUP_DIR:/=\%\HKCC.reg
	
	%dk_call% dk_success "Registry Backup Complete"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_registryBackup
%endfunction%
