@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\")
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_installNotepadppFileAssociations()
::#
:dk_installNotepadppFileAssociations
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate NOTEPADPP_EXE "%dk_call% %DKIMPORTS_DIR%\notepadpp\dk_install.cmd"
	%dk_call% dk_installFileAssoc .1 %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .2 %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .3 %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc . %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .androidproj %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .backup %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .bak %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .c %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .cmake %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .cpp %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .css %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .data %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .gitattributes %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .gitconfig %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .glsl %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .gradle %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .h %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .htm %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .html %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .java %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .js %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .json %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .make %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .marks %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .md %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .mk %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .php %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .plist %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .pro %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .properties %NOTEPADPP_EXE%
	::%dk_call% dk_installFileAssoc .ps1 %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .rc %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .reference %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .rsp %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .sed %NOTEPADPP_EXE%
	::%dk_call% dk_installFileAssoc .sh %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .storyboard %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .targets %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .traineddata %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .ts %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .ts %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .txt %NOTEPADPP_EXE%
	%dk_call% dk_installFileAssoc .xml %NOTEPADPP_EXE%
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	setlocal
	%dk_call% dk_debugFunc 0
	
    %dk_call% dk_installNotepadppFileAssociations
%endfunction%
