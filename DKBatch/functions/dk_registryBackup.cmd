@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ############################################################################
rem # dk_registryBackup()
rem #
rem #		REG EXPORT KeyName FileName [/y] [/reg:32 | /reg:64]
rem #
rem #		Keyname    ROOTKEY[\SubKey] (local machine only).
rem #		ROOTKEY  [ HKLM | HKCU | HKCR | HKU | HKCC ]
rem #		SubKey   The full name of a registry key under the selected ROOTKEY.
rem #
rem #		FileName   The name of the disk file to export.
rem #		/y       Force overwriting the existing file without prompt.
rem #		/reg:32  Specifies the key should be accessed using the 32-bit registry view.
rem #		/reg:64  Specifies the key should be accessed using the 64-bit registry view.
rem #
rem #	Examples:
rem #		'REG EXPORT HKLM/Software/MyCo/MyApp AppBkUp.reg'
rem #		Exports all subkeys and values of the key MyApp to the file AppBkUp.reg
rem #
:dk_registryBackup
%setlocal%

	set "REG_BACKUP_DIR=%CD:\=/%/REGISTRY_BACKUP"
	%dk_call% dk_echo "REG_BACKUP_DIR = %REG_BACKUP_DIR%"
	%dk_call% dk_mkdir "%REG_BACKUP_DIR%"
	
	%dk_call% dk_validate reg.exe %dk_call% dk_findFile reg.exe
	
    "%reg.exe:/=\%" export HKLM %REG_BACKUP_DIR:/=\%\HKLM.reg
	"%reg.exe:/=\%" export HKCU %REG_BACKUP_DIR:/=\%\HKCU.reg
	"%reg.exe:/=\%" export HKCR %REG_BACKUP_DIR:/=\%\HKCR.reg
	"%reg.exe:/=\%" export HKU  %REG_BACKUP_DIR:/=\%\HKU.reg
	"%reg.exe:/=\%" export HKCC %REG_BACKUP_DIR:/=\%\HKCC.reg
	
	%dk_call% dk_success "Registry Backup Complete"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_registryBackup
%endfunction%
