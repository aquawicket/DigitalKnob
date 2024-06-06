@echo off
call ../../../DKBatch/functions/DK.cmd


call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
call dk_validate NOTEPADPP_EXE "call %DKIMPORTS_DIR%\notepadpp\dk_installNotepadpp"
call dk_addContextMenu "Edit with Notepad++" "%NOTEPADPP_EXE%" "\"%NOTEPADPP_EXE%\" \"%%%%%%%%1\""
