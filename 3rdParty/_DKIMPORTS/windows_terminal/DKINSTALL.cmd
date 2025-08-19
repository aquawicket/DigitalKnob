@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
::#     https://github.com/microsoft/terminal
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0	
	
	%dk_call% dk_getFileParams "%~dp0/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	set "WINDOWS_TERMINAL_IMPORT=!Windows_Terminal_%Host_Tuple%_Import!"
	%dk_call% dk_assertVar WINDOWS_TERMINAL_IMPORT
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables %WINDOWS_TERMINAL_IMPORT% ROOT %DKTOOLS_DIR%
	%dk_call% dk_assertVar WINDOWS_TERMINAL
	
	set "WINDOWS_TERMINAL_EXE=%WINDOWS_TERMINAL%/wt.exe"
	if EXIST "%WINDOWS_TERMINAL_EXE%" (%return%)
	
	%dk_call% dk_echo  
    %dk_call% dk_info "Installing Windows Terminal . . ."
    %dk_call% dk_download %WINDOWS_TERMINAL_IMPORT%
    %dk_call% dk_smartExtract "%dk_download%" "%WINDOWS_TERMINAL%"
	%dk_call% dk_assertFile "%WINDOWS_TERMINAL_EXE%"

%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%

