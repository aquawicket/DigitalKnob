@echo off
call ../../../DKBatch/functions/DK.cmd


call dk_validate DKIMPORTS_DIR dk_validateBranch
call dk_validate GIT_EXE "call %DKIMPORTS_DIR%\git\dk_installGit"

call dk_setFileAssoc .sh %GIT_EXE%
call dk_setFileAssoc .bash %GIT_EXE%

call dk_info "complete"
pause