@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::##################################################################################
::# dk_gitCheckRemote()
::#
::#
:dk_gitCheckRemote
%setlocal%
	%dk_call% dk_debugFunc 0

    %dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    if NOT EXIST "%DKBRANCH_DIR%\.git" (%dk_call% dk_warning "%DKBRANCH_DIR%/.git does NOT EXIST" && %return%)

	%dk_call% dk_validate git_exe "%dk_call% dk_depend git"

	"%git_exe%" -C %DKBRANCH_DIR% remote update
   
    %dk_call% dk_exec "%git_exe%" -C %DKBRANCH_DIR% rev-parse --abbrev-ref HEAD
	set "branch=%dk_exec%"
    %dk_call% dk_exec "%git_exe%" -C %DKBRANCH_DIR% rev-list --count origin/%branch%..%branch%
	set "ahead=%dk_exec%"
    %dk_call% dk_exec "%git_exe%" -C %DKBRANCH_DIR% rev-list --count %branch%..origin/%branch%
	set "behind=%dk_exec%"

    %dk_call% dk_echo "%ahead% commits ahead, %behind% commits behind"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    %dk_call% dk_gitCheckRemote
%endfunction%
