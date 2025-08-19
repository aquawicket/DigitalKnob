@echo off&::###### DK.cmd #########################################################################################################################
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
	set "NODEJS_IMPORT=!NodeJS_%Host_Tuple%_Import!"
	%dk_call% dk_assertVar NODEJS_IMPORT
	
	%dk_call% dk_importVariables %NODEJS_IMPORT%
	%dk_call% dk_assertVar NODEJS
	
    %dk_call% dk_set NODEJS_EXE "%NODEJS%/node.exe"
    if EXIST "%NODEJS_EXE%" (%return%)
	
    %dk_call% dk_echo
    %dk_call% dk_info "Installing NodeJS . . ."
    %dk_call% dk_download "%NODEJS_IMPORT%"
	%dk_call% dk_smartExtract "%dk_download%" "%NODEJS%"
	%dk_call% dk_assertPath NODEJS_EXE
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% DKINSTALL
%endfunction%
