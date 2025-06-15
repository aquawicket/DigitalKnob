@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
    if defined Linux_Arm64_Host		(set "NODEJS_IMPORT=%NodeJS_Linux_Arm64_Import%")
    if defined Linux_X86_64_Host	(set "NODEJS_IMPORT=%NodeJS_Linux_X86_64_Import%")
    if defined Mac_Arm64_Host		(set "NODEJS_IMPORT=%NodeJS_Mac_Arm64_Import%")
	if defined Mac_X86_64_Host		(set "NODEJS_IMPORT=%NodeJS_Mac_X86_64_Import%")
    if defined Windows_X86_Host		(set "NODEJS_IMPORT=%NodeJS_Windows_X86_Import%")
    if defined Windows_X86_64_Host	(set "NODEJS_IMPORT=%NodeJS_Windows_X86_64_Import%")
	%dk_call% dk_assertVar NODEJS_IMPORT
	
	%dk_call% dk_importVariables %NODEJS_IMPORT%
	%dk_call% dk_assertVar NODEJS
	
    %dk_call% dk_set NODEJS_EXE "%NODEJS%/node.exe"
    if exist "%NODEJS_EXE%" (%return%)
	
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
