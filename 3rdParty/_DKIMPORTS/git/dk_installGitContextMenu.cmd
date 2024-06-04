@echo off
call ../../../DKBatch/functions/DK.cmd


call dk_validate DKIMPORTS_DIR dk_validateBranch
call dk_validate GIT_EXE "call %DKIMPORTS_DIR%\git\dk_installGit"

::echo Adding 'GIT ADD' context menu to Windows using GIT_EXE: @ %GIT_EXE%
::REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\GITADD" /ve /d "&GIT ADD" /f
::REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\GITADD" /v Icon /t REG_SZ /d "imageres.dll,-5324" /f
::REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\GITADD\command" /ve /d "\"%GIT_EXE%\" add \"%%1\"" /f

call dk_validate DKIMPORTS_DIR dk_validateBranch
call dk_validate GIT_EXE "call %DKIMPORTS_DIR%\git\dk_installGit"
call dk_addContextMenu "GITADD" "GIT ADD" "%GIT_EXE%"

call dk_info "complete"
pause