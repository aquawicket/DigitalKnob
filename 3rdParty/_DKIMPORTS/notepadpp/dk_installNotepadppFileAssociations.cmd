@echo off
call ../../../DKBatch/functions/DK.cmd


call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
call dk_validate NOTEPADPP_EXE "call %DKIMPORTS_DIR%\notepadpp\dk_installNotepadpp"

call dk_setFileAssoc .1 %NOTEPADPP_EXE%
call dk_setFileAssoc .2 %NOTEPADPP_EXE%
call dk_setFileAssoc .3 %NOTEPADPP_EXE%
call dk_setFileAssoc . %NOTEPADPP_EXE%
call dk_setFileAssoc .androidproj %NOTEPADPP_EXE%
call dk_setFileAssoc .backup %NOTEPADPP_EXE%
call dk_setFileAssoc .bak %NOTEPADPP_EXE%
call dk_setFileAssoc .c %NOTEPADPP_EXE%
call dk_setFileAssoc .cmake %NOTEPADPP_EXE%
call dk_setFileAssoc .cpp %NOTEPADPP_EXE%
call dk_setFileAssoc .css %NOTEPADPP_EXE%
call dk_setFileAssoc .data %NOTEPADPP_EXE%
call dk_setFileAssoc .gitattributes %NOTEPADPP_EXE%
call dk_setFileAssoc .gitconfig %NOTEPADPP_EXE%
call dk_setFileAssoc .glsl %NOTEPADPP_EXE%
call dk_setFileAssoc .gradle %NOTEPADPP_EXE%
call dk_setFileAssoc .h %NOTEPADPP_EXE%
call dk_setFileAssoc .htm %NOTEPADPP_EXE%
call dk_setFileAssoc .html %NOTEPADPP_EXE%
call dk_setFileAssoc .java %NOTEPADPP_EXE%
call dk_setFileAssoc .js %NOTEPADPP_EXE%
call dk_setFileAssoc .json %NOTEPADPP_EXE%
call dk_setFileAssoc .make %NOTEPADPP_EXE%
call dk_setFileAssoc .marks %NOTEPADPP_EXE%
call dk_setFileAssoc .md %NOTEPADPP_EXE%
call dk_setFileAssoc .mk %NOTEPADPP_EXE%
call dk_setFileAssoc .php %NOTEPADPP_EXE%
call dk_setFileAssoc .plist %NOTEPADPP_EXE%
call dk_setFileAssoc .pro %NOTEPADPP_EXE%
call dk_setFileAssoc .properties %NOTEPADPP_EXE%
call dk_setFileAssoc .ps1 %NOTEPADPP_EXE%
call dk_setFileAssoc .rc %NOTEPADPP_EXE%
call dk_setFileAssoc .reference %NOTEPADPP_EXE%
call dk_setFileAssoc .rsp %NOTEPADPP_EXE%
call dk_setFileAssoc .sed %NOTEPADPP_EXE%
call dk_setFileAssoc .sh %NOTEPADPP_EXE%
call dk_setFileAssoc .storyboard %NOTEPADPP_EXE%
call dk_setFileAssoc .targets %NOTEPADPP_EXE%
call dk_setFileAssoc .traineddata %NOTEPADPP_EXE%
call dk_setFileAssoc .ts %NOTEPADPP_EXE%
call dk_setFileAssoc .ts %NOTEPADPP_EXE%
call dk_setFileAssoc .txt %NOTEPADPP_EXE%
call dk_setFileAssoc .xml %NOTEPADPP_EXE%
