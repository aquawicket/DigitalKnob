@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
::setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR    "%dk_call% dk_DKIMPORTS_DIR"
	
	%dk_call% dk_validate GIT_EXE          "%dk_call% dk_installGit"
	%dk_call% dk_validate GITBASH_EXE      "%dk_call% dk_installGit"
	%dk_call% dk_installContextMenu "GIT ADD" "%GITBASH_EXE%" "\"%GIT_EXE:/=\%\" add \"%%%%%%%%1\""
	
	::%dk_call% dk_validate BASH_EXE       "%dk_call% %DKIMPORTS_DIR%\git\DKINSTALL.cmd"
	::%dk_call% dk_installContextMenu "GIT ADD" "%BASH_EXE%" "\"%GIT_EXE:/=\%\" add \"%%%%1\""
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
    %dk_call% DKINSTALL
%endfunction%
