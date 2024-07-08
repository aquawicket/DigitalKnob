@echo off
call ..\..\..\DKBatch\functions\DK.cmd

call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
call dk_validate POWERSHELL_EXE "call %DKIMPORTS_DIR%\powershell\dk_uninstallPowershell"

::call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ps1"
::call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.psm1"
::ftype dkpowershell=%POWERSHELL_EXE% "%%1"
::assoc .ps1=dkpowershell
::assoc .psm1=dkpowershell
call dk_uninstallFileAssoc .ps1 %POWERSHELL_EXE%
call dk_uninstallFileAssoc .psm1 %POWERSHELL_EXE%
