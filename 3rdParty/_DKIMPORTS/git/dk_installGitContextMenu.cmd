@echo off
call ../../../DKBatch/functions/DK.cmd


call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
call dk_validate GIT_EXE "call %DKIMPORTS_DIR%\git\dk_installGit"
call dk_installContextMenu "GIT ADD" "%GITBASH_EXE%" "\"%GIT_EXE%\" add \"%%%%%%%%1\""
