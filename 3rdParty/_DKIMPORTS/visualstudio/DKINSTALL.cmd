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
	
	%dk_call% dk_validate DKIMPORTS_DIR    "%dk_call% dk_DKIMPORTS_DIR"
	
	%dk_call% dk_validate git_exe          "%dk_call% dk_depend git"
	%dk_call% dk_validate gitbash_exe      "%dk_call% dk_depend git"
	%dk_call% dk_installContextMenu "GIT ADD" "%gitbash_exe%" "\"%git_exe:/=\%\" add \"%%%%%%%%1\""
	
	::%dk_call% dk_validate bash_exe       "%dk_call% dk_depend git"
	::%dk_call% dk_installContextMenu "GIT ADD" "%bash_exe%" "\"%git_exe:/=\%\" add \"%%%%1\""
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
    %dk_call% DKINSTALL
%endfunction%
