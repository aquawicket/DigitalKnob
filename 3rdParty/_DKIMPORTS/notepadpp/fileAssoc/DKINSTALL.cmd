@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate notepadpp_exe "%dk_call% dk_depend notepadpp"
	%dk_call% dk_installFileAssoc .1 %notepadpp_exe%
	%dk_call% dk_installFileAssoc .2 %notepadpp_exe%
	%dk_call% dk_installFileAssoc .3 %notepadpp_exe%
	%dk_call% dk_installFileAssoc . %notepadpp_exe%
	%dk_call% dk_installFileAssoc .androidproj %notepadpp_exe%
	%dk_call% dk_installFileAssoc .backup %notepadpp_exe%
	%dk_call% dk_installFileAssoc .bak %notepadpp_exe%
	%dk_call% dk_installFileAssoc .c %notepadpp_exe%
	%dk_call% dk_installFileAssoc .cmake %notepadpp_exe%
	%dk_call% dk_installFileAssoc .cpp %notepadpp_exe%
	%dk_call% dk_installFileAssoc .css %notepadpp_exe%
	%dk_call% dk_installFileAssoc .data %notepadpp_exe%
	%dk_call% dk_installFileAssoc .gitattributes %notepadpp_exe%
	%dk_call% dk_installFileAssoc .gitconfig %notepadpp_exe%
	%dk_call% dk_installFileAssoc .glsl %notepadpp_exe%
	%dk_call% dk_installFileAssoc .gradle %notepadpp_exe%
	%dk_call% dk_installFileAssoc .h %notepadpp_exe%
	%dk_call% dk_installFileAssoc .htm %notepadpp_exe%
	%dk_call% dk_installFileAssoc .html %notepadpp_exe%
	%dk_call% dk_installFileAssoc .java %notepadpp_exe%
	%dk_call% dk_installFileAssoc .js %notepadpp_exe%
	%dk_call% dk_installFileAssoc .json %notepadpp_exe%
	%dk_call% dk_installFileAssoc .make %notepadpp_exe%
	%dk_call% dk_installFileAssoc .marks %notepadpp_exe%
	%dk_call% dk_installFileAssoc .md %notepadpp_exe%
	%dk_call% dk_installFileAssoc .mk %notepadpp_exe%
	%dk_call% dk_installFileAssoc .php %notepadpp_exe%
	%dk_call% dk_installFileAssoc .plist %notepadpp_exe%
	%dk_call% dk_installFileAssoc .pro %notepadpp_exe%
	%dk_call% dk_installFileAssoc .properties %notepadpp_exe%
	::%dk_call% dk_installFileAssoc .ps1 %notepadpp_exe%
	%dk_call% dk_installFileAssoc .rc %notepadpp_exe%
	%dk_call% dk_installFileAssoc .reference %notepadpp_exe%
	%dk_call% dk_installFileAssoc .rsp %notepadpp_exe%
	%dk_call% dk_installFileAssoc .sed %notepadpp_exe%
	::%dk_call% dk_installFileAssoc .sh %notepadpp_exe%
	%dk_call% dk_installFileAssoc .storyboard %notepadpp_exe%
	%dk_call% dk_installFileAssoc .targets %notepadpp_exe%
	%dk_call% dk_installFileAssoc .traineddata %notepadpp_exe%
	%dk_call% dk_installFileAssoc .ts %notepadpp_exe%
	%dk_call% dk_installFileAssoc .ts %notepadpp_exe%
	%dk_call% dk_installFileAssoc .txt %notepadpp_exe%
	%dk_call% dk_installFileAssoc .xml %notepadpp_exe%
%endfunction%
