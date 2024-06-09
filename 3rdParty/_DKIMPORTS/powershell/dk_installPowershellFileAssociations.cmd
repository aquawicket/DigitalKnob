@echo off
call ../../../DKBatch/functions/DK.cmd

call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
call dk_validate POWERSHELL_EXE "call %DKIMPORTS_DIR%\powershell\dk_installPowershell"

::call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ps1"
::call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.psm1"
::ftype dk_powershell=%POWERSHELL_EXE% "%%1"
::assoc .ps1=dk_powershell
::assoc .psm1=dk_powershell
call dk_installFileAssoc .ps1 %POWERSHELL_EXE%
call dk_installFileAssoc .psm1 %POWERSHELL_EXE%
