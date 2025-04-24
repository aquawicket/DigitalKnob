<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#################################################################################
:: dk_registryDeleteKey() <reg_path>
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::#################################################################################
:: dk_registryDeleteKey(reg_path)
>>>>>>> Development
::
:: reg.exe /? 
::  REG DELETE KeyName [/v ValueName | /ve | /va] [/f] [/reg:32 | /reg:64]
::
::  KeyName    [\\Machine\]FullKey
::    Machine  Name of remote machine - omitting defaults to the current machine.
::             Only HKLM and HKU are available on remote machines.
::    FullKey  ROOTKEY\SubKey
::    ROOTKEY  [ HKLM | HKCU | HKCR | HKU | HKCC ]
::    SubKey   The full name of a registry key under the selected ROOTKEY.
::
::  ValueName  The value name, under the selected Key, to delete.
::             When omitted, all subkeys and values under the Key are deleted.
::
::  /ve        delete the value of empty value name (Default).
::
::  /va        delete all values under this key.
::
::  /f         Forces the deletion without prompt.
::
::  /reg:32    Specifies the key should be accessed using the 32-bit registry
::             view.
::
::  /reg:64    Specifies the key should be accessed using the 64-bit registry
::             view.
::
::  Examples:
::
::  REG DELETE HKLM\Software\MyCo\MyApp\Timeout
::    Deletes the registry key Timeout and all its subkeys and values
::
::  REG DELETE \\ZODIAC\HKLM\Software\MyCo /v MTU
::    Deletes the registry value MTU under MyCo on ZODIAC
::
:dk_registryDeleteKey
<<<<<<< HEAD
 setlocal
    call dk_debugFunc 1

    %dk_call% dk_registryKeyExists "%~1" || %dk_call% dk_warning "%~1 does not exist"
    
    echo "%SystemRoot%\System32\reg.exe" delete "%~1" /f
    "%SystemRoot%\System32\reg.exe" delete "%~1" /f
=======
setlocal
    %dk_call% dk_debugFunc 1

	set "_reg_path_=%~1"
	
    %dk_call% dk_registryKeyExists "%_reg_path_%" || (
		%dk_call% dk_warning "dk_registryDeleteKey: _reg_path_:%_reg_path_% does not exist"
		%return%
	)
    
	%dk_call% dk_validate REG_EXE "%dk_call% dk_REG_EXE"
	
    "%REG_EXE%" delete "%_reg_path_:/=\%" /f

>>>>>>> Development
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal

    %dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt"
=======
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_registryDeleteKey "NonExistant"
    %dk_call% dk_registryDeleteKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.txt"
>>>>>>> Development
%endfunction%
