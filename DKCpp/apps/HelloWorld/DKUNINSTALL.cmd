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
	
	%dk_call% dk_validate GIT_EXE "%dk_call% dk_depend git"
	set myCommand=%GIT_EXE% clean -fdn %CD%
	%dk_call% dk_exec !myCommand!
	%dk_call% dk_printVar dk_exec_stdout
	%dk_call% dk_printVar dk_exec
	%dk_call% dk_printVar dk_exec_exitcode
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	call :DKUNINSTALL
%endfunction%