@echo off
call ../../../DKBatch/functions/DK.cmd


call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
call dk_validate NOTEPADPP_EXE "call %DKIMPORTS_DIR%\notepadpp\dk_installNotepadpp"

call dk_installFileAssoc .1 %NOTEPADPP_EXE%
call dk_installFileAssoc .2 %NOTEPADPP_EXE%
call dk_installFileAssoc .3 %NOTEPADPP_EXE%
call dk_installFileAssoc . %NOTEPADPP_EXE%
call dk_installFileAssoc .androidproj %NOTEPADPP_EXE%
call dk_installFileAssoc .backup %NOTEPADPP_EXE%
call dk_installFileAssoc .bak %NOTEPADPP_EXE%
call dk_installFileAssoc .c %NOTEPADPP_EXE%
call dk_installFileAssoc .cmake %NOTEPADPP_EXE%
call dk_installFileAssoc .cpp %NOTEPADPP_EXE%
call dk_installFileAssoc .css %NOTEPADPP_EXE%
call dk_installFileAssoc .data %NOTEPADPP_EXE%
call dk_installFileAssoc .gitattributes %NOTEPADPP_EXE%
call dk_installFileAssoc .gitconfig %NOTEPADPP_EXE%
call dk_installFileAssoc .glsl %NOTEPADPP_EXE%
call dk_installFileAssoc .gradle %NOTEPADPP_EXE%
call dk_installFileAssoc .h %NOTEPADPP_EXE%
call dk_installFileAssoc .htm %NOTEPADPP_EXE%
call dk_installFileAssoc .html %NOTEPADPP_EXE%
call dk_installFileAssoc .java %NOTEPADPP_EXE%
call dk_installFileAssoc .js %NOTEPADPP_EXE%
call dk_installFileAssoc .json %NOTEPADPP_EXE%
call dk_installFileAssoc .make %NOTEPADPP_EXE%
call dk_installFileAssoc .marks %NOTEPADPP_EXE%
call dk_installFileAssoc .md %NOTEPADPP_EXE%
call dk_installFileAssoc .mk %NOTEPADPP_EXE%
call dk_installFileAssoc .php %NOTEPADPP_EXE%
call dk_installFileAssoc .plist %NOTEPADPP_EXE%
call dk_installFileAssoc .pro %NOTEPADPP_EXE%
call dk_installFileAssoc .properties %NOTEPADPP_EXE%
::call dk_installFileAssoc .ps1 %NOTEPADPP_EXE%
call dk_installFileAssoc .rc %NOTEPADPP_EXE%
call dk_installFileAssoc .reference %NOTEPADPP_EXE%
call dk_installFileAssoc .rsp %NOTEPADPP_EXE%
call dk_installFileAssoc .sed %NOTEPADPP_EXE%
::call dk_installFileAssoc .sh %NOTEPADPP_EXE%
call dk_installFileAssoc .storyboard %NOTEPADPP_EXE%
call dk_installFileAssoc .targets %NOTEPADPP_EXE%
call dk_installFileAssoc .traineddata %NOTEPADPP_EXE%
call dk_installFileAssoc .ts %NOTEPADPP_EXE%
call dk_installFileAssoc .ts %NOTEPADPP_EXE%
call dk_installFileAssoc .txt %NOTEPADPP_EXE%
call dk_installFileAssoc .xml %NOTEPADPP_EXE%
