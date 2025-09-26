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
	
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	set "nodejs_Import=!NodeJS_%Host_Tuple%_Import!"
	%dk_call% dk_assertVar nodejs_Import
	
	%dk_call% dk_importVariables %nodejs_Import%
	%dk_call% dk_assertVar nodejs
	
    %dk_call% dk_set nodejs_exe "%nodejs%/node.exe"
    if EXIST "%nodejs_exe%" (%return%)
	
    %dk_call% dk_echo
    %dk_call% dk_info "Installing NodeJS . . ."
    %dk_call% dk_download "%nodejs_Import%"
	%dk_call% dk_smartExtract "%dk_download%" "%nodejs%"
	%dk_call% dk_assertPath nodejs_exe
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% DKINSTALL
%endfunction%
