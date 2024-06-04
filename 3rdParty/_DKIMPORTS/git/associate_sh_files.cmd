@echo off
call ../../../DKBatch/functions/DK.cmd

call dk_validate DKIMPORTS_DIR dk_validateBranch
call dk_validate GITBASH_EXE "call %DKIMPORTS_DIR%\git\dk_installGit"

::call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ps1"
::call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.psm1"
::ftype dk_powershell=%POWERSHELL_EXE% "%%1"
::assoc .ps1=dk_powershell
::assoc .psm1=dk_powershell
call dk_printVar GITBASH_EXE
call dk_setFileAssoc .sh %GITBASH_EXE%

echo done
call dk_pause
