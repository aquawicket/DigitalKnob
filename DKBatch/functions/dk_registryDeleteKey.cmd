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


rem #################################################################################
rem dk_registryDeleteKey(reg_path)
rem 
rem reg.exe /?
rem  REG DELETE KeyName [/v ValueName | /ve | /va] [/f] [/reg:32 | /reg:64]
rem 
rem  KeyName    [\\Machine\]FullKey
rem    Machine  Name of remote machine - omitting defaults to the current machine.
rem             Only HKLM and HKU are available on remote machines.
rem    FullKey  ROOTKEY\SubKey
rem    ROOTKEY  [ HKLM | HKCU | HKCR | HKU | HKCC ]
rem    SubKey   The full name of a registry key under the selected ROOTKEY.
rem 
rem  ValueName  The value name, under the selected Key, to delete.
rem             When omitted, all subkeys and values under the Key are deleted.
rem 
rem  /ve        delete the value of empty value name (Default).
rem 
rem  /va        delete all values under this key.
rem 
rem  /f         Forces the deletion without prompt.
rem 
rem  /reg:32    Specifies the key should be accessed using the 32-bit registry
rem             view.
rem 
rem  /reg:64    Specifies the key should be accessed using the 64-bit registry
rem             view.
rem 
rem  Examples:
rem 
rem  REG DELETE HKLM\Software\MyCo\MyApp\Timeout
rem    Deletes the registry key Timeout and all its subkeys and values
rem 
rem  REG DELETE \\ZODIAC\HKLM\Software\MyCo /v MTU
rem    Deletes the registry value MTU under MyCo on ZODIAC
rem 
:dk_registryDeleteKey
%setlocal%

	set "_reg_path_=%~1"
	
    %dk_call% dk_registryKeyExists "%_reg_path_%" || (
		%dk_call% dk_warning "dk_registryDeleteKey: _reg_path_:'%_reg_path_%' NOT FOUND"
		%return%
	)
   
	%dk_call% dk_validate reg.exe %dk_call% dk_findFile reg.exe
	
    "%reg.exe:/=\%" delete "%_reg_path_:/=\%" /f

%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_registryDeleteKey "NonExistant"
    %dk_call% dk_registryDeleteKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.txt"
%endfunction%
