@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKUNINSTALL
::#
:DKUNINSTALL
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
    echo %dk_call% dk_exec %GIT_EXE% clean %~dp0
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	call :DKUNINSTALL
%endfunction%