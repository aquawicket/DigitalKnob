@echo off
call ../../../DKBatch/functions/DK.cmd


call dk_validate DKIMPORTS_DIR dk_validateBranch
call dk_validate GITBASH_EXE "call %DKIMPORTS_DIR%\git\dk_installGit"

::call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.sh"
::ftype dk_gitbash=%GITBASH_EXE% "%%1"
::assoc .sh=dk_gitbash
call dk_printVar GITBASH_EXE
call dk_setFileAssoc .sh %GITBASH_EXE%

echo done
call dk_pause
