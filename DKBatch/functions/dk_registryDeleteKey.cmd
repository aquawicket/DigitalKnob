@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#################################################################################
:: dk_registryDeleteKey() <reg_path>
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
setlocal
    %dk_call% dk_debugFunc 1

    %dk_call% dk_registryKeyExists "%~1" || %dk_call% dk_warning "%~1 does not exist"
    
    echo "%SystemRoot%\System32\reg.exe" delete "%~1" /f
    "%SystemRoot%\System32\reg.exe" delete "%~1" /f
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt"
%endfunction%
