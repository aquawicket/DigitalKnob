@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_install()
::#
:dk_install
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate git_exe		"%dk_call% dk_depend git"
	%dk_call% dk_validate GIT_BASH_EXE  "%dk_call% dk_depend git"
	%dk_call% dk_installContextMenu "Git Add" "%GIT_BASH_EXE%" "\"%git_exe:/=\%\" add \"%%%%%%%%1\""
	%dk_call% dk_installContextMenu "Git Clean" "%GIT_BASH_EXE%" "\"%git_exe:/=\%\" clean -d -x -f \"%%%%%%%%1\""
	
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
    call :dk_install
%endfunction%
